//
//  ViewController.m
//  FileHandle
//
//  Created by jitengjiao      on 2018/3/15.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createFile];
//    [self saveImage];
    [self fileHandler];
    
}

-(void)fileHandler{
     NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSString *testPath=[docPath stringByAppendingString:@"/文件5/我的笔记7.txt"];
//    //1.只读方式打开文件
    NSFileHandle *fileHandler=[NSFileHandle fileHandleForReadingAtPath:testPath];
//    NSLog(@"%@",docPath);
//    NSLog(@"%@",[fileHandler readDataToEndOfFile]);
//    [fileHandler closeFile];
//
//    //2.只写方式打开文件，不可以读
//    fileHandler=[NSFileHandle fileHandleForWritingAtPath:testPath];
//    [fileHandler closeFile];
//
//    //3.可读可写方式打开文件，
    fileHandler=[NSFileHandle fileHandleForUpdatingAtPath:testPath];
    
    //a.转化成汉子输出的第一种方法
//    NSData *readData=[fileHandler readDataToEndOfFile];
//    NSString *logString=[[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
//     NSLog(@"%@",logString);
    
    //b.转化成汉子输出的第二种方法
    NSString *logString=[[NSString alloc] initWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",logString);
    
//    NSLog(@"%@",[fileHandler readDataToEndOfFile]);
////    [fileHandler closeFile];
//
//    //从开头读取文件
//    [fileHandler seekToFileOffset:0];//光标置于开头
//    NSLog(@"%@",[fileHandler readDataOfLength:4]);//从光标开始处读取指定长度

    NSString *string=@"哈哈哈";
    [fileHandler writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler synchronizeFile];//让系统立即执行
    [fileHandler closeFile];
    
    
    
}

-(void)saveImage{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSArray *contentsArray=[manager contentsOfDirectoryAtPath:docPath error:nil];//浅度遍历
    NSArray *contentsArray=[manager subpathsOfDirectoryAtPath:docPath error:nil];//深度遍历


    //move操作
//    NSString *testPath=[docPath stringByAppendingString:@"/文件5/我的笔记5.txt"];
//    NSString *toPath=[docPath stringByAppendingString:@"/文件2/我的笔记5.txt"];//移动后的路径需要拼出来
//    [manager moveItemAtPath:testPath toPath:toPath error:nil];
    
    //复制操作
//    NSString *testPath=[docPath stringByAppendingString:@"/文件5/我的笔记6.txt"];
//    NSString *toPath=[docPath stringByAppendingString:@"/文件2/我的笔记6.txt"];//移动后的路径需要拼出来
//    [manager copyItemAtPath:testPath toPath:toPath error:nil];

    //删除操作
//    NSString *testPath=[docPath stringByAppendingString:@"/文件5/我的笔记6.txt"];
//    [manager removeItemAtPath:testPath error:nil];
    
    NSLog(@"%@",docPath);
    NSLog(@"%@",contentsArray);
    
    //返回路径下文件的属性
    NSString *testPath=[docPath stringByAppendingString:@"/文件5/我的笔记7.txt"];
    NSDictionary *dict=[manager attributesOfItemAtPath:testPath error:nil];
    
    NSLog(@"%@",dict);
    
}

-(void)createFile{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *testPath=[docPath stringByAppendingString:@"/文件5"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    BOOL ret=[fileManager createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (ret) {
        NSLog(@"文件夹创建成功！");
        NSString *filePath=[testPath stringByAppendingString:@"/我的笔记7.txt"];
        BOOL file_ret=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (file_ret) {
            NSLog(@"txt文件创建成功");
            NSLog(@"%@",filePath);
            
        }else{
            NSLog(@"txt文件创建失败");
        }
    }else{
        NSLog(@"文件夹创建失败!");
    }
    //    }
    NSString *filePath=[testPath stringByAppendingString:@"/我的笔记7.txt"];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSString *content=@"23";
        BOOL write_ret=[content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (write_ret) {
            NSLog(@"文件写入成功");
        }else{
            NSLog(@"文件写入失败");
        }
        //不能用上面的方式追加内容，会覆盖原有内容，
        NSString *content2=@"   asdasdasdasd";
        NSFileHandle *fileHandler=[NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandler seekToEndOfFile];
        NSData *stringToData=[content2 dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandler writeData:stringToData];
        [fileHandler closeFile];
        NSLog(@"写入完毕");
        
    }else{
        NSLog(@"文件目录下没有该文件");
    }
    
//    //删除文件
//    BOOL delaete_ret=[fileManager fileExistsAtPath:filePath];
//    if (delaete_ret) {
//        if ([fileManager removeItemAtPath:filePath error:nil]) {
//            NSLog(@"删除成功");
//        }else{
//            NSLog(@"删除失败");
//        }
//    }else{
//        NSLog(@"文件不存在");
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
