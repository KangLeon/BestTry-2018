//
//  DataSource.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "DataSource.h"
#import "LocationSever.h"


@interface DataSource () {
    int pd_num;//商品个数
    BOOL loginFlag;//当前是否登录成功
    int fruitNum;//水果个数
    NSMutableArray *pd_array;//商品名称的数组
    NSMutableArray *pd_fruit_array;//水果名称数组
    NSMutableArray *pd_food_Array;
    NSString *currentCity;
    FMDatabase *fmdb;
    NSMutableArray *pd_order_array;
}
@end

@implementation DataSource

+(instancetype)getInstance{
    static DataSource *dataSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource=[[DataSource alloc] init];
        [dataSource addInit];
    });
    return dataSource;
}

-(void)addInit{
    loginFlag=false;
    pd_num=0;
    fruitNum=0;
    pd_array=[[NSMutableArray alloc] init];
    pd_fruit_array=[[NSMutableArray alloc] init];
    pd_food_Array=[[NSMutableArray alloc] init];
    pd_order_array=[[NSMutableArray alloc] init];
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    NSString *dbPath=[docPath stringByAppendingString:@"test.db"];
    fmdb=[FMDatabase databaseWithPath:dbPath];
    if ([fmdb open]) {
        NSLog(@"打开成功！");
        NSString *sql = [NSString stringWithFormat:@"create table if not exists table1(id INTEGER PRIMARY KEY AUTOINCREMENT,text TEXT)"];
        BOOL success=[fmdb executeUpdate:sql];
        if (success) {
            NSLog(@"表创建成功");
        }else{
            NSLog(@"表创建失败");
        }
    }
}

-(void)setLoginFlag:(BOOL)flag{
    loginFlag=flag;
}
-(BOOL)getLoginFlag{
    return loginFlag;
}

-(int)getPDNum{
    return pd_num;
}
-(void)setPDNum:(int)num{
    pd_num=num;
}

-(void)loadPDItem:(ProductDatasource*)item{
    [pd_array addObject:item];
}
-(void)loadFruitItem:(ProductDatasource*)item{
    [pd_fruit_array addObject:item];
}
-(void)loadFoodItem:(ProductDatasource*)item{
    [pd_food_Array addObject:item];
}

-(NSMutableArray *)getPdArray{
    return pd_array;
}

-(NSMutableArray *)getFruitArray{
    return pd_fruit_array;
}

-(NSMutableArray *)getFoodArray{
    return pd_food_Array;
}

-(int)getFruitNum{
    return fruitNum;
}
-(void)setFruitNum:(int)num{
    fruitNum=num;
}

-(void)setcurrentCity:(NSString *)str{
    currentCity=str;
}

-(NSString*)getcurrentCity{
    return currentCity;
}

-(void)getLocationdata{
    [[LocationSever getnstance] startLocationServer];
}

-(void)loadOrderItem:(ProductDatasource*)item{
    [pd_order_array addObject:item];
}

-(NSMutableArray *)getOrderArray{
    return pd_order_array;
}

-(FMDatabase*)getFMDB{
    return fmdb;
}

-(void)add:(NSString *)str{
    BOOL success = [fmdb executeUpdate:@"INSERT INTO table1(text) VALUES(?);",str];
    if (success) {
        NSLog(@"insert success");
    }else{
        NSLog(@"insert error");
    }
}

-(void)search{
    NSString *sql=@"SELECT * FROM table1;";
    FMResultSet *set=[fmdb executeQuery:sql];
    while ([set next]) {
        NSString *text=[set stringForColumn:@"text"];
        NSLog(@"%@",text);
    }
}

@end
