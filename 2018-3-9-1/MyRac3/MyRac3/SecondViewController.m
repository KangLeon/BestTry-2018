//
//  SecondViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SecondViewController ()<UITextFieldDelegate>

@end

@implementation SecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.username setDelegate:self];
    [self.password setDelegate:self];
    self.loginButton.enabled=false;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *resultString=[textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *s1=self.username.text;
    NSString *s2=self.password.text;
    
    if (textField==self.username) {
        s1=resultString;
    }else{
        s2=resultString;
    }
    
    if (s1.length>0&&s2.length>6) {
        self.loginButton.enabled=true;
    }else{
        self.loginButton.enabled=false;
    }
    
    NSLog(@"%@ %@",s1,s2);
    
    return true;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
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
