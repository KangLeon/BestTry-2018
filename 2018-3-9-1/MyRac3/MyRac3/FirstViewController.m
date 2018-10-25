//
//  FirstViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "FirstViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

//
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //信号量:他是个更强大的block,可以对产生错误进行区分
    RACSignal* viewDidAppearSignal=[self rac_signalForSelector:@selector(viewDidAppear:)];
    //订阅
    [viewDidAppearSignal subscribeNext:^(id x) {
        //他也可以传参数,可以看输出结果显示，他是RACTuple，即RAC元组类型
        NSLog(@"%@",x);

        NSLog(@"%s",__func__);
    }];

    [viewDidAppearSignal subscribeError:^(NSError *error) {

    }];

    [viewDidAppearSignal subscribeCompleted:^{

    }];

    //Rac对于addTarget：方法的完整替代方案
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];

    [button setRac_command:[[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        //RACSignal的初始化方式
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            NSLog(@"oh,i have been touched");//耗时操作

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[[NSDate date] description]];
                [subscriber sendCompleted];
            });

            return [RACDisposable disposableWithBlock:^{


            }];
        }];
    }]];

    //获取订阅
    [[[button rac_command] executionSignals] subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];

    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setBounds:CGRectMake(0, 0, 100, 200)];
    [button setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [self.view addSubview:button];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    NSLog(@"%s",__func__);
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
