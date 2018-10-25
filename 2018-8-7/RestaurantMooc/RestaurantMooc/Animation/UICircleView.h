//
//  UICircleView.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol circleToButtonViewDelegate

-(void)circleAnimationStop;

@end


@interface UICircleView : UIView

@property(nonatomic,weak)id <circleToButtonViewDelegate> circleDelegate;

-(id)initWithFrame:(CGRect)frame total:(float)total clockwise:(BOOL)clockwise id:del;
-(void)strokeChart;

@end
