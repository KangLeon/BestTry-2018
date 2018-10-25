//
//  ViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/9.
//  Copyright © 2018年 MJ. All rights reserved.
//

//复习count=1

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@end

@implementation ViewController

//从该例中可以看出RAC相对于传统的设计模式，有两个特质：
//1.编程逻辑的流畅性
//2.编程代码的清晰性

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    //RAC框架中的制作好的取textField值的信号量
//    [self.userTextFied.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
//    //这只是完成了一个TextField的处理
//    RACSignal* enableSignal=[self.userTextFied.rac_textSignal map:^id(NSString* value) {
//        return @(value.length>0);
//    }];
    
    //合并的方法在这里
    RACSignal* enableSignal=[[RACSignal combineLatest:@[self.userTextFied.rac_textSignal,self.passwordTextField.rac_textSignal]] map:^id(id value) {
//        NSLog(@"%@",value);//这里返回的是个元组
        return @([value[0] length]>0&&[value[1] length]>6);
    }];

    self.loginButton.rac_command=[[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
       return [RACSignal empty];
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userTextFied resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




















