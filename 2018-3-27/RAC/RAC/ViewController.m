//
//  ViewController.m
//  RAC
//
//  Created by jitengjiao      on 2018/3/27.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import <MBProgressHUD.h>
#import "ViewModel.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginbutton;
@property(nonatomic,strong) ViewModel *loginViewModel;
    @property(nonatomic,strong) MBProgressHUD *progressHUD;
@end

@implementation ViewController

-(ViewModel *)loginViewModel{//懒加载的时候必须得使用下划线的实例变量，
    if (_loginViewModel==nil) {
        _loginViewModel=[[ViewModel alloc] init];
    }
    return _loginViewModel;
   
}
    -(MBProgressHUD*)progressHUD{
        if(_progressHUD==nil){
            //初始化MBProgressHUD
            self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
            //    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
            self.progressHUD.progress = 0.4;
            //添加ProgressHUD到界面中
            [self.view addSubview:self.progressHUD];
        }
        return _progressHUD;
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self loginViewModel];
    [self progressHUD];
    [self loginEvent];
    
}


//绑定业务逻辑
-(void)bindViewModel{
    //给viewModel的账号和密码绑定账号
    RAC(self.loginViewModel,account)=self.username.rac_textSignal;
    RAC(self.loginViewModel,pwd)=self.password.rac_textSignal;
}


//登录事件
-(void)loginEvent{
    RAC(self.loginbutton,enabled)=self.loginViewModel.loginEnableSignal;
    
    //监听登录按钮的点击
    [[self.loginbutton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击登录按钮");
        [self showProgress];
        //处理登录事件
        [self.loginViewModel.command execute:nil];
    }];
}
 
#pragma mark - 显示进度框
-(void)showProgress{
    self.progressHUD.dimBackground = NO; //设置有遮罩
    self.progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
    [self.progressHUD showAnimated:YES]; //显示进度框
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
