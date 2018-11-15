//
//  ViewController.m
//  Lottie-IOS
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>

@interface ViewController ()

@property(nonatomic,strong)LOTAnimationView *lot_animation;
@property(nonatomic,strong)UIButton *showCustomHud;
@property(nonatomic,strong)UIView *mask_view;
@property(nonatomic,strong)UIView *back_view;
@property(nonatomic,strong)UILabel *hud_title;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置willpower的动画
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mask_view];
    [self.view addSubview:self.back_view];
    [self.back_view addSubview:self.lot_animation];
    [self.back_view addSubview:self.hud_title];
}

-(LOTAnimationView *)lot_animation{
    if (!_lot_animation) {
        _lot_animation=[LOTAnimationView animationNamed:@"trail_loading"];
        _lot_animation.frame=CGRectMake((self.back_view.frame.size.width-80)/2,5, 80, 80);
        _lot_animation.loopAnimation=YES;
        _lot_animation.contentMode=UIViewContentModeScaleToFill;
        _lot_animation.animationSpeed=1.0;
        [_lot_animation playWithCompletion:^(BOOL animationFinished) {
            
        }];
    }
    return _lot_animation;
}

-(UIView *)mask_view{
    if (!_mask_view) {
        _mask_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _mask_view.backgroundColor=[UIColor blackColor];
        _mask_view.alpha=0.4;
    }
    return _mask_view;
}

-(UIView *)back_view{
    if (!_back_view) {
        _back_view=[[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
        _back_view.backgroundColor=[UIColor whiteColor];
        _back_view.layer.cornerRadius=12.0;
    }
    return _back_view;
}

-(UILabel *)hud_title{
    if (!_hud_title) {
        _hud_title=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.back_view.frame.size.width, 50)];
        _hud_title.text=@"正在加载";
        _hud_title.textColor=[UIColor blackColor];
        _hud_title.textAlignment=NSTextAlignmentCenter;
        _hud_title.numberOfLines=0;
        _hud_title.font=[UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
    }
    return _hud_title;
}

@end
