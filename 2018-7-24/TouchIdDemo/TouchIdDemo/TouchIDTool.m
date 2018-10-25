//
//  TouchIDTool.m
//  TouchIdDemo
//
//  Created by 吉腾蛟 on 2018/7/24.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "TouchIDTool.h"

@implementation TouchIDTool


+(void)authenTouchIDWithSuccess:(void(^)(void))successBlock andfailure:(void(^)(NSInteger errorCode,NSString* errorReason))failureBlock{
    //创建LAContext实例，用于请求TouchID
    LAContext *context=[[LAContext alloc] init];
    
    //存储失败结果
    NSError *error=nil;
    __block NSString *errorReason=nil;
    
    //判断是否可以使用TouchID
    //当可以使用TouchID验证，则亲求使用TouchID
    
    BOOL canuseTouchID=[context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canuseTouchID) {
        NSLog(@"可以使用TouchID");
        
        //请求使用TouchID
        //policy：请求验证的策略类型
        //localizedReason：提示给用户的需要验证指纹的原因
        //reply：系统返回的验证结果
        
        [context evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请输入指纹来验证身份" reply:^(BOOL success, NSError * _Nullable error) {
            //返回验证结果
            if (success) {
                NSLog(@"验证成功");
                //返回给方法调用者验证成功的结果
                //调用block时切换回主线程
                if (successBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock();
                    });
                }
            }else{
                NSLog(@"验证失败");
                switch (error.code) {
                    case kLAErrorAuthenticationFailed:
                        errorReason=@"用户校验失败";//输入了错误的指纹
                        break;
                    case kLAErrorUserCancel:
                        errorReason=@"用户取消校验";//当用户点击了取消按钮
                        break;
                    case kLAErrorUserFallback:
                        errorReason=@"用户回退校验败";//用户选择使用密码校验
                        break;
                    case kLAErrorSystemCancel:
                        errorReason=@"系统取消校验";//TouchID校验被系统中断
                        break;
                    case kLAErrorAppCancel:
                        errorReason=@"应用取消校验";//应用主动取消校验
                        break;
                    case kLAErrorTouchIDLockout:
                        errorReason=@"TouchID失败次数过多，已锁定";//发生此类错误后，需要输入设备密码恢复TouchID功能
                        break;
                    case kLAErrorInvalidContext:
                        errorReason=@"LAContext对象被意外释放";
                        break;
                        
                        
                    default:
                        errorReason=@"验证失败";
                        break;
                }
                NSLog(@"%@",errorReason);
                //返回给方法调用着失败的结果
                if (failureBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failureBlock(error.code,errorReason);
                    });
                }
            }
        }];
    }else{
        NSLog(@"不可以使用TouchID");
        //错误原因存储在error.code中
        switch (error.code) {
            case kLAErrorPasscodeNotSet:
                errorReason=@"用户没有设置密码";
                break;
            case kLAErrorTouchIDNotAvailable:
                errorReason=@"TouchID功能不可用";
                break;
            case kLAErrorTouchIDNotEnrolled:
                errorReason=@"TouchID没有可用指纹";
                break;
                
            default:
                errorReason=@"不可以使用指纹验证";
                break;
        }
        NSLog(@"%@",errorReason);
        //返回给方法调用着失败的结果
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error.code,errorReason);
            });
        }
    }
    
}

@end
