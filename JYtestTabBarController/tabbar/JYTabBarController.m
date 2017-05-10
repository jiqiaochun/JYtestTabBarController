//
//  JYTabBarController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYTabBarItem.h"
#import <objc/runtime.h>

@interface UIViewController (JYTabBarControllerItemInternal)

- (void)jy_setTabBarController:(JYTabBarController *)tabBarController;

@end

@interface JYTabBarController ()
{
    UIView *_contentView;
}

@property (nonatomic, readwrite) JYTabBar *tabBar;

@end

@implementation JYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self contentView]];
    [self.view addSubview:[self tabBar]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setSelectedIndex:[self selectedIndex]];
    
    [self setTabBarHidden:self.isTabBarHidden animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}

//- (NSUInteger)supportedInterfaceOrientations {
//    UIInterfaceOrientationMask orientationMask = UIInterfaceOrientationMaskAll;
//    for (UIViewController *viewController in [self viewControllers]) {
//        if (![viewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
//            return UIInterfaceOrientationMaskPortrait;
//        }
//        
//        UIInterfaceOrientationMask supportedOrientations = [viewController supportedInterfaceOrientations];
//        
//        if (orientationMask > supportedOrientations) {
//            orientationMask = supportedOrientations;
//        }
//    }
//    
//    return orientationMask;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    for (UIViewController *viewCotroller in [self viewControllers]) {
//        if (![viewCotroller respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)] ||
//            ![viewCotroller shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]) {
//            return NO;
//        }
//    }
//    return YES;
//}

#pragma mark - Methods

- (UIViewController *)selectedViewController {
    return [[self viewControllers] objectAtIndex:[self selectedIndex]];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= self.viewControllers.count) {
        return;
    }
    
    if ([self selectedViewController]) {
        [[self selectedViewController] willMoveToParentViewController:nil];
        [[[self selectedViewController] view] removeFromSuperview];
        [[self selectedViewController] removeFromParentViewController];
    }
    
    _selectedIndex = selectedIndex;
    [[self tabBar] setSelectedItem:[[self tabBar] items][selectedIndex]];
    
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
    [self addChildViewController:[self selectedViewController]];
    [[[self selectedViewController] view] setFrame:[[self contentView] bounds]];
    [[self contentView] addSubview:[[self selectedViewController] view]];
    [[self selectedViewController] didMoveToParentViewController:self];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        
        for (UIViewController *viewController in viewControllers) {
            JYTabBarItem *tabBarItem = [[JYTabBarItem alloc] init];
            [tabBarItem setTitle:viewController.title];
            [tabBarItems addObject:tabBarItem];
            [viewController jy_setTabBarController:self];
        }
        
        [[self tabBar] setItems:tabBarItems];
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController jy_setTabBarController:nil];
        }
        
        _viewControllers = nil;
    }
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    UIViewController *searchedController = viewController;
    if ([searchedController navigationController]) {
        searchedController = [searchedController navigationController];
    }
    return [[self viewControllers] indexOfObject:searchedController];
}

- (JYTabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[JYTabBar alloc] init];
        [_tabBar setBackgroundColor:[UIColor clearColor]];
        [_tabBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleRightMargin|
                                      UIViewAutoresizingFlexibleBottomMargin)];
        [_tabBar setDelegate:self];
    }
    return _tabBar;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                           UIViewAutoresizingFlexibleHeight)];
    }
    return _contentView;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    _tabBarHidden = hidden;
    
    __weak JYTabBarController *weakSelf = self;
    
    void (^block)() = ^{
        CGSize viewSize = weakSelf.view.bounds.size;
        CGFloat tabBarStartingY = viewSize.height;
        CGFloat contentViewHeight = viewSize.height;
        CGFloat tabBarHeight = CGRectGetHeight([[weakSelf tabBar] frame]);
        
        if (!tabBarHeight) {
            tabBarHeight = 49;
        }
        
        if (!hidden) {
            tabBarStartingY = viewSize.height - tabBarHeight;
            if (![[weakSelf tabBar] isTranslucent]) {
                contentViewHeight -= ([[weakSelf tabBar] minimumContentHeight] ?: tabBarHeight);
            }
            [[weakSelf tabBar] setHidden:NO];
        }
        
        [[weakSelf tabBar] setFrame:CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight)];
        [[weakSelf contentView] setFrame:CGRectMake(0, 0, viewSize.width, contentViewHeight)];
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        if (hidden) {
            [[weakSelf tabBar] setHidden:YES];
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.24 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
}

- (void)setTabBarHidden:(BOOL)hidden {
    [self setTabBarHidden:hidden animated:NO];
}

#pragma mark - RDVTabBarDelegate

- (BOOL)tabBar:(JYTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    if ([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]) {
            return NO;
        }
    }
    
    if ([self selectedViewController] == [self viewControllers][index]) {
        if ([[self selectedViewController] isKindOfClass:[UINavigationController class]]) {
            UINavigationController *selectedController = (UINavigationController *)[self selectedViewController];
            
            if ([selectedController topViewController] != [selectedController viewControllers][0]) {
                [selectedController popToRootViewControllerAnimated:YES];
            }
        }
        
        return NO;
    }
    
    return YES;
}

- (void)tabBar:(JYTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= [[self viewControllers] count]) {
        return;
    }
    
    [self setSelectedIndex:index];
    
    if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
    }
}

@end

#pragma mark - UIViewController+JYTabBarControllerItemInternal

@implementation UIViewController (JYTabBarControllerItemInternal)

- (void)jy_setTabBarController:(JYTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(jy_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end

#pragma mark - UIViewController+JYTabBarControllerItem
@implementation UIViewController (JYTabBarControllerItem)

- (JYTabBarController *)jy_tabBarController {
    JYTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(jy_tabBarController));
    
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController jy_tabBarController];
    }
    
    return tabBarController;
}

- (JYTabBarItem *)jy_tabBarItem {
    JYTabBarController *tabBarController = [self jy_tabBarController];
    NSInteger index = [tabBarController indexForViewController:self];
    return [[[tabBarController tabBar] items] objectAtIndex:index];
}

- (void)jy_setTabBarItem:(JYTabBarItem *)tabBarItem {
    JYTabBarController *tabBarController = [self jy_tabBarController];
    
    if (!tabBarController) {
        return;
    }
    
    JYTabBar *tabBar = [tabBarController tabBar];
    NSInteger index = [tabBarController indexForViewController:self];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
    [tabBarItems replaceObjectAtIndex:index withObject:tabBarItem];
    [tabBar setItems:tabBarItems];
}

@end
