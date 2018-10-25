//
//  MyDataSourse.h
//  团购
//
//  Created by jitengjiao      on 2018/2/22.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataSourse : NSObject

@property(strong,nonatomic) NSString *currentCityName;
@property(strong,nonatomic) NSMutableArray *homeProductDataArray;

+(instancetype)sharedMyDataSource;

@end
