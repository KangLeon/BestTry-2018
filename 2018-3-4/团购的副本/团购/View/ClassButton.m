//
//  ClassButton.m
//  团购
//
//  Created by jitengjiao      on 2018/2/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ClassButton.h"
@interface ClassButton (){
    CGRect imageRect;
    CGRect titleRect;
}
@end
@implementation ClassButton
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

//这是重写方法
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=titleRect.origin.x;
    CGFloat y=titleRect.origin.y;
    CGFloat w=titleRect.size.width;
    CGFloat h=titleRect.size.width;
    return CGRectMake(x, y, w, h);
}

//这是重写方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w=imageRect.origin.x;
    CGFloat h=imageRect.origin.y;
    CGFloat x=imageRect.size.width;
    CGFloat y=imageRect.size.height;
    return CGRectMake(x, y, w, h);
}
@end
