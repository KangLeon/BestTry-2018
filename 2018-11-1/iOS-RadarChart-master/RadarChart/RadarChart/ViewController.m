//
//  ViewController.m
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//
//TODO：正式用的时候封装数据源和代理，
//TODO：不需要背景一层一层的，需求是只需要统一的一张背景图
//TODO：需求是扁平的不规则五边形，不是正五边形，

#import "ViewController.h"
#import "RAShareChartView.h"

@interface ViewController ()

@property (nonatomic, strong) RAShareChartView *chartV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartV.center = self.view.center;
    [self.view addSubview:self.chartV];
    
    //设置雷达的锚点位置比例
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(3.8)];
    [array addObject:@(2.0)];
    [array addObject:@(4.4)];
    [array addObject:@(3.8)];
    [array addObject:@(0.7)];
    
    self.chartV.scoresArray = array;
    // Do any additional setup after loading the view, typically from a nib.
}


-(RAShareChartView *)chartV
{
    if (!_chartV) {
        _chartV = [[RAShareChartView alloc] init];
        _chartV.bounds = CGRectMake(0, 0, 590 / 2.0, 462 / 2.0);
    }
    return _chartV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
