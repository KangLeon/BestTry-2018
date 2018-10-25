//
//  ViewController.m
//  CoreData1
//
//  Created by jitengjiao      on 2018/3/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"
#import "Status+CoreDataClass.h"

@interface ViewController ()
//一个上下文对应一个数据库
@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,strong)NSManagedObjectContext *weiboCtx;
//记录查找的页数
@property(nonatomic,assign)int count;

@property(strong,nonatomic)NSArray *totalDatas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count=0;
    // Do any additional setup after loading the view, typically from a nib.
    self.context=[self createCtx:@"Student"];
    self.weiboCtx=[self createCtx:@"Weibo"];
}

-(NSManagedObjectContext*)createCtx:(NSString *)name{
    
    //1.上下文 使用上下文 添加数据 查找数据 更新数据
    NSManagedObjectContext *ctx=[[NSManagedObjectContext alloc] init];
    
    //4.创建管理模型(有下面的两种方法)
    //1.添加某一个.xcdatamodel文件到模型管理器中
//    NSManagedObjectModel *modelMgr=[NSManagedObjectModel mergedModelFromBundles:<#(nullable NSArray<NSBundle *> *)#> forStoreMetadata:<#(nonnull NSDictionary<NSString *,id> *)#>]
    //2.查找项目中所有的.xcdatamodel文件 添加到模型管理器中
//    NSManagedObjectModel *modelMgr=[NSManagedObjectModel mergedModelFromBundles:nil];
    
    //一个上下文 应该对应一个数据库
    NSURL *url=[[NSBundle mainBundle]URLForResource:name withExtension:@"momd"];
    NSManagedObjectModel *modelMgr=[[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    
    //3.创建持久存储器对象
    NSPersistentStoreCoordinator *store=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelMgr];
    //存储的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path=[doc stringByAppendingString:[NSString stringWithFormat:@"%@.sqlite",name]];
    NSLog(@"%@",path);
    
    //存储数据的类型和路径
    NSError *error=nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"存储有问题");
    }
    
    //2.设置上下文的持久存储器
    ctx.persistentStoreCoordinator=store;
    
    self.context=ctx;
    
    return ctx;
}

//添加数据
- (IBAction)add:(UIButton *)sender {
    Student *stu=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    stu.name=@"你爸爸";
    stu.age=[NSDate date];
    stu.height=175.0;
    NSError *error=nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"添加学生数据成功");
    }
    
    Status *status=[NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:self.weiboCtx];
    status.text=@"陈赫是猪";
    status.time=[NSDate date];
    
    NSError *weibo_error=nil;
    [self.context save:&weibo_error];
    if (!weibo_error) {
        NSLog(@"添加微博数据成功");
    }
    
}
//删除数据
- (IBAction)delete:(UIButton *)sender {
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",@"你爸爸"];
    request.predicate=predicate;
    
    NSError *error=nil;
    NSArray *datas=[self.context executeFetchRequest:request error:&error];
    if (!error) {
        for (Student *stu in datas) {
            [self.context deleteObject:stu];
            [self.context save:nil];
        }
    }
}
//查找数据
- (IBAction)search:(UIButton *)sender {
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    if (!self.totalDatas) {
        self.totalDatas=[self.context executeFetchRequest:request error:nil];
        
    }
    
        //设置过滤条件
    //模糊查询
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name BEGINSWITH%@",@"你爸爸"];
//    request.predicate=predicate;

    //分页查询
    //查找多少条数据
    request.fetchLimit=2;
    //从那一条开始
    request.fetchOffset=request.fetchLimit*self.count;
    
    //升序
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    request.sortDescriptors=@[sort];
    
    NSError *error=nil;
    NSArray *datas=[self.context executeFetchRequest:request error:&error];
    
    if (request.fetchOffset==self.totalDatas.count) {
        NSLog(@"数据已经没有了");
    }
    
    if (!error) {
        for (Student *student in datas) {
            NSLog(@"name=%@,age=%@,height=%f",student.name,student.age,student.height);
        }
    }
    self.count++;
}
//更新数据
- (IBAction)update:(UIButton *)sender {
    //查找到对应的数据进行更改
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"height=%f",175.0];
    request.predicate=predicate;
    
    NSError *error=nil;
    NSArray *datas=[self.context executeFetchRequest:request error:&error];
    if (!error) {
        for (Student *stu in datas) {
            stu.height=185.0;
            //保存到数据库
            [self.context save:nil];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
