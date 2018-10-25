//
//  CustomView.m
//  AutoLayoutDemo2
//
//  Created by jitengjiao      on 2018/2/19.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "CustomView.h"
#import "Masonry.h"


@interface CustomView ()

@property(nonatomic,strong) UIButton* btnTest;
@property(assign,nonatomic) int btnWidth;

@end

@implementation CustomView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.btnTest=[UIButton new];
        _btnTest.backgroundColor=[UIColor blackColor];
        [_btnTest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_btnTest];
        
        self.btnWidth=100;
      
        [_btnTest addTarget:self action:@selector(btntestClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout{
    return true;
}

-(void)updateConstraints{
    [_btnTest mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(self);
        make.width.equalTo(@(_btnWidth));
        make.height.equalTo(@48);
    }];
    

    [super updateConstraints];//这一句代码时必须的
}

-(void)btntestClick{
    
    _btnWidth=150;
    //有这几句代码的话，就可以触发updateConstrats的代码
    [self setNeedsUpdateConstraints];
}

@end
