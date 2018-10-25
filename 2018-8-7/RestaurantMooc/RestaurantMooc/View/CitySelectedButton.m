//
//  CitySelectedButton.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "CitySelectedButton.h"

@implementation CitySelectedButton
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=50;
    CGFloat h=44;
    return CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=48;
    CGFloat y=(44-15)/2;
    CGFloat w=15;
    CGFloat h=15;
    return CGRectMake(x, y, w, h);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
