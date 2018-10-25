//
//  DataPersisit.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/7.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPersisit : NSObject
+(NSString *)readValuePre:(NSString *)key;
+(void)writeValuePre:(NSString *)value key:(NSString *)key;
@end
