//
//  ViewController.m
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "DiaryControllerViewController.h"
#import "PushHandler.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectAppEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [PushHandler sharedInstance].baseViewController=self;
    
}

-(void)detectAppEnterBackground{
    
    //设置category
    
    //options有一下三种
    //UNNotificationActionOptionAuthenticationRequired 需要解锁
    //UNNotificationActionOptionDestructive  显示为红色
    //UNNotificationActionOptionForeground   点击打开app
    
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"策略1行为1" options:UNNotificationActionOptionForeground];
    
//    UNTextInputNotificationAction *action2 = [UNTextInputNotificationAction actionWithIdentifier:@"action2" title:@"策略1行为2" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"回复" textInputPlaceholder:@"请输入回复内容"];
    
    //UNNotificationCategoryOptionNone
    //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
    //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
    
//    UNNotificationCategory *category1 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action2,action1]  minimalActions:@[action2,action1] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    UNNotificationCategory *category1=[UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
//    UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"action3" title:@"策略2行为1" options:UNNotificationActionOptionForeground];
//
//    UNNotificationAction *action4 = [UNNotificationAction actionWithIdentifier:@"action4" title:@"策略2行为2" options:UNNotificationActionOptionForeground];
    
    
 //  UNNotificationCategory *category2 = [UNNotificationCategory categoryWithIdentifier:@"category2" actions:@[action3,action4]  minimalActions:@[action3,action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    
//    UNNotificationCategory *category2=[UNNotificationCategory categoryWithIdentifier:@"category2" actions:@[action3,action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category1, nil]];
    
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"测试通知标题";
    content.subtitle = @"测试通知子标题";
    content.body = @"测试通知主体内容";
    content.badge = @1;
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zhiying" ofType:@"jpg"];
    // 2.设置通知附件内容
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"attachment error %@", error);
    }
    content.attachments = @[att];
    content.launchImageName = @"美女";//这里无条件显示了上面载入的图片
    content.categoryIdentifier =@"category1";
    // 2.设置声音
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    // 3.触发模式:
//    iOS 10触发器有4种
//
//    UNPushNotificationTrigger 触发APNS服务，系统自动设置（这是区分本地通知和远程通知的标识）
//    UNTimeIntervalNotificationTrigger 一段时间后触发
//    UNCalendarNotificationTrigger 指定日期触发
//    UNLocationNotificationTrigger 根据位置触发，支持进入某地或者离开某地或者都有
    
//    //十秒后
//    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
//
//    //每周日早上8：00
//    NSDateComponents *component = [[NSDateComponents alloc] init];
//    component.weekday = 1;
//    component.hour = 8;
//    UNCalendarNotificationTrigger *trigger2 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:YES];
//
//    //圆形区域，进入时候进行通知
//    CLLocationCoordinate2D cen = CLLocationCoordinate2DMake(80.335400, -90.009201);
//    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:cen
//                                                                 radius:500.0 identifier:@“center"];
//                                region.notifyOnEntry = YES; //进入的时候
//                                region.notifyOnExit = NO;   //出去的时候
//                                UNLocationNotificationTrigger *trigger3 = [UNLocationNotificationTrigger
//                                                                           triggerWithRegion:region repeats:NO];
    
    //5秒后触发通知
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    
    // 4.设置UNNotificationRequest
    NSString *requestIdentifer = @"TestRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
    
    //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
