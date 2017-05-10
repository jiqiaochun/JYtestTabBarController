//
//  testFourViewController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "testFourViewController.h"
#import "JYTabBarController.h"
#import "JYTabBarItem.h"
#import "testDetailViewController.h"

@implementation testFourViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"Four";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.jy_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.jy_tabBarItem setBadgeValue:@"2"];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick{
    testDetailViewController *viewController = [[testDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
