//
//  TestViewController.h
//  Popover
//
//  Created by jitengjiao      on 2018/3/8.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define MYGRAYCOLOR [UIColor colorWithRed:214.0/255.0 green:223.0/255.0 blue:214.0/255.0 alpha:1.0];
#define MYGREENCOLOR [UIColor colorWithRed:0.16 green:0.72 blue:0.55 alpha:1.0];

@protocol BackString <NSObject>
-(void)getMyString:(NSString *)string;

@end

@interface TestViewController : UIViewController
@property(weak,nonatomic)id<BackString> delegate;


@end
