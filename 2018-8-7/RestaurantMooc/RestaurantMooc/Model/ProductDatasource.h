//
//  ProductDatasource.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDatasource : NSObject
@property(nonatomic,strong)NSData *imageData;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle1;
@property(nonatomic,copy)NSString *subTitle2;
@property(nonatomic,copy)NSString *subTitle3;
@property(nonatomic,copy)NSString *saledNum;
@property(nonatomic,assign) int flag;
@end
