//
//  IMNetwork.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMNetwork : NSObject
-(void)getProductInfo:(NSString *)urlString;
-(void)login:(NSString*)urlString userName:(NSString *)userName password:(NSString*)password;
@end
