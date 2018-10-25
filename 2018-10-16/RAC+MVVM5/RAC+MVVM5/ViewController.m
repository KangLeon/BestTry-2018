//
//  ViewController.m
//  RAC+MVVM5
//
//  Created by admin on 2018/10/17.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self secondSignal];
}


/**
 2018-10-17 11:51:41.820905+0800 RAC+MVVM5[81805:4510434] 信号被创建
 2018-10-17 11:51:42.823980+0800 RAC+MVVM5[81805:4510434] 订阅者被执行
 2018-10-17 11:51:42.825543+0800 RAC+MVVM5[81805:4510434] 被订阅者代码执行
 2018-10-17 11:51:43.833968+0800 RAC+MVVM5[81805:4510434] 一月份的读者
 2018-10-17 11:51:44.826016+0800 RAC+MVVM5[81805:4510434] 二月份的读者
 2018-10-17 11:51:45.826165+0800 RAC+MVVM5[81805:4510434] 三月份的读者
 2018-10-17 11:51:46.826173+0800 RAC+MVVM5[81805:4510434] 四月份的读者
 2018-10-17 11:51:47.826158+0800 RAC+MVVM5[81805:4510434] 五月份的读者
 2018-10-17 11:51:48.826004+0800 RAC+MVVM5[81805:4510434] 六月份的读者
 2018-10-17 11:51:49.826011+0800 RAC+MVVM5[81805:4510434] 七月份的读者
 2018-10-17 11:51:50.826086+0800 RAC+MVVM5[81805:4510434] 八月份的读者
 2018-10-17 11:51:51.826062+0800 RAC+MVVM5[81805:4510434] 九月份的读者
 2018-10-17 11:51:52.827272+0800 RAC+MVVM5[81805:4510434] 十月份的读者
 2018-10-17 11:51:53.826053+0800 RAC+MVVM5[81805:4510434] 十一月份的读者
 2018-10-17 11:51:55.826150+0800 RAC+MVVM5[81805:4510434] 十二月份的读者
 
 */
//是冷信号
-(void)firstSignal{
    RACSignal *signal=[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"被订阅者代码执行");
        [[RACScheduler mainThreadScheduler] afterDelay:1.0 schedule:^{
            [subscriber sendNext:@"一月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2.0 schedule:^{
            [subscriber sendNext:@"二月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:3.0 schedule:^{
            [subscriber sendNext:@"三月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:4.0 schedule:^{
            [subscriber sendNext:@"四月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:5.0 schedule:^{
            [subscriber sendNext:@"五月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:6.0 schedule:^{
            [subscriber sendNext:@"六月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:7.0 schedule:^{
            [subscriber sendNext:@"七月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:8.0 schedule:^{
            [subscriber sendNext:@"八月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:9.0 schedule:^{
            [subscriber sendNext:@"九月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:10.0 schedule:^{
            [subscriber sendNext:@"十月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:11.0 schedule:^{
            [subscriber sendNext:@"十一月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:12.0 schedule:^{
            [subscriber sendNext:@"十二月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:13.0 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    NSLog(@"信号被创建");
    [[RACScheduler mainThreadScheduler] afterDelay:1.0 schedule:^{
        NSLog(@"订阅者被执行");
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
}


/**
 2018-10-17 13:07:18.028540+0800 RAC+MVVM5[1187:79202] 被订阅者代码执行
 2018-10-17 13:07:18.029720+0800 RAC+MVVM5[1187:79202] 信号被创建
 2018-10-17 13:07:25.033181+0800 RAC+MVVM5[1187:79202] 订阅者被执行
 2018-10-17 13:07:26.283182+0800 RAC+MVVM5[1187:79202] 八月份的读者
 2018-10-17 13:07:27.416478+0800 RAC+MVVM5[1187:79202] 九月份的读者
 2018-10-17 13:07:28.033155+0800 RAC+MVVM5[1187:79202] 十月份的读者
 2018-10-17 13:07:29.029968+0800 RAC+MVVM5[1187:79202] 十一月份的读者
 2018-10-17 13:07:31.050652+0800 RAC+MVVM5[1187:79202] 十二月份的读者

 */
-(void)secondSignal{
        RACSubject *signal=[RACSubject subject];
        NSLog(@"被订阅者代码执行");
        [[RACScheduler mainThreadScheduler] afterDelay:1.0 schedule:^{
            [signal sendNext:@"一月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2.0 schedule:^{
            [signal sendNext:@"二月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:3.0 schedule:^{
            [signal sendNext:@"三月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:4.0 schedule:^{
            [signal sendNext:@"四月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:5.0 schedule:^{
            [signal sendNext:@"五月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:6.0 schedule:^{
            [signal sendNext:@"六月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:7.0 schedule:^{
            [signal sendNext:@"七月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:8.0 schedule:^{
            [signal sendNext:@"八月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:9.0 schedule:^{
            [signal sendNext:@"九月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:10.0 schedule:^{
            [signal sendNext:@"十月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:11.0 schedule:^{
            [signal sendNext:@"十一月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:12.0 schedule:^{
            [signal sendNext:@"十二月份的读者"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:13.0 schedule:^{
            [signal sendCompleted];
        }];
    
    NSLog(@"信号被创建");
    [[RACScheduler mainThreadScheduler] afterDelay:7.0 schedule:^{
        NSLog(@"订阅者被执行");
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
