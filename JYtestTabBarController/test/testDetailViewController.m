//
//  testDetailViewController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "testDetailViewController.h"
#import "JYTabBarController.h"

@implementation testDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
//    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Detail View Controller";
    label.frame = CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 2 * 20, 20);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.jy_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.jy_tabBarController setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

@end
