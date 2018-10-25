//
//  PUserDefault.h
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUserDefault : NSObject
+(int)getBackGroundEnterTimes;
+(void)saveBackGroundEnterTimes:(int)times;
@end
