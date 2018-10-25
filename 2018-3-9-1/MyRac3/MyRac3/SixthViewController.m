//
//  SixthViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "SixthViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SixthViewController ()

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //属性的访问，在oc里使用的是KVO技术，但是RACSignal是RAC宏，
    RACSignal *signal=RACObserve(self, title);
    [signal subscribeNext:^(id x) {
        
    }];
    
    //将一个宏绑定在另外一个宏上
//    RAC()=RACObserve(TARGET, KEYPATH)
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
