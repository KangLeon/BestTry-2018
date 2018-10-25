//
//  StarRateView.h
//  团购
//
//  Created by jitengjiao      on 2018/3/3.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarRateViewDelegate<NSObject>

-(void)getCurrentScore:(CGFloat)currentScore;

@end
@interface StarRateView : UIView

@property(nonatomic,weak)id<StarRateViewDelegate> delegate;

@end
