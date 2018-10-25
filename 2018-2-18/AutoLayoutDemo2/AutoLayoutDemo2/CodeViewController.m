//
//  CodeViewController.m
//  AutoLayoutDemo2
//
//  Created by jitengjiao      on 2018/2/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "CodeViewController.h"
#import "Masonry.h"
#import "CustomView.h"

@interface CodeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnGreen;
@property (weak, nonatomic) IBOutlet UIButton *btnRed;
@property (strong,nonatomic) CustomView *customView;
@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    //用Masonry的库做自动布局
    [_btnGreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@100);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [_btnRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_btnGreen.mas_bottom).offset(60);
        make.width.equalTo(_btnGreen);
        make.height.equalTo(_btnGreen);
    }];
    
    self.customView=[CustomView new];
    [self.view addSubview:_customView];
    _customView.backgroundColor=[UIColor lightGrayColor];
    
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnRed.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@20);
    }];
    
//     for buttn green
//    用纯代码的方式做自动布局
//    NSLayoutConstraint *constraintCenterXGreen=[NSLayoutConstraint constraintWithItem:_btnGreen attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    _btnGreen.translatesAutoresizingMaskIntoConstraints=false;
//    [self.view addConstraint:constraintCenterXGreen];
//
//
//    NSLayoutConstraint *constraintTopGreen=[NSLayoutConstraint constraintWithItem:_btnGreen attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
//    [self.view addConstraint:constraintTopGreen];
    
    //for button red
    
    //用纯代码的方式做自动布局
//    NSLayoutConstraint *constraintCenterXRed=[NSLayoutConstraint constraintWithItem:_btnRed attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    _btnRed.translatesAutoresizingMaskIntoConstraints=false;
//    [self.view addConstraint:constraintCenterXRed];
//
//    NSLayoutConstraint *constraintTopRed=[NSLayoutConstraint constraintWithItem:_btnRed attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnGreen attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60];
//    [self.view addConstraint:constraintTopRed];
}

@end
