//
//  StarRateView.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartRateviewDelegate<NSObject>

-(void)getCurrentScore:(CGFloat)currentScore;

@end

@interface StarRateView : UIView
@property(nonatomic,weak)id <StartRateviewDelegate> delegate;
@end
