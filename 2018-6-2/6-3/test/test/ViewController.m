//
//  ViewController.m
//  test
//
//  Created by 吉腾蛟 on 2018/6/27.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)ni:(id)sender {
    [self big];
}
- (IBAction)jiaohuan:(id)sender {
    [self hft_hookOrigMenthod:@selector(big) NewMethod:@selector(small)];
}

-(void)big{
    NSLog(@"big");
}
-(void)small{
    NSLog(@"small");
}
//交换方法实现
-(void)hft_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
    Method method=class_getInstanceMethod([self class], origSel);
    Method new=class_getInstanceMethod([self class], altSel);
//    method_setImplementation(method, method_getImplementation(new));
    method_exchangeImplementations(method, new);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
