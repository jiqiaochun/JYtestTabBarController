//
//  testOneViewController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "testOneViewController.h"
#import "JYTabBarController.h"
#import "JYTabBarItem.h"
#import "JYTabBar.h"

@implementation testOneViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"First";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.jy_tabBarItem setBadgeValue:@"3"];
    
    if (self.jy_tabBarController.tabBar.translucent) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0,
                                               0,
                                               CGRectGetHeight(self.jy_tabBarController.tabBar.frame),
                                               0);
        
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }
}

//- (NSUInteger)supportedInterfaceOrientations {
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        return UIInterfaceOrientationMaskAll;
//    } else {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        return YES;
//    }
//    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
//}

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.jy_tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
}

@end
