//
//  ViewModel.m
//  RAC
//
//  Created by jitengjiao      on 2018/3/27.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel ()
    
@end

@implementation ViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{

    
    //处理登录点击的信号
    //vm里最好不好包括视图
    
    _loginEnableSignal=[RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id _Nonnull(NSString *account,NSString *pwd){//redeuce聚合
        return @(account.length&&pwd.length);
    }];
    //处理登录点击命令
    _command=[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //block:执行命令就会调用
        //block作用：事件处理
        //发送登录请求
        
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发送数据
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            
            
            return nil;
        }];
    }];
    
    //处理登录请求返回的结果
    //获取命令中信号源
    [_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"2345678%@",x);
    }];
    
    //处理登录命令的执行过程
    [[_command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]==YES) {
            //正在执行
            NSLog(@"正在执行");
            //显示蒙版
            
        }else{
            //执行完成
            //蒙版取消
            NSLog(@"执行完成");
        }
    }];
    

}

@end
