//
//  TouchIDTool.h
//  TouchIdDemo
//
//  Created by 吉腾蛟 on 2018/7/24.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDTool : NSObject

//successBlock 当TouchID验证成功时，执行方法调用者传入的成功block
//failureBlock 当TouchID不可用或验证失败时，执行方法调用者传入的失败block

+(void)authenTouchIDWithSuccess:(void(^)(void))successBlock andfailure:(void(^)(NSInteger errorCode,NSString* errorReason))failureBlock;
@end
