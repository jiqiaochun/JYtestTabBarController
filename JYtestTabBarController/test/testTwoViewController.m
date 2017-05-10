//
//  testTwoViewController.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "testTwoViewController.h"
#import "JYTabBarController.h"

@interface testTwoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@end

@implementation testTwoViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"Second";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-49)];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
}

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
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[self jy_tabBarController] setTabBarHidden:!self.jy_tabBarController.tabBarHidden animated:YES];
}

@end
