//
//  SecondViewController.m
//  MasonryAnimation
//
//  Created by admin on 2018/11/28.
//  Copyright © 2018 JY. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>

@interface SecondViewController ()
@property(nonatomic,strong)UIView *greenView;
@property(nonatomic,strong)UIView *redView;
@property(nonatomic,strong)UIView *blueView;
@property(nonatomic,assign)BOOL isFirst;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    self.greenView = UIView.new;
    self.greenView.backgroundColor = UIColor.greenColor;
    self.greenView.layer.borderColor = UIColor.blackColor.CGColor;
    self.greenView.layer.borderWidth = 2;
    [self.view addSubview:self.greenView];
    
    self.redView = UIView.new;
    self.redView.backgroundColor = UIColor.redColor;
    self.redView.layer.borderColor = UIColor.blackColor.CGColor;
    self.redView.layer.borderWidth = 2;
    [self.view addSubview:self.redView];
    
    self.blueView = UIView.new;
    self.blueView.backgroundColor = UIColor.blueColor;
    self.blueView.layer.borderColor = UIColor.blackColor.CGColor;
    self.blueView.layer.borderWidth = 2;
    [self.view addSubview:self.blueView];
    self.isFirst=YES;

    [self.view updateConstraintsIfNeeded];

}

-(void)updateViewConstraints{
    if (self.isFirst) {
        [self.greenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(80);
            make.left.equalTo(self.view.mas_left).offset(-200);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        
        [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.greenView.mas_bottom).offset(80);
            make.left.equalTo(self.view.mas_left).offset(-200);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        
        [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.redView.mas_bottom).offset(80);
            make.left.equalTo(self.view.mas_left).offset(-200);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        self.isFirst=NO;
    }else{
        [self.greenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(80);
            make.left.equalTo(self.view.mas_left).offset(80);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        
        [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.greenView.mas_bottom).offset(80);
            make.left.equalTo(self.view.mas_left).offset(80);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        
        [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.redView.mas_bottom).offset(80);
            make.left.equalTo(self.view.mas_left).offset(80);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
    }
    
    [super updateViewConstraints];
}

//开局动画
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.view setNeedsUpdateConstraints];

    [self.view updateConstraintsIfNeeded];//立即触发更新

        //开局动画
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {

    }];
    
    //如果是分时段执行的动画，还需要设置各种不同的bool值来进行分时段控制，
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.greenView removeFromSuperview];
    [self.redView removeFromSuperview];
    [self.blueView removeFromSuperview];
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
