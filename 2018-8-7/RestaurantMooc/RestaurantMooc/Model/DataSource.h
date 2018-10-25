//
//  DataSource.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDatasource.h"
#import "FMDB.h"
@interface DataSource : NSObject
+(instancetype)getInstance;

-(void)setLoginFlag:(BOOL)flag;
-(BOOL)getLoginFlag;

-(int)getPDNum;
-(void)setPDNum:(int)num;

-(void)loadPDItem:(ProductDatasource*)item;
-(void)loadFruitItem:(ProductDatasource*)item;
-(void)loadFoodItem:(ProductDatasource*)item;

-(NSMutableArray *)getPdArray;
-(NSMutableArray *)getFruitArray;
-(NSMutableArray *)getFoodArray;

-(int)getFruitNum;
-(void)setFruitNum:(int)num;

-(void)setcurrentCity:(NSString *)str;
-(NSString*)getcurrentCity;

-(void)getLocationdata;

-(void)loadOrderItem:(ProductDatasource*)item;
-(NSMutableArray *)getOrderArray;
-(FMDatabase*)getFMDB;
-(void)add:(NSString *)str;
-(void)search;
@end
