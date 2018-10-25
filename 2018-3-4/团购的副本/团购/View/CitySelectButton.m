//
//  CitySelectButton.m
//  团购
//
//  Created by jitengjiao      on 2018/2/20.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "CitySelectButton.h"

@implementation CitySelectButton

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

//这是重写方法
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=50;
    CGFloat h=44;
    return CGRectMake(x, y, w, h);
}

//这是重写方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w=15;
    CGFloat h=15;
    CGFloat x=50;
    CGFloat y=(44-15)/2;
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
