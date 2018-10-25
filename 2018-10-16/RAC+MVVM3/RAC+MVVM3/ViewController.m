//
//  ViewController.m
//  RAC+MVVM3
//
//  Created by admin on 2018/10/17.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RACSignal *enableLoginSignal=[[RACSignal combineLatest:@[self.usernameTextfield.rac_textSignal,self.passwordTextfield.rac_textSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        NSLog(@"用户名：%@,密码：%@",value[0],value[1]);
        return @([value[0] length]>0&&[value[1] length]>6);
    }];
    self.loginButton.rac_command=[[RACCommand alloc] initWithEnabled:enableLoginSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"登录成功");
        return [RACSignal empty];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
