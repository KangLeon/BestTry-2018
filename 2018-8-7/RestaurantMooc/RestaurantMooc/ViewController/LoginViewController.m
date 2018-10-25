//
//  LoginViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/10.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "LoginViewController.h"
#import "Util.h"
#import "IMNetwork.h"
#import "UICircleView.h"
#import "UIButtonView.h"
#import "DataSource.h"

@interface LoginViewController (){
    UITextField *tf_userName;
    UITextField *tf_password;
    UIView *loginView2;
    BOOL login2hidden;
    UITapGestureRecognizer *singleTap;
    UIButtonView *buttonView;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.
    self.view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    UILabel *lb_title=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 20, 100, 60)];
    lb_title.text=@"登录";
    lb_title.textColor=[UIColor blackColor];
    lb_title.textAlignment=NSTextAlignmentCenter;
    lb_title.font=[UIFont systemFontOfSize:20.0];
    [self.view addSubview:lb_title];
    
    //2.username password
    tf_userName=[[UITextField alloc] initWithFrame:CGRectMake(0, lb_title.frame.size.height+20, SCREEN_WIDTH, 50)];
    tf_userName.placeholder=@"用户名|邮箱|账号";
    tf_userName.backgroundColor=[UIColor whiteColor];
    tf_userName.borderStyle=UITextBorderStyleNone;
    [self.view addSubview:tf_userName];
    
    tf_password=[[UITextField alloc] initWithFrame:CGRectMake(0, lb_title.frame.size.height+72, SCREEN_WIDTH, 50)];
    tf_password.placeholder=@"密码";
    tf_password.backgroundColor=[UIColor whiteColor];
    tf_password.borderStyle=UITextBorderStyleNone;
    tf_password.secureTextEntry=YES;
    [self.view addSubview:tf_password];
    
    //3.login button
//    UIButton *bt_login=[[UIButton alloc] initWithFrame:CGRectMake(20, tf_password.frame.origin.y+tf_password.frame.size.height+20, SCREEN_WIDTH-40, 60)];
    buttonView=[[UIButtonView alloc] initWithFrame:CGRectMake(20, tf_password.frame.origin.y+tf_password.frame.size.height+20,SCREEN_WIDTH-40 , 60)];
    singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAction:)];
    [buttonView addGestureRecognizer:singleTap];
    [self.view addSubview:buttonView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginstop) name:@"animationStop" object:nil];
    
    //4.label
    UILabel *lb_forgetKay=[[UILabel alloc] initWithFrame:CGRectMake(20, buttonView.frame.origin
                                                                    .y+buttonView.frame.size.height+10, 50, 20)];
    lb_forgetKay.text=@"忘记密码";
    lb_forgetKay.textAlignment=NSTextAlignmentLeft;
    lb_forgetKay.textColor=MYCOLORBLUE;
    lb_forgetKay.font=[UIFont systemFontOfSize:12.0];
    [self.view addSubview:lb_forgetKay];
    
    UILabel *lb_register=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, buttonView.frame.origin
                                                                    .y+buttonView.frame.size.height+10, 50, 20)];
    lb_register.text=@"立即注册";
    lb_register.textAlignment=NSTextAlignmentCenter;
    lb_register.textColor=MYCOLORBLUE;
    lb_register.font=[UIFont systemFontOfSize:12.0];
    [self.view addSubview:lb_register];
    
    //5.login 2
    loginView2 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 100)];
    UIButton *bt_login2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [bt_login2 setTitle:@"--换种方式--" forState:UIControlStateNormal];
    [bt_login2 setTitleColor:MYCOLORBLUE forState:UIControlStateNormal];
    [bt_login2 addTarget:self action:@selector(loginAction2) forControlEvents:UIControlEventTouchUpInside];
    [loginView2 addSubview:bt_login2];
    [self.view addSubview:loginView2];
    
    UIImageView *loginQQ = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40-40-20)/2, 50, 40, 40)];
    loginQQ.image = [UIImage imageNamed:@"qq.png"];
    [loginView2 addSubview:loginQQ];
    
    UIImageView *loginchat = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40-40-20)/2+60, 50, 40, 40)];
    loginchat.image = [UIImage imageNamed:@"chat.png"];
    [loginView2 addSubview:loginchat];
    
    // 6 返回
    UIButton *bt_return = [[UIButton alloc]initWithFrame:CGRectMake(10, 38, 30, 20)];
    [bt_return setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [bt_return addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt_return];
}

-(void)loginstop{
    buttonView.userInteractionEnabled=true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->buttonView removeFromSuperview];
        buttonView=[[UIButtonView alloc] initWithFrame:CGRectMake(20, tf_password.frame.origin.y+self->tf_password.frame.size.height+20, SCREEN_WIDTH-40, 60)];
        self->singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAction)];
        [self->buttonView addGestureRecognizer:self->singleTap];
        [self.view addSubview:self->buttonView];
        BOOL flag=[[DataSource getInstance] getLoginFlag];
        if (flag) {
            [self dismissViewControllerAnimated:true completion:nil];
        }
    });
}

-(void)viewAction:(UITapGestureRecognizer*)tapTouch{
    [[DataSource getInstance] setLoginFlag:false];
    [self loginAction];
    buttonView.userInteractionEnabled=false;
    [buttonView startAnimation];
}

-(void)loginAction{
    [tf_password resignFirstResponder];
    [tf_userName resignFirstResponder];
    NSString *userName=[tf_userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password=[tf_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([userName containsString:@"#"] | [userName containsString:@"%"]) {
        [self showAlert:@"" message:@"包含非法字符"];
    }else if (password.length<2){
        [self showAlert:@"警告！" message:@"密码长度不够!"];
    }else{
        CGRect frame=CGRectMake(0, 0, 100, 100);
        UIView *activityBg=[[UIView alloc] initWithFrame:frame];
        activityBg.center=self.view.center;
        activityBg.backgroundColor=[UIColor grayColor];
        activityBg.alpha=0.7;
        activityBg.layer.cornerRadius=5.0;
        
        IMNetwork *loginNetwork=[[IMNetwork alloc] init];
        [loginNetwork login:LOGININURL userName:[userName lowercaseString] password:[password lowercaseString]];
    }
}

-(void)loginAction2{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if (!login2hidden) {
        loginView2.frame=CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
    }else{
        loginView2.frame=CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 100);
    }
    login2hidden=!login2hidden;
    [UIView commitAnimations];
}

-(void)showAlert:(NSString *)title message:(NSString *)message{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:true completion:nil];
}


-(void)returnAction{
    [self dismissViewControllerAnimated:true completion:nil];
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
