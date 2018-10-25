//
//  ViewController.m
//  Json
//
//  Created by jitengjiao      on 2018/3/12.
//  Copyright © 2018年 MJ. All rights reserved.
//


//这个实例是关于FMDB的，Json是名字写错了，

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arrTitle=[NSArray arrayWithObjects:@"创建数据库",@"插入数据",@"删除数据",@"查找显示", nil];
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(100, 100+80*i, 100, 40);
        btn.tintColor=[UIColor whiteColor];
        btn.backgroundColor=[UIColor blueColor];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=10000+i;
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}

-(void)pressBtn:(UIButton *)btn{
    
    if (btn.tag==10000) {
        //创建打开数据库
        
        //获取数据库的创建路径：/Document目录可以存放数据库
        NSString *strPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        //创建并且打开数据库
        //如果路径下面没有数据库，就创建指定的数据库，如果路径下已经存在数据库，记载数据库到内存
        db=[FMDatabase databaseWithPath:strPath];
        
        if (db!=nil) {
            NSLog(@"数据库创建成功！");
        }
        
        BOOL isOpen=[db open];
        
        if (isOpen) {
            NSLog(@"打开数据库");
        }
        
        NSString *stringCreateTable=@"create table if not exists stu(id integer preimary key,age integer,name varchar(20))";
        
        
        //execute SQL statement
        //return type is BOOL
        BOOL isCreate=[db executeUpdate:stringCreateTable];
        
        if (isCreate==YES) {
            NSLog(@"数据表创建成功");
        }
        
//        BOOL isClose=[db close];
//
//        if (isClose) {
//            NSLog(@"关闭数据库");
//        }
        
    }else if(btn.tag==10001){
//        //获取数据库的创建路径：/Document目录可以存放数据库
//        NSString *strPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
//
//        //创建并且打开数据库
//        //如果路径下面没有数据库，就创建指定的数据库，如果路径下已经存在数据库，记载数据库到内存
//        db=[FMDatabase databaseWithPath:strPath];
//
//        if (db!=nil) {
//            NSLog(@"数据库创建成功！");
//        }
        //添加数据库数据
        if (db!=nil) {
            if([db open]){
                NSString *insert=@"insert into stu values(1,9,'Jack')";
                
                BOOL isOK=[db executeUpdate:insert];
                
                if (isOK==YES) {
                    NSLog(@"添加数据成功");
                }
            }
        }
        
    }else if (btn.tag==10002){
        //删除数据
        NSString *delete=@"delete from stu where name='Jack'";
        if ([db open]) {
            BOOL isOk=[db executeUpdate:delete];
            if(isOk==YES){
                NSLog(@"删除数据成功");
            }
        }
        
    }else if (btn.tag==10003){
        //创建打开数据库
        
        //获取数据库的创建路径：/Document目录可以存放数据库
        NSString *strPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        //创建并且打开数据库
        //如果路径下面没有数据库，就创建指定的数据库，如果路径下已经存在数据库，记载数据库到内存
        db=[FMDatabase databaseWithPath:strPath];
        
        if (db!=nil) {
            NSLog(@"数据库创建成功！");
        }
        
        BOOL isOpen=[db open];
        
        if (isOpen) {
            NSLog(@"打开数据库");
        }
        //查找并打印数据
        NSString *query=@"select * from stu";

        if ([db open]) {
            
            
            FMResultSet *result=[db executeQuery:query];
            
            //由于返回的是一个set，所以遍历所有结果
            while ([result next]) {
                //获取id字段内容(根据字段名字来获取)
                NSInteger stuID=[result intForColumn:@"id"];
                //获取age内容(根据字段名字来获取)
                NSInteger stuAge=[result intForColumn:@"age"];
                //获取name字段内容(根据字段名字来获取)
                NSString *stuName=[result stringForColumn:@"name"];
                
//                //获取id字段内容(根据字段索引来获取)
//                NSInteger stuID=[result intForColumnIndex:@"id"];
//                //获取age内容(根据字段索引来获取)
//                NSInteger stuAge=[result intForColumnIndex:@"age"];
//                //获取name字段内容(根据字段索引来获取)
//                NSString *stuName=[result stringForColumnIndex:@"name"];
                
                NSLog(@"stu id=%ld, name=%@, age=%ld",(long)stuID,stuName,(long)stuAge);
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
