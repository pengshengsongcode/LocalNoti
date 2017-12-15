//
//  AppDelegate.m
//  本地通知
//
//  Created by 彭盛凇 on 2017/12/15.
//  Copyright © 2017年 huangbaoche. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //打开app时候,消除掉badge
    [application setApplicationIconBadgeNumber:0];
    
    
    if (@available(iOS 10.0, *)) {
        
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            
        }];
    } else {
        // Fallback on earlier versions
        
        // iOS8以后 本地通知必须注册(获取权限)
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        
        [application registerUserNotificationSettings:settings];
        if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 如果这个key有值,代表是杀死的程序接收到本地通知跳转
            
            // 根据这种方式查看launchOptions的内容
            UILabel *infoLabel = [[UILabel alloc] init];
            infoLabel.frame = CGRectMake(0, 0, 300, 300);
            infoLabel.backgroundColor = [UIColor yellowColor];
            infoLabel.numberOfLines = 0;
            infoLabel.font = [UIFont systemFontOfSize:10];
            infoLabel.text = [NSString stringWithFormat:@"%@",launchOptions];
            [self.window.rootViewController.view addSubview:infoLabel];
            
            
            NSLog(@"跳转到指定页面");
        }

    }
    
    return YES;
}

/**
 app在前台收到本地通知调用或者在home情况下点击通知进入前台调用
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [application setApplicationIconBadgeNumber:0];
    
    NSLog(@"收到本地通知");
    // 可以让用户跳转到指定界面 app在前台接收到通知直接跳转界面不太好,所以要判断一下,是从后台进入前台还是本身就在前台
    if (application.applicationState == UIApplicationStateInactive) {// 进入前台时候
        NSLog(@"跳转到指定界面");
        
        // 如果接收到不同的通知,跳转到不同的界面:
        NSLog(@"%@", notification.userInfo); //通知的额外信息,根据设置的通知的额外信息确定
        
    }
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler  {
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    }
    
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
}

@end
