//
//  ViewController.m
//  NSURLSession
//
//  Created by jitengjiao      on 2018/3/16.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self download];
}

//下载任务
-(void)download{

    NSURL *url=[NSURL URLWithString:@"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=c1d5f05445c2d562e605d8bf8678fb8a/c995d143ad4bd1130b1de90650afa40f4bfb0535.jpg"];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDownloadTask *download=[session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"loaction=%@",location);
        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image=image;
        });
    }];
    [download resume];
    
}

//这种方法的无法执行
-(void)delegateSession{
    NSArray *arrayG=[NSArray arrayWithObjects:@"IOS",@"PHP",@"AI", nil];
    
    static int counter=0;
    
    NSString *path=[NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1",arrayG[counter]];
    
    //代理方法的，没法执行代理方法，
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request];
    [dataTask resume];
}



-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{

}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",obj);
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error!=nil) {
        NSLog(@"有错误%@",error);
    }
}

-(void)post{
    NSArray *arrayG=[NSArray arrayWithObjects:@"IOS",@"PHP",@"AI", nil];
    
    static int counter=0;
    
    NSString *path=[NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1",arrayG[counter]];
    NSURL *url=[NSURL URLWithString:path];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"post";
    request.HTTPBody=[@"grade_id=2" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",obj);
        }
        //回到主线程的操作
    }];
    [dataTask resume];
}

-(void)get{
    NSArray *arrayG=[NSArray arrayWithObjects:@"IOS",@"PHP",@"AI", nil];
    
    static int counter=0;
    
    NSString *path=[NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1",arrayG[counter]];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",obj);
        }
        //回到主线程的操作
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
