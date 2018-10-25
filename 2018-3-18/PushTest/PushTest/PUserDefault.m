//
//  PUserDefault.m
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "PUserDefault.h"

#define PUSerDefault_Key_BackgroundEnterTimes @"PUSerDefault_Key_BackgroundEnterTimes"

@implementation PUserDefault

+(void)saveBackGroundEnterTimes:(int)times{
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:PUSerDefault_Key_BackgroundEnterTimes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(int)getBackGroundEnterTimes{
    int times=0;
    times=(int)[[NSUserDefaults standardUserDefaults] integerForKey:PUSerDefault_Key_BackgroundEnterTimes];
    return times;
}

@end
