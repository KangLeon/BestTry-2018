//
//  Util.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/7.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height


#define APPCURRENTNUM 2.0

#define MYCOLORYELLOW [UIColor colorWithRed:0.08823 green:0.6549 blue:0.12549 alpha:1.0]

#define MYCOLORBLUE [UIColor colorWithRed:0.06666 green:0.48235 blue:0.996 alpha:1.0]

#define FOODURL @"http://www.imooc.com/api/restgetfood"
#define FRUITURL @"http://www.imooc.com/api/restgetfruit"
#define LOGININURL @"http://www.imooc.com/api/restlogin"

#define PNFreshBlue [UIColor colorWithRed:25.0 / 255.0 green:155.0 / 255.0 blue:200.0 / 255.0 alpha:1.0f]
#define PNFreshGreen [UIColor colorWithRed:150.0 / 255.0 green:203.0 / 255.0 blue:25.0 / 255.0 alpha:1.0f]
#define PNFreshRed [UIColor colorWithRed:241 / 255.0 green:63 / 255.0 blue:75 / 255.0 alpha:1.0f]
#define preAnimTime 1.
#define aftAnimTime 1.

#define PNFreshBlue [UIColor colorWithRed:25.0 / 255.0 green:155.0 / 255.0 blue:200.0 / 255.0 alpha:1.0f]
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface Util : NSObject

@end
