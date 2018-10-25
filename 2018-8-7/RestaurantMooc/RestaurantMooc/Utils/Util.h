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
@interface Util : NSObject

@end
