//
//  UIButtonView.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "UIButtonView.h"
#import "Util.h"
#import "UICircleView.h"



@interface UIButtonView ()<CAAnimationDelegate>{
    UIView *view;
    UIView *viewborder;
    UICircleView *circleView;
    CGFloat button_x;
    CGFloat button_y;
    CGFloat button_w;
    CGFloat button_h;
    UILabel *label;
    int aniStopNum;
}

@end

@implementation UIButtonView
-(void)updateButtonColor{
    view.backgroundColor = MYCOLORBLUE;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        button_x = frame.origin.x;
        button_y = frame.origin.y;
        button_w = frame.size.width;
        button_h = frame.size.height;
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, button_w, button_h)];
        view.layer.cornerRadius=12.0;
        view.backgroundColor = MYCOLORBLUE;
        
        viewborder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, button_w, button_h)];
        viewborder.backgroundColor = [UIColor clearColor];
        viewborder.layer.borderColor = MYCOLORBLUE.CGColor;
        viewborder.layer.cornerRadius=12.0;
        viewborder.layer.borderWidth = 3.0;
        
        [self addSubview:view];
        [self addSubview:viewborder];
        
        circleView = [[UICircleView alloc]initWithFrame:CGRectMake(0, 0, button_w, button_h) total:1.0 clockwise:YES id:self];
        [self addSubview:circleView];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button_w, button_h)];
        [label setText:@"登陆"];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:label];
        
        aniStopNum = 0;
    }
    
    return self;
    
}
-(void)startAnimation{
    //  该动画效果由两部分组成 一部分方框中间颜色，另一部分方框外部轮廓
    [label removeFromSuperview];
    //边角变为高度的一半
    CABasicAnimation *makeBiggerAnim=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    makeBiggerAnim.fromValue=[NSNumber numberWithDouble:12.0];
    makeBiggerAnim.toValue=[NSNumber numberWithDouble:button_h/2.0];
    
    //位置动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    anim.keyPath = @"bounds";
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(button_x+(button_w-button_h)/2, button_h, button_h, button_h)];
    
    //透明度动画
    CABasicAnimation *animalpha = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    animalpha.keyPath = @"opacity";
    animalpha.toValue = [NSNumber numberWithFloat:0.0];
    
    //第一组动画添加给View
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.3;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode=kCAFillModeForwards ;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:makeBiggerAnim, anim, animalpha,nil];
    
    //边线动画
    CABasicAnimation *animborder = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    animborder.keyPath = @"borderColor";
    //这里把颜色改为了灰色
    UIColor *boardcolor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1.0];
    animborder.toValue = (id)boardcolor.CGColor;
    
    //第二组动画提交
    CAAnimationGroup *groupborder = [CAAnimationGroup animation];
    groupborder.duration = 0.3;
    groupborder.repeatCount = 1;
    groupborder.removedOnCompletion = NO;
    groupborder.fillMode=kCAFillModeForwards ;
    groupborder.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupborder.animations = [NSArray arrayWithObjects:makeBiggerAnim,anim,animborder, nil];
    groupborder.delegate = self;
    [groupborder setValue:@"allMyAnimationsBoard" forKey:@"groupborderkey"];
    [CATransaction begin];
    [view.layer addAnimation:group forKey:@"allMyAnimation"];
    [viewborder.layer addAnimation:groupborder forKey:@"allMyAnimationsBoard"];
    
    [CATransaction commit];
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        NSString *animType = [anim valueForKey:@"groupborderkey"] ;
        NSString *animType1 = [anim valueForKey:@"groupborderkey1"] ;
        if ([animType isEqualToString:@"allMyAnimationsBoard"]) {
            //登录验证之前的动画
            [circleView strokeChart];
        }else if([animType1 isEqualToString:@"allMyAnimationsBoardspread1"]){
            //登录验证之后的动画
            label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button_w, button_h)];
            [label setText:@"登陆成功"];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:20.0];
            [self addSubview:label];
        }
    }
    aniStopNum++;
    if (aniStopNum == 2) {
        // 发送广播 设置按钮使能 改变颜色
        aniStopNum = 0;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"animationStop" object:nil userInfo:nil];
    }
}
-(void)circleAnimationStop{
    
    [circleView removeFromSuperview];
    [self startAnimationSpread:YES];//这里应该从数据库中请求数据，如果登录成功为YES，如果登录失败为NO
}
-(void)startAnimationSpread:(BOOL)loginFlag{
    
    //边角从高的一半变为正常
    CABasicAnimation *makeBiggerAnim=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    makeBiggerAnim.fromValue=[NSNumber numberWithDouble:button_h/2.0];
    makeBiggerAnim.toValue=[NSNumber numberWithDouble:12.0];
    //位置动画变为正常
    CABasicAnimation *anim = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    anim.keyPath = @"bounds";
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(button_x+(button_w-button_h)/2, button_h, button_h, button_h)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, button_w, button_h)];
    //透明度变为正常
    CABasicAnimation *animalpha = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    animalpha.keyPath = @"opacity";
    animalpha.toValue = [NSNumber numberWithFloat:1.0];
    //背景颜色动画
    CABasicAnimation *animbackground = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    animbackground.keyPath = @"backgroundColor";
    UIColor *boardcolorbg = PNFreshGreen;
    //如果登录标志为false的话
    if (loginFlag == false) {
        boardcolorbg = PNFreshRed;
    }
    animbackground.toValue = (id)boardcolorbg.CGColor;
    
    //提交第一组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.3;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode=kCAFillModeForwards ;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:makeBiggerAnim, anim, animalpha,animbackground,nil];
    
    //边线颜色变化动画
    CABasicAnimation *animborder = [CABasicAnimation animation];
    [CABasicAnimation animationWithKeyPath:@""];
    animborder.keyPath = @"borderColor";
    UIColor *boardcolor = PNFreshGreen;
    if (loginFlag == false) {
        boardcolor = PNFreshRed;
    }
    animborder.toValue = (id)boardcolor.CGColor;
    
    //第二组动画提交
    CAAnimationGroup *groupborder = [CAAnimationGroup animation];
    groupborder.duration = 0.3;
    groupborder.repeatCount = 1;
    groupborder.removedOnCompletion = NO;
    groupborder.fillMode=kCAFillModeForwards ;
    groupborder.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    groupborder.animations = [NSArray arrayWithObjects:makeBiggerAnim,anim,animalpha,animborder, nil];
    [CATransaction begin];
    [view.layer addAnimation:group forKey:@"allMyAnimationspread1"];
    [groupborder setValue:@"allMyAnimationsBoardspread1" forKey:@"groupborderkey1"];
    groupborder.delegate = self;
    [viewborder.layer addAnimation:groupborder forKey:@"allMyAnimationsBoardspread1"];
    [CATransaction commit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
