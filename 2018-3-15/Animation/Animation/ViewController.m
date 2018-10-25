//
//  ViewController.m
//  Animation
//
//  Created by jitengjiao      on 2018/3/15.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "nextViewController.h"

//关于 CATrasition的

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //导航控制器动画
    CATransition *animation=[CATransition animation];
    animation.duration=1;
//    animation.type=kCATransitionFade;//动画主类型，决定动画的效果形式
    [animation setType:kCATransitionReveal];
    animation.subtype=kCATransitionFromLeft;//动画子类型，例如动画的方向
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的轨迹类型
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    UIButton *myButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    myButton .backgroundColor=[UIColor clearColor];
    [myButton setTitle:@"你好" forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//正确的给button设置文字的方法，
    [myButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:myButton];
    
    self.navigationItem.rightBarButtonItem=right;//这种方式是没有办法触发NavigationController的动画的
}

-(void)push{
    nextViewController *nextVC=[[nextViewController alloc] init];
    
    [self.navigationController pushViewController:nextVC animated:true];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CATransition *animation=[CATransition animation];
    animation.duration=1;
    //    animation.type=kCATransitionFade;//动画主类型，决定动画的效果形式
    [animation setType:@"cube"];
    animation.subtype=kCATransitionFromLeft;//动画子类型，例如动画的方向
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的轨迹类型
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    nextViewController *nextVC=[[nextViewController alloc] init];
    
    [self.navigationController pushViewController:nextVC animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
