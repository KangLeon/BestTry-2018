//
//  DataPersisit.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/7.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "DataPersisit.h"

@implementation DataPersisit
+(NSString *)readValuePre:(NSString *)key{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *value=[defaults objectForKey:key];
    return value;
}
+(void)writeValuePre:(NSString *)value key:(NSString *)key{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}
@end
