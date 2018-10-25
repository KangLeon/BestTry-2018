//
//  FifthViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "FifthViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FifthViewController ()

@end

@implementation FifthViewController

//RACSignal是一种拉驱动的方式，内容是在订阅的时候才生成的
//side effect(副作用)
//在每次订阅信号量的时候，都会重复执行一次信号量里的内容，又可能产生一些不想要的后果，


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __block int a=10;
    RACSignal *s=[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        a+=5;
        [subscriber sendNext:@(a)];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] replayLast];//加上replayLast之后，代码块就会只执行一次，
    [s subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [s subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //RACSequence 他也是继承自RACStream，但他是推驱动的一种方式,内容在初始化的时候就生成的
//    RACSequence* seq=[s sequence];//两者可以互相转化，
//    [seq signal];
    
    NSArray *arr=@[@(1),@(2),@(3),@(4),@(5)];//RACSequence可以和NSArray无缝的转换
    RACSequence* seq=[arr rac_sequence];
//    [seq array];
    
    
    //map
    NSLog(@"%@",[[seq map:^id(id value) {//返回时NSNumber
        return @([value integerValue]*3);
    }] array]);//RACSequence是惰性初始化的，只有到访问的时候才能真正有内容，所以这里又把他转成了NSArray，
    
    
    //filter
    NSLog(@"%@",[[seq filter:^BOOL(id value) {
        return [value integerValue]%2==1;
    }] array]);
    
    
    //flattenmap:整平操作，先执行map操作，然后才是flatten的合并操作

    
    //contact:标准的signal串行的方法，
    RACSignal* s1;
    RACSignal* s2;
    [[s1 concat:s2] subscribeNext:^(id x) {
        //他会把s1和s2的值都返回回来，但是then方法的话只会把后面执行的步骤的内容返回回来，
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
