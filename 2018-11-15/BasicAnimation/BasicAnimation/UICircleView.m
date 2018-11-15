//
//  UICircleView.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "UICircleView.h"
#import "Util.h"

@interface UICircleView()<CAAnimationDelegate>{
    
}
//@property (nonatomic) NSNumber *lineWidth;
//@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) CAShapeLayer *circle;
@end

@implementation UICircleView
-(id)initWithFrame:(CGRect)frame total:(float)total clockwise:(BOOL)clockwise id:del{
    if ([super initWithFrame:frame]) {
        CGFloat startAngle=clockwise?-90.0f:270.0f;//起始角度
        CGFloat endAngle=clockwise?-90.01f:270.01f;//终止角度
        UIBezierPath *circlePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:frame.size.height/2-2 startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:clockwise];
        self.circle=[CAShapeLayer layer];
        self.circle.path=circlePath.CGPath;
        self.circle.lineCap=kCALineCapRound;
        self.circle.fillColor=[UIColor clearColor].CGColor;
        self.circle.lineWidth=3.0;
        self.circle.zPosition=1;
        [self.layer addSublayer:self.circle];
        self.circleDelegate=del;
    }
    return self;
}
-(void)strokeChart{
    self.circle.lineWidth=3.0;
    self.circle.strokeColor=MYCOLORBLUE.CGColor;
    //裁剪动画
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.delegate=self;
    pathAnimation.duration=1.0;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue=@0.0f;
    pathAnimation.toValue=@1.0f;
    [pathAnimation setValue:@"strokeEndAnimationcircle" forKey:@"groupborderkeycircle"];
    [self.circle addAnimation:pathAnimation forKey:@"strokeEndAnimationcircle"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.circleDelegate circleAnimationStop];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
