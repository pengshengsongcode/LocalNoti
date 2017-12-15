//
//  ViewController.m
//  本地通知
//
//  Created by 彭盛凇 on 2017/12/15.
//  Copyright © 2017年 huangbaoche. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if (@available(iOS 10.0, *)) {
        
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
        }];
        
        // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"柯梵通知";
        // 次标题
        content.subtitle = @"柯梵办公室通知";
        // 内容
        content.body = @"柯梵科技是一家以人为本，具有强烈社会责任感的公司。公司的最大愿景就是每个员工都能住上大房子，开上好车，实现逆袭高富帅、白富美的愿望。";
        
        // app显示通知数量的角标
        content.badge = @100;
        
        // 通知的提示声音，这里用的默认的声音
        content.sound = [UNNotificationSound soundNamed:@"未命名.m4a"];
        
        NSURL *imageUrl_1 = [[NSBundle mainBundle] URLForResource:@"IUV老公哟 2017-12-12 17.03.13" withExtension:@"mp4"];
        
        NSURL *imageUrl_2 = [[NSBundle mainBundle] URLForResource:@"未命名" withExtension:@"m4a"];
        
        NSURL *imageUrl_3 = [[NSBundle mainBundle] URLForResource:@"jianglai" withExtension:@"jpg"];

        
        UNNotificationAttachment *attachment_1 = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier_1" URL:imageUrl_1 options:nil error:nil];
        
        UNNotificationAttachment *attachment_2 = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier_2" URL:imageUrl_2 options:nil error:nil];

        UNNotificationAttachment *attachment_3 = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier_3" URL:imageUrl_3 options:nil error:nil];

        
        // 附件 可以是音频、图片、视频 这里是一张图片 - 数组第一个有效。。。
        content.attachments = @[attachment_2,attachment_1,attachment_3];
        
        // 标识符
        content.categoryIdentifier = @"categoryIndentifier";
        
        // 2、创建通知触发
        /* 触发器分三种：
         UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60
         UNCalendarNotificationTrigger : 在某天某时触发，可重复
         UNLocationNotificationTrigger : 进入或离开某个地理区域时触发
         */
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // 3、创建通知请求
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"KFGroupNotification" content:content trigger:trigger];
        
        // 4、将请求加入通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"已成功加推送%@",notificationRequest.identifier);
            }
        }];
        
    }else {
        
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types ==  UIUserNotificationTypeNone) {
            
        }
        
        
        /**
         其他属性: timeZone 时区
         repeatInterval 多长时间重复一次:一年,一个世纪,一天..
         region 区域 : 传入中心点和半径就可以设置一个区域 (如果进入这个区域或者出来这个区域就发出一个通知)
         regionTriggersOnce  BOOL 默认为YES, 如果进入这个区域或者出来这个区域 只会发出 一次 通知,以后就不发送了
         alertAction: 设置锁屏状态下本地通知下面的 滑动来 ...字样  默认为滑动来查看
         hasAction: alertAction的属性是否生效
         alertLaunchImage: 点击通知进入app的过程中显示图片,随便写,如果设置了(不管设置的是什么),都会加载app默认的启动图
         alertTitle: 以前项目名称所在的位置的文字: 不设置显示项目名称, 在通知内容上方
         soundName: 有通知时的音效 UILocalNotificationDefaultSoundName默认声音
         可以更改这个声音: 只要将音效导入到工程中,localNote.soundName = @"nihao.waw"
         */
        
        UILocalNotification *local = [[UILocalNotification alloc] init];
        
        //触发时间
        local.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
        
        //时区
        local.timeZone = [NSTimeZone localTimeZone];
        
        local.repeatCalendar = [NSCalendar calendarWithIdentifier:@""];
        
        local.regionTriggersOnce = YES;
        
        local.alertBody = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        
        local.hasAction = YES;
        
        local.alertAction = @"alertAction";
        
        //    local.alertLaunchImage = UILaunchImageFile;
        
        local.alertTitle = @"alertTitle";
        
        local.soundName = @"未命名.m4a";
        
        local.applicationIconBadgeNumber = 100;
        
        local.userInfo = @{@"name":@"pss"};
        
        local.category = @"";
        
        [[UIApplication sharedApplication] scheduleLocalNotification:local];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
