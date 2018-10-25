//
//  VegetableManager.m
//  VegManagement
//
//  Created by jitengjiao      on 2018/2/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "VegetableManager.h"
#import <sqlite3.h>

@interface VegetableManager ()

@property (nonatomic,strong) NSArray *vegetablesArray;

@end

@implementation VegetableManager

+(instancetype)sharedInstance{
    static VegetableManager *shared=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared=[[super alloc] initWithUniqueInstance];
    });
    return shared;
}

//单例模式的初始化
-(instancetype)initWithUniqueInstance{
    if(self=[super init]){
        //进行必要的初始化
        NSString *sqlitePath=[self sqlitePath];
        BOOL fileExist=[[NSFileManager defaultManager] fileExistsAtPath:sqlitePath];
        if(!fileExist){
            //文件不存在,创建数据库文件，并且添加数据表
            const char* dbPath=[sqlitePath UTF8String];
            sqlite3 *vegetableDB;
            //打开数据库文件，没有则创建
            if (sqlite3_open(dbPath, &vegetableDB)==SQLITE_OK) {
                NSLog(@"数据库打开/创建成功");
            }else{
                NSLog(@"数据库打开/创建失败");
                return nil;
            }
            
            char sql_stmt[1000]="CREATE TABLE VEGETABLES(ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT<PRICE REAL)";
            //执行语句
            if (sqlite3_exec(vegetableDB, sql_stmt, NULL, NULL, NULL)==SQLITE_OK) {
                NSLog(@"创建数据表成功");
                sqlite3_close(vegetableDB);
            }else{
                NSLog(@"创建数据表失败");
                sqlite3_close(vegetableDB);
                return nil;
            }
        }else{
            //数据库文件存在，读取数据库文件
            [self readVegetableListFromSqlite];
        }
    }
    return self;
}

//返回数据库文件路径
-(NSString*)sqlitePath{
    //获取cache目录
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //拼接数据库文件名
    NSString *dbPath=[cachePath stringByAppendingPathComponent:@"vegetables.sqlite"];
    return dbPath;
}

//从数据中读取蔬菜信息到内存中
-(void)readVegetableListFromSqlite{
    //打开数据库文件
    const char* dbPath=[[self sqlitePath] UTF8String];
    //声明一个sqlite数据库结构体指针
    sqlite3* vegetableDB;
    //打开数据库文件，没有则创建
    if (sqlite3_open(dbPath, &vegetableDB)==SQLITE_OK) {
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
        return;
    }
    
    NSMutableArray *vegetableMutableArray=[NSMutableArray array];
    sqlite3_stmt* statement;
    char sql_stmt[1000]="SELECT ID,NAME,PRICE FROM VEGETABLES";
    //准备sql语句
    sqlite3_prepare_v2(vegetableDB, sql_stmt, -1, &statement, NULL);
    while (sqlite3_step(statement)==SQLITE_ROW) {
        NSInteger index=sqlite3_column_int(statement, 0);
        NSString *vegeName=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
        double price=sqlite3_column_double(statement, 2);
        Vegetable *veg=[[Vegetable alloc] init];
        veg.name=vegeName;
        veg.price=price;
        [vegetableMutableArray addObject:veg];
    }
    NSLog(@"数据库读取完毕");
    _vegetablesArray=[vegetableMutableArray copy];
    
    //清理内存，关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(vegetableDB);
}

//返回蔬菜列表
-(NSArray*)vegetables{
    return [_vegetablesArray copy];
}

//判断蔬菜的名称是否在列表中
-(BOOL)isInListForVegetableName:(NSString*)name{
    for (Vegetable *veg in _vegetablesArray) {
        if ([veg.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

//添加蔬菜
-(BOOL)addVegetable:(Vegetable *)vegetable{
    if ([self isInListForVegetableName:vegetable.name]) {
        NSLog(@"已经存在这个蔬菜");
        return NO;
    }
    
    if (vegetable.name.length==0 || vegetable.price<=0) {
        NSLog(@"蔬菜信息有误");
        return NO;
    }
    
    //打开数据库文件
    const char* dbPath=[[self sqlitePath] UTF8String];
    //声明一个数据库结构体指针
    sqlite3* vegetableDB;
    //打开数据库文件，没有则创建
    if (sqlite3_open(dbPath, &vegetableDB)==SQLITE_OK) {
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
        return NO;
    }
    
    //拼接sqlite语句
    NSString* command=[NSString stringWithFormat:@"INSERT INTO VEGETABLES (NAME,PRICE) VALUES (\"%@\",%lf)",vegetable.name,vegetable.price];
    const char* sql_stmt=[command UTF8String];
    //这里会出错，需要下载网页代码,网页需要续费，但是我就不续费，我一定要解决，
    if (sqlite3_exec(vegetableDB, sql_stmt, NULL, NULL, NULL)==SQLITE_OK) {
        NSLog(@"添加蔬菜成功");
        sqlite3_close(vegetableDB);
        [self readVegetableListFromSqlite];
        return YES;
    }else{
        NSLog(@"添加蔬菜失败");
        sqlite3_close(vegetableDB);
        return NO;
    }
}

//删除蔬菜
-(BOOL)removeVegetableWithName:(NSString*)vegetableName{
    if(![self isInListForVegetableName:vegetableName]){
        NSLog(@"找不到要删除的蔬菜");
        return NO;
    }
    //打开数据库文件
    const char* dbPath=[[self sqlitePath] UTF8String];
    //声明一个数据库结构体指针
    sqlite3* vegetableDB;
    //打开数据库文件，没有则创建
    if (sqlite3_open(dbPath, &vegetableDB)==SQLITE_OK) {
        NSLog(@"数据库文件打开/创建成功");
    }else{
        NSLog(@"数据库文件打开/创建失败");
        return NO;
    }
    
    //拼接sqlite语句
    NSString* command=[NSString stringWithFormat:@"DELETE FROM VEGETABLES WHERE NAME=\"%@\"",vegetableName];
    const char* sql_stmt=[command UTF8String];
    if (sqlite3_exec(vegetableDB, sql_stmt, NULL, NULL, NULL)==SQLITE_OK) {
        NSLog(@"删除蔬菜成功");
        sqlite3_close(vegetableDB);
        [self readVegetableListFromSqlite];
        return YES;
    }else{
        NSLog(@"删除蔬菜失败");
        sqlite3_close(vegetableDB);
        return NO;
    }
}

//修改蔬菜价格
-(BOOL)changePrice:(double)price forVegetableName:(NSString *)vegetableName{
    if (![self isInListForVegetableName:vegetableName]) {
        NSLog(@"找不到要修改的蔬菜");
        return NO;
    }
    
    //打开数据库文件
    const char* dbPath=[[self sqlitePath] UTF8String];
    //声明一个结构体指针
    sqlite3* vegetableDB;
    //打开数据库文件，没有则创建
    if (sqlite3_open(dbPath, &vegetableDB)==SQLITE_OK) {
        NSLog(@"数据库文件打开/创建成功");
    }else{
        NSLog(@"数据库文件打开/创建失败");
        return NO;
    }
    
    //拼接sql语句
    NSString *command=[NSString stringWithFormat:@"UPDATE VEGETABLES SET PRICE=%lf WHERE NAME = \"%@\"",price,vegetableName];
    const char* sql_stmt=[command UTF8String];
    if (sqlite3_exec(vegetableDB, sql_stmt, NULL, NULL, NULL)==SQLITE_OK) {
        NSLog(@"修改蔬菜价格成功");
        sqlite3_close(vegetableDB);
        [self readVegetableListFromSqlite];
        return YES;
    }else{
        NSLog(@"修改蔬菜价格失败");
        sqlite3_close(vegetableDB);
        return NO;
    }
}
@end
