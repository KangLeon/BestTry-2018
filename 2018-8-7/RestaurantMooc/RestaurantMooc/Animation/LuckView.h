//
//  LuckView.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/10.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LuckViewDelegate<NSObject>

-(void)luckViewDidStop:(int)index;

@end

@interface LuckView : UIView

@property(nonatomic,weak)id <LuckViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)array;
@end
