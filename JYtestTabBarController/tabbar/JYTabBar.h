//
//  JYTabBar.h
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYTabBar, JYTabBarItem;

@protocol JYTabBarDelegate <NSObject>

/**
 * Asks the delegate if the specified tab bar item should be selected.
 */
- (BOOL)tabBar:(JYTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 * Tells the delegate that the specified tab bar item is now selected.
 */
- (void)tabBar:(JYTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface JYTabBar : UIView

/**
 * The tab bar’s delegate object.
 */
@property (nonatomic, strong) id <JYTabBarDelegate> delegate;

/**
 * The items displayed on the tab bar.
 */
@property (nonatomic, strong) NSArray *items;

/**
 * The currently selected item on the tab bar.
 */
@property (nonatomic, strong) JYTabBarItem *selectedItem;

/**
 * backgroundView stays behind tabBar's items. If you want to add additional views,
 * add them as subviews of backgroundView.
 */
@property (nonatomic, readonly,strong) UIView *backgroundView;

/*
 * contentEdgeInsets can be used to center the items in the middle of the tabBar.
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * Sets the height of tab bar.
 */
- (void)setHeight:(CGFloat)height;

/**
 * Returns the minimum height of tab bar's items.
 */
- (CGFloat)minimumContentHeight;

/*
 * Enable or disable tabBar translucency. Default is NO.
 */
@property (nonatomic, getter=isTranslucent,assign) BOOL translucent;

@end
