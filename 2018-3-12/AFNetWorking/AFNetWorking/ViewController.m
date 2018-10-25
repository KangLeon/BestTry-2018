//
//  ViewController.m
//  AFNetWorking
//
//  Created by jitengjiao      on 2018/3/12.
//  Copyright © 2018年 MJ. All rights reserved.
//

//是关于AFNetworking，但是我想通过进度条显示出来却没办法，

#import "ViewController.h"
#import "AFNetWorking.h"

@interface ViewController ()
@property(strong,nonatomic) UIProgressView *myProgress;
@property(assign,nonatomic) float percent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self AFNetMonitor];
 
    _myProgress=[[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 10)];
    _myProgress.progressTintColor=[UIColor blueColor];
    _myProgress.progressViewStyle=UIProgressViewStyleDefault;
    _myProgress.trackTintColor=[UIColor grayColor];
    
    [self.view addSubview:_myProgress];
    [self AFGetData];
}


-(void)AFGetData{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    [session GET:@"https://www.baidu.com" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
             self.percent=downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;//怎么动态的显示出来
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功回调代码块
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"返回数据%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败回调代码块
        if (error!=nil) {
            NSLog(@"不好意思，失败了%@",error);
        }
    }];
}

//检测当前网络模式，可以通过label显示到手机界面上，也可以通过alert弹出去显示，但是想想需求的话，除了无网络连接会弹，别的情况是不需要弹的，
-(void)AFNetMonitor{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"无网络连接");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"通过wifi连接的网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"通过用4G网络连接");
                break;
            }
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知网络");
                break;
            }
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
