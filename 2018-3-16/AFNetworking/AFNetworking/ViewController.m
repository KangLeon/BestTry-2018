//
//  ViewController.m
//  AFNetworking
//
//  Created by jitengjiao      on 2018/3/16.
//  Copyright © 2018年 MJ. All rights reserved.
//

//这是对AFNetworking的学习，可以检测用户下载进度，注释掉的方法不可用，

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test1];
}

-(void)test2{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSDictionary *dict=@{@"grade_id":@"2"};
    [manager GET:@"http://new.api.bandu.cn/book/listofgrade" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误=%@",error);
    }];

}


-(void)test1{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSURL *url=[NSURL URLWithString:@"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=c1d5f05445c2d562e605d8bf8678fb8a/c995d143ad4bd1130b1de90650afa40f4bfb0535.jpg"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //    NSProgress *progress=nil;
    NSURLSessionDownloadTask *task=[manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        NSLog(@"progress is %@", downloadProgress);
        NSLog(@"下载进度%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *location=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@",[NSURL fileURLWithPath:location]);
        return [NSURL fileURLWithPath:location];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath=%@",filePath);
        NSLog(@"--error=%@",error);
        //        [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
    }];
    [task resume];
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSProgress *progress=(NSProgress*)object;
//    NSLog(@"下载进度%f",1.0*progress.completedUnitCount/progress.totalUnitCount);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
