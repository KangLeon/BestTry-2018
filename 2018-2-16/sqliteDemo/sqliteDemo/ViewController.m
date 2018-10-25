//
//  ViewController.m
//  sqliteDemo
//
//  Created by jitengjiao      on 2018/2/16.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createTableAction:(UIButton *)sender {
    [self createSqliteTable];
}
- (IBAction)addRowAction:(UIButton *)sender {
    [self addRow];
}
- (IBAction)deleteRowAction:(id)sender {
    [self deleteRow];
}
- (IBAction)modifyRowAction:(id)sender {
    [self modifyRow];
}
- (IBAction)readRowsAction:(id)sender {
    [self readRows];
}


//返回数据库文件的位置
-(NSString *)sqliteFilePath{
    
    //获取Cache目录
    NSString* cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //拼接文件名
    NSString *databasePath=[cachePath stringByAppendingPathComponent:@"contacts.sqlite"];
    return databasePath;
}

//创建数据表
-(void)createSqliteTable{
    //获取数据库文件路径
    NSString *dbFilePath=[self sqliteFilePath];
    //将路径字符串转换成UTF-8
    char* dbPath=[dbFilePath UTF8String];
    //声明sqlite数据库结构体的指针
    sqlite3* contactDB;
    if(sqlite3_open(dbPath,&contactDB)==SQLITE_OK){
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
    }
    
    //生成指令
    char sqlite_stmt[1000];
    snprintf(sqlite_stmt, 1000,"CREATE TABLE CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT,ADDRESS TEXT,PHONE TEXT)");
    //执行语句
    if(sqlite3_exec(contactDB, sqlite_stmt, NULL, NULL, NULL)==SQLITE_OK){
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
    //关闭数据库
    sqlite3_close(contactDB);
}

//增加数据
-(void)addRow{
    //获取数据库文件路径
    NSString *dbFilePath=[self sqliteFilePath];
    //将路径字符串转换成UTF-8
    char* dbPath=[dbFilePath UTF8String];
    //声明sqlite数据库结构体的指针
    sqlite3* contactDB;
    if(sqlite3_open(dbPath,&contactDB)==SQLITE_OK){
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
    }
    
    //创建指令
    char sqlite_stmt[1000];
    snprintf(sqlite_stmt, 1000,"INSERT INTO CONTACTS (NAME,ADDRESS,PHONE) VALUES (\"张三\",\"南京路\",\"18687727737\")");
    
    //执行指令
    if(sqlite3_exec(contactDB, sqlite_stmt, NULL, NULL, NULL)==SQLITE_OK){
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
    
    //关闭数据库
    sqlite3_close(contactDB);
    
}

//删除数据
-(void)deleteRow{
    //获取数据库文件路径
    NSString *dbFilePath=[self sqliteFilePath];
    //将路径字符串转换成UTF-8
    char *dbPath=[dbFilePath UTF8String];
    //声明sqlite数据库结构体指针
    sqlite3* contactDB;
    if(sqlite3_open(dbPath,&contactDB)==SQLITE_OK){
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
    }
    
    //创建指令
    char sqlite_stmt[1000];
    snprintf(sqlite_stmt, 1000, "DELETE FROM CONTACTS WHERE NAME=\"张三\"");
    //执行指令
    if (sqlite3_exec(contactDB, sqlite_stmt, NULL, NULL, NULL)) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据表失败");
    }
    
    //关闭数据库
    sqlite3_close(contactDB);
    
}

//修改数据
-(void)modifyRow{
    //获取数据库文件路径
    NSString *dbFilePath=[self sqliteFilePath];
    //将路径字符串转换成UTF-8
    char *dbPath=[dbFilePath UTF8String];
    //声明sqlite数据库结构体指针
    sqlite3 *contactDB;
    if (sqlite3_open(dbPath, &contactDB)) {
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
    }
    
    //创建指令
    char sqlite_stmt[1000];
    snprintf(sqlite_stmt, 1000, "UPDATE CONTACTS SET NAME=\"王五\" WHERE NAME=\"张三\"");
    //执行指令
    if (sqlite3_exec(contactDB, sqlite_stmt, NULL, NULL, NULL)) {
        NSLog(@"更新数据表成功");
    }else{
        NSLog(@"更新数据表失败");
    }
    
    //关闭数据库
    sqlite3_close(contactDB);
}

//查询数据
-(void)readRows{
    //获取数据库文件路径
    NSString *dbFilePath=[self sqliteFilePath];
    //将字符串路径专户成UTF-8
    char *dbPath=[dbFilePath UTF8String];
    //声明数据库结构体指针
    sqlite3 *contactDB;
    if (sqlite3_open(dbPath, &contactDB)==SQLITE_OK) {
        NSLog(@"数据库打开/创建成功");
    }else{
        NSLog(@"数据库打开/创建失败");
    }
    
    //创建指令
    char sqlite_stmt[1000];
    snprintf(sqlite_stmt, 1000, "SELECT * FROM CONTACTS");
    
    //准备一个SQLITE语句，用于执行
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(contactDB, sqlite_stmt, -1, &statement, NULL);
    
    //执行一条准备的语句，如果找到一行匹配的数据，则返回SQLITE_ROW
    while (sqlite3_step(statement)==SQLITE_ROW) {
        //获取到一行数据
        NSInteger index=sqlite3_column_int(statement, 0);
        NSString *name=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
        NSString *address=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
        NSString *phone=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3)];
        NSLog(@"%ld | %@ | %@ | %@",index,name,address,phone);
    }
    
    NSLog(@"数据库读取完毕");
    
    //在内存中，清理之前准备的语句
    sqlite3_finalize(statement);
    
    //关闭数据库
    sqlite3_close(contactDB);
    
}

@end
