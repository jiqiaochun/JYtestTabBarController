//
//  JYTabBarController.h
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTabBar.h"

@class JYTabBarController;

@protocol JYTabBarControllerDelegate <NSObject>

@optional
/**
 * Asks the delegate whether the specified view controller should be made active.
 */
- (BOOL)tabBarController:(JYTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

/**
 * Tells the delegate that the user selected an item in the tab bar.
 */
- (void)tabBarController:(JYTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface JYTabBarController : UIViewController <JYTabBarDelegate>

/**
 * The tab bar controller’s delegate object.
 */
@property (nonatomic, weak) id<JYTabBarControllerDelegate> delegate;

/**
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonatomic, copy) IBOutletCollection(UIViewController) NSArray *viewControllers;

/**
 * The tab bar view associated with this controller. (read-only)
 */
@property (nonatomic, readonly) JYTabBar *tabBar;

/**
 * The view controller associated with the currently selected tab item.
 */
@property (nonatomic, weak) UIViewController *selectedViewController;

/**
 * The index of the view controller associated with the currently selected tab item.
 */
@property (nonatomic) NSUInteger selectedIndex;

/**
 * A Boolean value that determines whether the tab bar is hidden.
 */
@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;

/**
 * Changes the visibility of the tab bar.
 */
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

#pragma - mark UIViewController分类
@interface UIViewController (JYTabBarControllerItem)

/**
 * The tab bar item that represents the view controller when added to a tab bar controller.
 */
@property(nonatomic, strong ,setter = jy_setTabBarItem:) JYTabBarItem *jy_tabBarItem;

/**
 * The nearest ancestor in the view controller hierarchy that is a tab bar controller. (read-only)
 */
@property(nonatomic, readonly) JYTabBarController *jy_tabBarController;


@end
