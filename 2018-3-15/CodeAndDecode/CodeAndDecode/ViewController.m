//
//  ViewController.m
//  CodeAndDecode
//
//  Created by jitengjiao      on 2018/3/15.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *decode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    User *user=[[User alloc] init];
    user.name=@"刘在石";
    user.age=22;
    user.sex=@"男";
    
    User *user2=[[User alloc] init];
    user2.name=@"李光洙";
    user2.age=22;
    user2.sex=@"男";
    
    //单个对象归档
//    NSData *personData=[NSKeyedArchiver archivedDataWithRootObject:user];
//    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath=[docPath stringByAppendingString:@"/user/personData.rtf"];
//    NSLog(@"%@",filePath);
//    [personData writeToFile:filePath atomically:YES];
    
    //多个对象归档
//    NSMutableData *mutableData=[NSMutableData data];
//    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
//    [archiver encodeObject:user forKey:@"user"];
//    [archiver encodeObject:user2 forKey:@"user2"];
//    [archiver finishEncoding];
//
//    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath=[docPath stringByAppendingString:@"/user/personData.rtf"];
//    NSLog(@"%@",filePath);
//    [mutableData writeToFile:filePath atomically:YES];
    
    //runtime方法的存档

    //这里以temp路径为例，存到temp路径下
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"obj.data"]; //注：保存文件的扩展名可以任意取，不影响。
    NSLog(@"%@", filePath);
    //归档
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
    [NSKeyedArchiver archiveRootObject:user2 toFile:filePath];
 
}

- (IBAction)decodeButton:(UIButton *)sender {
    //单个对象接档的方法
//    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath=[docPath stringByAppendingString:@"/user/personData.rtf"];
//    NSData *readData=[NSData dataWithContentsOfFile:filePath];
//    User *resultUser=[NSKeyedUnarchiver unarchiveObjectWithData:readData];
//    NSLog(@"姓名：%@，年龄：%ld，性别：%@",resultUser.name,(long)resultUser.age,resultUser.sex);
    
    //runtime的解档
    //取出归档的文件再解档
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"obj.data"];
    //解档
    User *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"name = %@, age = %ld, sex=%@",user.name,user.age,user.sex);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
