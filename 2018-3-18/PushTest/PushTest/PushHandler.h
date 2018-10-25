//
//  PushHandler.h
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushHandler : NSObject
@property(strong,nonatomic)UIViewController *baseViewController;

+(instancetype)sharedInstance;
-(void)handlePush:(NSDictionary*)dic;

@end
