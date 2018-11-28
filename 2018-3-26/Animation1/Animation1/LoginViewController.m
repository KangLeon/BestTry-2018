//
//  LoginViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/26.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bubble1;
@property (weak, nonatomic) IBOutlet UIImageView *bubble2;
@property (weak, nonatomic) IBOutlet UIImageView *bubble3;
@property (weak, nonatomic) IBOutlet UIImageView *bubble4;
@property (weak, nonatomic) IBOutlet UIImageView *bubble5;
@property (weak, nonatomic) IBOutlet UIImageView *selfControl;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(strong,nonatomic)  UIActivityIndicatorView *muindict;
@property(assign,nonatomic) CGPoint loginPositon;
@property(assign,nonatomic) BOOL messagePositon;
@property(weak,nonatomic)IBOutlet UIImageView *meesgaeImage;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景白色的球
    self.bubble1.transform=CGAffineTransformMakeScale(0, 0);
    self.bubble2.transform=CGAffineTransformMakeScale(0, 0);
    self.bubble3.transform=CGAffineTransformMakeScale(0, 0);
    self.bubble4.transform=CGAffineTransformMakeScale(0, 0);
    self.bubble5.transform=CGAffineTransformMakeScale(0, 0);
    
    
    self.selfControl.center=CGPointMake(self.selfControl.center.x-self.view.frame.size.width,self.selfControl.center.y);
    self.line.center=CGPointMake(self.line.center.x-self.view.frame.size.width,self.line.center.y);
    
    self.username.frame=CGRectMake(24, 261, 367, 35);
    self.username.backgroundColor=[UIColor whiteColor];
    self.username.borderStyle=UITextBorderStyleNone;//要想这个起作用，必须在nib里面也设置border为none
    self.username.layer.borderColor=[UIColor whiteColor].CGColor;
    self.username.layer.cornerRadius=18;
    //3.1放大镜的图标的添加有以下的四种方法：（后面三种的方法比较好，自定义比较复杂）
    //a.首先是tf_search.leftView=imageView;但是这种方法的后果是放大镜回紧紧的贴着UITextField的左边，不好看
    //b.第二种方法是通过把图标通过美工留白
    //c.第三种方法是自定义TextField
    //d.第四种方法是把UIImagview添加到UIView上，UIView最左边留空白，再把UIView添加到leftView上就可以了
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"用户.png"]];
    [view addSubview:imageView];
    
    self.username.leftView=view;
    self.username.leftViewMode=UITextFieldViewModeAlways;
    
    
    self.password.frame=CGRectMake(24, 321, 367, 35);
    self.password.backgroundColor=[UIColor whiteColor];
    self.password.borderStyle=UITextBorderStyleNone;//要想这个起作用，必须在nib里面也设置border为none
    self.password.layer.borderColor=[UIColor whiteColor].CGColor;
    self.password.layer.cornerRadius=18;
    //3.1放大镜的图标的添加有以下的四种方法：（后面三种的方法比较好，自定义比较复杂）
    //a.首先是tf_search.leftView=imageView;但是这种方法的后果是放大镜回紧紧的贴着UITextField的左边，不好看
    //b.第二种方法是通过把图标通过美工留白
    //c.第三种方法是自定义TextField
    //d.第四种方法是把UIImagview添加到UIView上，UIView最左边留空白，再把UIView添加到leftView上就可以了
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    UIImageView *imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    [imageView2 setImage:[UIImage imageNamed:@"钥匙.png"]];
    [view2 addSubview:imageView2];
    
    self.password.leftView=view2;
    self.password.leftViewMode=UITextFieldViewModeAlways;
    
    self.username.center=CGPointMake(self.username.center.x-self.view.frame.size.width,self.username.center.y);
    self.password.center=CGPointMake(self.password.center.x-self.view.frame.size.width,self.password.center.y);
    
    self.loginButton.center=CGPointMake(self.loginButton.center.x-self.view.frame.size.width,self.loginButton.center.y);
    
    self.muindict=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

    self.messagePositon=YES;
    self.meesgaeImage.hidden=self.messagePositon;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //bubble的动画
    [UIView animateWithDuration:0.6 delay:0.3 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:nil animations:^{
        self.bubble2.transform=CGAffineTransformMakeScale(1, 1);
        self.bubble3.transform=CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:nil animations:^{
        self.bubble1.transform=CGAffineTransformMakeScale(1, 1);
        self.bubble4.transform=CGAffineTransformMakeScale(1, 1);
        self.bubble5.transform=CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:nil animations:^{
    self.selfControl.center=CGPointMake(self.selfControl.center.x+self.view.frame.size.width,self.selfControl.center.y);
    } completion:nil];
    
    
    [UIView animateWithDuration:1 delay:0.6 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:nil animations:^{
        self.line.center=CGPointMake(self.line.center.x+self.view.frame.size.width,self.line.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
         self.username.center=CGPointMake(self.username.center.x+self.view.frame.size.width,self.username.center.y);
    } completion:nil];
    [UIView animateWithDuration:0.4 delay:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.password.center=CGPointMake(self.password.center.x+self.view.frame.size.width,self.password.center.y);
    } completion:nil];
    [UIView animateWithDuration:0.4 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginButton.center=CGPointMake(self.loginButton.center.x+self.view.frame.size.width,self.loginButton.center.y);
    } completion:nil];
    
        self.loginPositon=self.loginButton.center;
    
}
- (IBAction)loginEnsure:(UIButton *)sender {
    [self.loginButton addSubview:self.muindict];
    [self.muindict setCenter:CGPointMake(30, 20)];
    [self.muindict startAnimating];
    [UIView animateWithDuration:0.5 animations:^{
        self.loginButton.center=self.loginPositon;
        self.meesgaeImage.hidden=YES;
    }];
    if ([self.username.text isEqualToString:@"397879704"]) {
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.loginButton setCenter:CGPointMake(self.loginButton.center.x-30,self.loginButton.center.y)];
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:nil animations:^{
                [self.loginButton setCenter:CGPointMake(self.loginButton.center.x+30,self.loginButton.center.y)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    [self.loginButton setCenter:CGPointMake(self.loginButton.center.x, self.loginButton.center.y+70)];
                    
                    [self.muindict removeFromSuperview];

                } completion:^(BOOL finished){
                    [self.password resignFirstResponder];
                    [self.username resignFirstResponder];
                    [UIView transitionWithView:self.meesgaeImage duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop | UIViewAnimationCurveEaseOut animations:^{
                        self.meesgaeImage.hidden=NO;
                    } completion:nil];
                }];
            }];
        });
    }
    
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
