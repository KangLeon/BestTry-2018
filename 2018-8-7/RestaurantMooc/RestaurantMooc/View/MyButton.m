//
//  MyButton.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MyButton.h"

@interface MyButton (){
    CGRect imageRect;
    CGRect titleRect;
}

@end

@implementation MyButton
-(id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect)titleFrame{
    self=[super initWithFrame:frame];
    if (self) {
        imageRect=imageFrame;
        titleRect=titleFrame;
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=titleRect.origin.x;
    CGFloat y=titleRect.origin.y;
    CGFloat w=titleRect.size.width;
    CGFloat h=titleRect.size.height;
    return CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=imageRect.origin.x;
    CGFloat y=imageRect.origin.y;
    CGFloat w=imageRect.size.width;
    CGFloat h=imageRect.size.height;
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
