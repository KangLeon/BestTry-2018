//
//  AppDelegate.m
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "SharedMarcro.h"
#import "PUserDefault.h"
#import "BackGroundTask.h"
#import "PushHandler.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerAPNs];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *pushInfo=launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        [[PushHandler sharedInstance] handlePush:pushInfo];
    });
   

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    int times=[PUserDefault getBackGroundEnterTimes];
//    NSLog(@"%d",times);
//    times++;
//    [PUserDefault saveBackGroundEnterTimes:times];
//    [[BackGroundTask sharedInstance] beginBackgroundTask];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    int times=[PUserDefault getBackGroundEnterTimes];
//    NSLog(@"%d",times);
//    if (times>3) {
//        [self alertUserEnablPush];
//    }
}

-(void)alertUserEnablPush{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"打开通知" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction=[UIAlertAction actionWithTitle:@"打开通知" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (IS_IOS10_OR_ABOVE) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        
        //这里有个问题啊，怎么回来的时候不显示弹出框呢？而且通过根控制器弹出弹出框符合规定么？
//        [self.window.rootViewController dismissViewControllerAnimated:true completion:^{
//
//        }];
        
    }];
    UIAlertAction *nooAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:yesAction];
    [alertController addAction:nooAction];
    [self.window.rootViewController presentViewController:alertController animated:true completion:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)registerAPNs{
    if (IS_IOS10_OR_ABOVE) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate=self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge
                                                 | UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted,NSError * _Nullable error)
         {
             if(granted){
            NSLog(@"注册成功");
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings* _Nonnull settings){
                //                NSLog(@"%@",settings);
            }];
        }
         else{
             NSLog(@"注册失败");
         }
         }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }


}


//////虽然该方法已经被废弃了，但是当前没有找到替代方法，这个方法是处于后台的时候才可以push，但是该方法可以直接跳转到对应的页面
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    [[PushHandler sharedInstance] handlePush:userInfo];
//}

//该方法可以直接跳转到对应的页面，
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    //应用在前台收到通知
    NSLog(@"========%@", notification);
    //如果需要在应用在前台也展示通知
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    [[PushHandler sharedInstance] handlePush:notification.request.content.userInfo];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
//    badge = badge >= 0 ? badge : 0;
    badge = badge >= 0 ? 0 : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}



- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
     //在没有启动本App时，收到服务器推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮
    
    //点击通知进入应用
    NSLog(@"response:%@", response);
}


//静默Push下载东西的一种方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    //开始下载音乐
    
    //结束下载音乐
    
    //
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    return NSLog(@"出现错误%@",error);
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *tokenStr=[NSString stringWithFormat:@"%@",deviceToken];
    tokenStr=[tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    tokenStr=[tokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    tokenStr=[tokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"%@",tokenStr);
    
    //拿到tokenString 上传到自己的服务器上,
    
}

@end
