//
//  BackGroundTask.h
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackGroundTask : NSObject
+(instancetype)sharedInstance;
-(void)beginBackgroundTask;
@end
