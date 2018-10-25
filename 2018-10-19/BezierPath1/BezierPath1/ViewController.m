//
//  ViewController.m
//  BezierPath1
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "BezierView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BezierView *bezierView=[[BezierView alloc] initWithFrame:self.view.bounds];
    bezierView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bezierView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
