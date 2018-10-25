//
//  StarRateView.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "StarRateView.h"


@interface StarRateView (){
    UIView *foreStarView;
    UIView *backStarView;
    CGFloat currentScore;
}

@end
@implementation StarRateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        foreStarView=[self creatView:@"star_yellow.png" frame:CGRectZero];
        backStarView=[self creatView:@"star_gray.png" frame:self.bounds];
        [self addSubview:backStarView];
        [self addSubview:foreStarView];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGesture.numberOfTapsRequired=1;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)tapAction:(UITapGestureRecognizer*)gesture{
    CGPoint tapPoint=[gesture locationInView:self];
    CGFloat x=tapPoint.x;
    CGFloat realStarScore=x/(self.bounds.size.width/5);
    CGFloat starScore=realStarScore;
    currentScore=starScore/5;
    [self refreshUI];
}

-(void)refreshUI{
    if (currentScore<0) {
        currentScore=0;
    }else if (currentScore>1){
        currentScore=1;
    }
    if ([self.delegate respondsToSelector:@selector(getCurrentScore:)]) {
        [self.delegate getCurrentScore:currentScore];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    foreStarView.frame=CGRectMake(0, 0, self.bounds.size.width*currentScore, self.bounds.size.height);
    [UIView commitAnimations];
}


-(UIView *)creatView:(NSString *)imageName frame:(CGRect)frame{
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.clipsToBounds=true;
    view.backgroundColor=[UIColor clearColor];
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame=CGRectMake(i*self.bounds.size.width/5, 0, self.bounds.size.width/5, self.bounds.size.height);
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
