//
//  BezierView.m
//  BezierPath1
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "BezierView.h"

@interface BezierView ()

@property(nonatomic,strong)UIButton *begin_animation;

@end

@implementation BezierView

-(void)drawRect:(CGRect)rect{
    [self animation_Bezier];
}

-(void)animation_Bezier{
    self.begin_animation=[[UIButton alloc] initWithFrame:CGRectMake(80, 80, 80, 40)];
    [self.begin_animation setTitle:@"开始动画" forState:UIControlStateNormal];
    [self.begin_animation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.begin_animation addTarget:self action:@selector(beautiful_begin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.begin_animation];
}

//打对勾动画
-(void)beautiful_begin{
    //构思，首先是应该分为六个部分：
    //!!!:怎么把他缩小复用在其他地方
    UIView *check_backView=[[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, 500)];
    check_backView.backgroundColor=[UIColor blackColor];
    [self addSubview:check_backView];
    
    UIColor *color=[UIColor whiteColor];
    [color setFill];
    [color setStroke];
    
    //1.圆弧，半径-中
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(53, 250-23)];
    [path addQuadCurveToPoint:CGPointMake(86.5, 232) controlPoint:CGPointMake(68, 250-25-15)];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    //2.直线
    //路径
    [path moveToPoint:CGPointMake(85, 230)];
    [path addLineToPoint:CGPointMake(120, 280)];
    
    //6.直线
    //路径
    [path moveToPoint:CGPointMake(53, 250-35)];
    [path addLineToPoint:CGPointMake(110, 288)];
    
    //5.衔接部分-底部
    [path moveToPoint:CGPointMake(107, 285)];
    [path addQuadCurveToPoint:CGPointMake(131, 285) controlPoint:CGPointMake(120, 300)];
  
    UIBezierPath *path2=[UIBezierPath bezierPath];
    
    //3.圆弧，半径-大
    [path2 moveToPoint:CGPointMake(120, 282)];
    [path2 addQuadCurveToPoint:CGPointMake(240, 100) controlPoint:CGPointMake(170, 175)];
    
    //3.5衔接部分
    [path2 moveToPoint:CGPointMake(238, 102)];
    [path2 addQuadCurveToPoint:CGPointMake(245, 105) controlPoint:CGPointMake(254, 92)];

    //4.圆弧，半径-大
    [path2 moveToPoint:CGPointMake(130, 288)];
    [path2 addQuadCurveToPoint:CGPointMake(246, 103) controlPoint:CGPointMake(175, 180)];
    
    //新建图层——绘制上面的勾
    CAShapeLayer *layer= [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 22;
    layer.path = path.CGPath;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.3;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [check_backView.layer addSublayer:layer];
    
    CAShapeLayer *layer2= [[CAShapeLayer alloc] init];
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = [UIColor whiteColor].CGColor;
    layer2.lineWidth = 22;
    layer2.path = path2.CGPath;

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation2.fromValue = @0;
    animation2.toValue = @1;
    animation2.duration = 0.3;
    [layer2 addAnimation:animation2 forKey:NSStringFromSelector(@selector(strokeEnd))];

    [check_backView.layer addSublayer:layer2];
}

-(void)animation_begin{
    UIView *check_backView=[[UIView alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    check_backView.backgroundColor=[UIColor blackColor];
    [self addSubview:check_backView];
    CGPoint pathCenter = CGPointMake(check_backView.frame.size.width/2, 250 - 50);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    
    CGFloat x = check_backView.frame.size.width*0.2;
    CGFloat y = check_backView.frame.size.height*0.6;
    //勾的起点
    [path moveToPoint:CGPointMake(x, y)];
    //勾的最底端
    CGPoint p1 = CGPointMake(x+10, y+ 10);
    [path addLineToPoint:p1];
    //勾的最上端
    CGPoint p2 = CGPointMake(x+24,y-14);
    [path addLineToPoint:p2];
    //新建图层——绘制上面的勾
    CAShapeLayer *layer= [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.1;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [check_backView.layer addSublayer:layer];
}

-(void)todayBestDemo{
    //x,y,的起点坐标
    CGAffineTransform transform = CGAffineTransformMakeTranslation((self.bounds.size.width-50*5)/2, 100);
    //缩放比例
    transform = CGAffineTransformScale(transform, 5, 5);
    
    //圆角矩形
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 50, 50) cornerRadius:10];
    [path1 applyTransform:transform];
    [[UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f] setStroke];
    [path1 stroke];
    
    //矩形
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(7, 10, 14, 12)];
    [path2 applyTransform:transform];
    [[UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f] setFill];
    [path2 fill];
    
    //矩形
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRect:CGRectMake(7, 10, 14, 12)];
    [path3 applyTransform:transform];
    [[UIColor colorWithRed:189/255.0f green:189/255.0f blue:189/255.0f alpha:1.0f] setStroke];
    [path3 stroke];
    
    //线
    UIBezierPath *path11 = [UIBezierPath bezierPath];
    [path11 moveToPoint:CGPointMake(28, 10)];
    [path11 addLineToPoint:CGPointMake(43, 10)];
    [path11 applyTransform:transform];
    [[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f] setStroke];
    [path11 stroke];
    
    //线
    UIBezierPath *path12 = [UIBezierPath bezierPath];
    [path12 moveToPoint:CGPointMake(28, 16)];
    [path12 addLineToPoint:CGPointMake(43, 16)];
    [path12 applyTransform:transform];
    [path12 stroke];
    
    //线
    UIBezierPath *path13 = [UIBezierPath bezierPath];
    [path13 moveToPoint:CGPointMake(28, 22)];
    [path13 addLineToPoint:CGPointMake(43, 22)];
    [path13 applyTransform:transform];
    [path13 stroke];
    
    //线
    UIBezierPath *path21 = [UIBezierPath bezierPath];
    [path21 moveToPoint:CGPointMake(7, 28)];
    [path21 addLineToPoint:CGPointMake(43, 28)];
    [path21 applyTransform:transform];
    [path21 stroke];
    
    //线
    UIBezierPath *path22 = [UIBezierPath bezierPath];
    [path22 moveToPoint:CGPointMake(7, 34)];
    [path22 addLineToPoint:CGPointMake(43, 34)];
    [path22 applyTransform:transform];
    [path22 stroke];
    
    //线
    UIBezierPath *path23 = [UIBezierPath bezierPath];
    [path23 moveToPoint:CGPointMake(7, 40)];
    [path23 addLineToPoint:CGPointMake(43, 40)];
    [path23 applyTransform:transform];
    [path23 stroke];

}

//画矩形某个角的圆角
-(void)addRoundRect{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(70, 70, 100, 80) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 20)];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path stroke];
}

//画三次贝塞尔
-(void)addCure{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(20, 200)];
    [path addCurveToPoint:CGPointMake(260, 200) controlPoint1:CGPointMake(140, 0) controlPoint2:CGPointMake(140, 400)];
    
    [path stroke];
}


//画二次贝塞尔
-(void)addQuardCurve{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(40, 150)];
    [path addQuadCurveToPoint:CGPointMake(140, 200) controlPoint:CGPointMake(20, 40)];
    
    [path stroke];
}

//画弧
-(void)addArc{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:30 startAngle:0 endAngle:180/180.0*M_PI clockwise:YES];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path stroke];
}

//画圆
-(void)addCircle{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(70, 70, 200, 300)];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineJoinRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path stroke];
}

//画矩形
-(void)addRect{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(70, 70, 200, 300)];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path stroke];
}

//画多边形
-(void)addMutiRect{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    path.lineWidth=2.0;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(70, 70)];
    [path addLineToPoint:CGPointMake(70, 120)];
    [path addLineToPoint:CGPointMake(100, 180)];
    [path addLineToPoint:CGPointMake(130, 120)];
    [path addLineToPoint:CGPointMake(130, 70)];
    [path closePath];//最后一个点和最开始一个点之间连线
    
    [path fill];
}

//画线
-(void)addLine{
    //设置线条属性
    UIColor *color=[UIColor blackColor];
    [color set];//设置画笔颜色
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    path.lineWidth=10.0;
    path.lineCapStyle=kCGLineCapRound;//终点拐角
    path.lineJoinStyle=kCGLineJoinRound;//终点处理
    
    //路径
    [path moveToPoint:CGPointMake(70, 70)];
    [path addLineToPoint:CGPointMake(300, 600)];
    
    //画
    [path stroke];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
