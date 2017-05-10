//
//  UIWindow+Exension.m
//  JYtestTabBarController
//
//  Created by 姬巧春 on 16/4/21.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "UIWindow+Exension.h"
#import "JYInitViewController.h"

@implementation UIWindow (Exension)

- (void)switchRootViewController{
    
    // 获取当前的app的版本号
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 从偏好设置中读取版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefaults objectForKey:@"app_ver"];
    
    // 比较版本号，判断程序是不是第一次运行
    if ([appVersion isEqualToString:lastVersion]) {
        
        // 判断是否登录
//        if (!isLogin) {
//            LoginViewController
//        }else{
//            
//        }
        
        // 创建根控制器(JYInitViewController)
        JYInitViewController *mainVc = [[JYInitViewController alloc] init];
        
        // 将JYInitViewController设置为self.window的根控制器
        self.rootViewController = mainVc.viewController;
    }
    else
    {
        // 新特性
        
        // 创建根控制器(JYInitViewController)
        JYInitViewController *mainVc = [[JYInitViewController alloc] init];
        
        // 将JYInitViewController设置为self.window的根控制器
        self.rootViewController = mainVc.viewController;
        
    }
    
    // 把当前版本号记录下来
    [userDefaults setObject:appVersion forKey:@"app_ver"];
    [userDefaults synchronize];
}

@end
