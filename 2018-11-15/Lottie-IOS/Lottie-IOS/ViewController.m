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

@property(nonatomic,strong)LOTAnimationView *animation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置willpower的动画
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    self.animation=[LOTAnimationView animationNamed:@"trail_loading"];
    self.animation.frame=CGRectMake((self.view.frame.size.width-200)/2,(self.view.frame.size.height-200)/2, 200, 200);
    self.animation.loopAnimation=YES;
    self.animation.contentMode=UIViewContentModeScaleToFill;
    self.animation.animationSpeed=1.0;
    [self.animation playWithCompletion:^(BOOL animationFinished) {
        
    }];
    
    [self.view addSubview:self.animation];
}
@end
