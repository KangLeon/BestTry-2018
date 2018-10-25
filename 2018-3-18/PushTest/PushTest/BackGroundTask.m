//
//  BackGroundTask.m
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "BackGroundTask.h"
#import "AppDelegate.h"

@implementation BackGroundTask

+(instancetype)sharedInstance{
    static BackGroundTask *backgroundTask=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backgroundTask=[[BackGroundTask alloc] init];
    });
    return backgroundTask;
}
-(void)beginBackgroundTask{
    //启动后台任务
    UIApplication *app=[UIApplication sharedApplication];
   __block UIBackgroundTaskIdentifier taskId=[app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:taskId];
        taskId=UIBackgroundTaskInvalid;
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            int remianingTime=app.backgroundTimeRemaining;
            if (remianingTime<=5) {
                break;
           
            }
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"%d",remianingTime);
        }
        [app endBackgroundTask:taskId];
        taskId=UIBackgroundTaskInvalid;
    });
    
}

@end
