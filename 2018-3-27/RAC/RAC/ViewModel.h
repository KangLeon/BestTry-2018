//
//  ViewModel.h
//  RAC
//
//  Created by jitengjiao      on 2018/3/27.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface ViewModel : NSObject

//保存登录界面的账号和密码
@property(nonatomic,strong) NSString *account;
@property(nonatomic,strong) NSString *pwd;

@property(nonatomic,strong,readonly)RACSignal *loginEnableSignal;
@property(nonatomic,strong) RACCommand *command;
@end
