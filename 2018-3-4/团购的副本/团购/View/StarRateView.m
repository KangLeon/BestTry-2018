//
//  StarRateView.m
//  团购
//
//  Created by jitengjiao      on 2018/3/3.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "StarRateView.h"

//该类会用到很多内部变量，所以我们创建一个interface，但是在oc里严格上讲并不存在私有变量
@interface StarRateView (){
    UIView *foreStarview;
    UIView *backStarView;
    CGFloat currentScore;
}

@end
@implementation StarRateView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        foreStarview=[self createView:@"星星.png" frame:CGRectZero];
        backStarView=[self createView:@"星星灰.png" frame:self.bounds];
        [self addSubview:backStarView];
        [self addSubview:foreStarview];
       
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGesture.numberOfTapsRequired=1;//需要单击
        [self addGestureRecognizer:tapGesture];
    }
     return self;
}

-(void)tapAction:(UITapGestureRecognizer *)gesture{
    CGPoint tapPoint=[gesture locationInView:self];
    CGFloat x=tapPoint.x;
    CGFloat realativeStarScore=x/(self.bounds.size.width/5);
    CGFloat startScore=realativeStarScore;
    currentScore=startScore/5;
    [self refreshUI];
}

-(void)refreshUI{
    if (currentScore<0) {
        currentScore=0;
    }else if (currentScore>1){
        currentScore=1;
    }
    
    //检查delegate方法是否存在
    if ([self.delegate respondsToSelector:@selector(getCurrentScore:)]) {
        [self.delegate getCurrentScore:currentScore];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    foreStarview.frame=CGRectMake(0, 0, self.bounds.size.width*currentScore, self.bounds.size.height);
    [UIView commitAnimations];
}

-(UIView *)createView:(NSString *)imageName frame:(CGRect)frame{
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.clipsToBounds=true;//这个属性的作用是为了裁剪的方便
    view.backgroundColor=[UIColor clearColor];
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame=CGRectMake(i*self.bounds.size.width/5, 0, self.bounds.size.width/5, self.bounds.size.height);
        imageView.contentMode=UIViewContentModeScaleAspectFit;//拉伸效果合适
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
