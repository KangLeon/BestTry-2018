//
//  ViewController.m
//  ChartsTest
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ChartsTest-Bridging-Header.h"

@interface ViewController ()
@property(nonatomic,strong)PieChartView *pieChartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    self.pieChartView=[[PieChartView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.pieChartView.center=self.view.center;
    self.pieChartView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.pieChartView];
    
    //设置饼状图外观样式
    [self.pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的距离
    self.pieChartView.usePercentValuesEnabled=YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled=YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawCenterTextEnabled=YES;//是否显示区块文本
    
    //设置饼状图中间的空心样式
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
    //设置饼状图中心的文本
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
        //        self.pieChartView.centerText = @"饼状图";//中间文字
        //富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
                            range:NSMakeRange(0, centerText.length)];
        self.pieChartView.centerAttributedText = centerText;
    }
    
    //设置饼状图描述
    self.pieChartView.chartDescription.enabled=YES;
    self.pieChartView.chartDescription.text=@"饼状图示例";
    self.pieChartView.chartDescription.textColor=[UIColor brownColor];
    
    //比例条
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
//    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小

    [self setDataCount:8 range:100.0];
}

- (void)setDataCount:(int)count range:(double)range
{
    //生成百分比和标题
    double mult = range;
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        [entries addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:[NSString stringWithFormat:@"第%d个", i]]];
    }

    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
    dataSet.sliceSpace = 2.0;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    //添加颜色
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithDisplayP3Red:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    dataSet.colors = colors;
    //设置折线属性
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    dataSet.valueLinePart1OffsetPercentage = 0.8;
    dataSet.valueLinePart1Length = 0.5;
    dataSet.valueLinePart2Length = 0.4;
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.valueLineColor=[UIColor brownColor];
    dataSet.valueLineWidth=1;
    dataSet.drawValuesEnabled=YES;

    //封装到PieChartData
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.blackColor];
    _pieChartView.data = data;
    [_pieChartView highlightValue:nil];

}

@end
