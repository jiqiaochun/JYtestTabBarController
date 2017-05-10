//
//  JYInitViewController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "JYInitViewController.h"
#import "JYTabBarController.h"
#import "JYTabBarItem.h"

#import "testOneViewController.h"
#import "testTwoViewController.h"
#import "testThreeViewController.h"
#import "testFourViewController.h"

@implementation JYInitViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setupViewControllers];
        
        [self customizeInterface];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)setupViewControllers {
    UIViewController *firstViewController = [[testOneViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[testTwoViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[testThreeViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *fourViewController = [[testFourViewController alloc] init];
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fourViewController];
    
    JYTabBarController *tabBarController = [[JYTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController,fourNavigationController]];
    
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(JYTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third",@"third"];
    
    NSInteger index = 0;
    for (JYTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

// UINavigationBar外观
- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
