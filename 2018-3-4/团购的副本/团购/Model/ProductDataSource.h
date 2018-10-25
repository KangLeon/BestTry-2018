//
//  ProductDataSource.h
//  团购
//
//  Created by jitengjiao      on 2018/3/2.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDataSource : NSObject
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *discount;
@property(nonatomic,copy)NSString *sale;
@end
