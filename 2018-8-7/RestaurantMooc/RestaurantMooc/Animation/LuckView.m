//
//  LuckView.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/10.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "LuckView.h"
#import "Util.h"

@interface LuckView (){
    NSTimer *timer;
    CGFloat intervalTimer;
    int allCount;
    int currentRunCount;
    NSArray *imagesArray;
    NSMutableArray *btArray;
    UIButton *currentBt;
}
@end

@implementation LuckView

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)array{
    if ([super initWithFrame:frame]) {
        imagesArray=array;
        btArray=[[NSMutableArray alloc] init];
        CGFloat bt_w=(self.frame.size.width-(3-1)*50)/3;
        CGFloat bt_h=(self.frame.size.height-(3-1)*50)/3;
        for (int i=0; i<imagesArray.count; i++) {
            UIButton *bt_i=[UIButton buttonWithType:UIButtonTypeCustom];
            bt_i.frame=CGRectMake((i%3)*bt_w+50, (i/3)*bt_h+50, bt_w, bt_h);
            bt_i.backgroundColor=[UIColor clearColor];
            [self addSubview:bt_i];
            
            if (i==4) {
                [bt_i setTitle:@"抽奖" forState:UIControlStateNormal];
                [bt_i setTitleColor:MYCOLORBLUE forState:UIControlStateNormal];
                [bt_i setBackgroundColor:MYCOLORYELLOW];
                bt_i.layer.cornerRadius=bt_w/2.0;
                [bt_i addTarget:self action:@selector(luckBegin:) forControlEvents:UIControlEventTouchUpInside];
                continue;//当前循环终止，马上进行下一次循环
            }
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, bt_w-16, bt_h-16)];
            imageView.image=[UIImage imageNamed:[imagesArray objectAtIndex:i>4?i-1:i]];
            [bt_i addSubview:imageView];
            [btArray addObject:bt_i];
        }
        [self changeframe:btArray[3] sbt:btArray[4]];
        [self changeframe:btArray[4] sbt:btArray[7]];
        [self changeframe:btArray[5] sbt:btArray[6]];
    }
    return self;
}

-(void)changeframe:(UIButton*)fbt sbt:(UIButton*)sbt{
    CGRect frame=fbt.frame;
    fbt.frame=sbt.frame;
    sbt.frame=frame;
}

-(void)luckBegin:(UIButton*)btn{
    allCount=25;
    timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(start:) userInfo:nil repeats:true];
}

-(void)start:(NSTimer*)timer{
    if (currentBt) {
        currentBt.backgroundColor=[UIColor clearColor];
    }
    UIButton *oldBt=[btArray objectAtIndex:currentRunCount&btArray.count];
    oldBt.backgroundColor=[UIColor orangeColor];
    currentBt=oldBt;
    currentRunCount++;
    if (currentRunCount>allCount) {
        [timer invalidate];
        [self stopBtAnimation:currentBt];
        [self stopWithCount:currentRunCount&btArray.count];
        return;
        if (currentRunCount>allCount-5) {
            intervalTimer+=0.1;
            timer=[NSTimer scheduledTimerWithTimeInterval:intervalTimer target:self selector:@selector(start:) userInfo:nil repeats:true];
        }
    }
}

-(void)stopBtAnimation:(UIButton*)button{
    CABasicAnimation *anim=[CABasicAnimation animation];
    anim.fromValue=[UIColor orangeColor];
    anim.toValue=MYCOLORYELLOW;
    anim.keyPath=@"backgroundColor";
    anim.duration=0.1;
    anim.autoreverses=YES;
    anim.removedOnCompletion=NO;
    anim.fillMode=kCAFillModeForwards;
    anim.repeatCount=MAXFLOAT;
    anim.beginTime=0.5;
    [currentBt.layer addAnimation:anim forKey:@"luckAnimation"];
}

-(void)stopWithCount:(int)count{
    [self.delegate luckViewDidStop:count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
