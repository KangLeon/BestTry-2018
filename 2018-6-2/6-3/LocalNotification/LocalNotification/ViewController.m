//
//  ViewController.m
//  LocalNotification
//
//  Created by 吉腾蛟 on 2018/6/3.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectAppEnterBackgrounf) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectAppEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

//探测app今日后台
-(void)detectAppEnterBackgrounf{
    //已经废弃
//    UILocalNotification *notifi=[UILocalNotification new];
//    notifi.fireDate=[NSDate dateWithTimeIntervalSinceNow:24*60*60];
//    notifi.alertBody=@"you have one day ";
//    notifi.userInfo=@{@"key":@"value"};
//    [[UIApplication sharedApplication] scheduleLocalNotification:notifi];
    UNLocationNotificationTrigger *action1=[UNNotificationAction actionWithIdentifier:@"action1" title:@"策略1行为1" options:<#(UNNotificationActionOptions)#>]
}

-(void)detectAppEnterForeground{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
