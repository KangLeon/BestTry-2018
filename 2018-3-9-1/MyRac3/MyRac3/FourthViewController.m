//
//  FourthViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "FourthViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self signalFromJson:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.4.255.255"] subscribeNext:^(id x) {
        NSLog(@"%@",x[@"country"]);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }completed:^{
        
    }];
    
    //RAC关于多线程的处理方法
    RACSignal *s=[self signalFromJson:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.4.255.255"];
    RACSignal *s2=[self signalFromJson:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.4.255.255"];
    RACSignal *s3=[self signalFromJson:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.4.255.255"];

    //还是那个问题，merge方法没有定义，可能的解决思路是，更换一个其他的RAC库可能解决这个问题，
    [[s merge:s2] merge:s3];//这样就可以并行的执行了
    
    [[[s then:^RACSignal *{//then并不是标准的串行的方法，
        return s2;
    }] then:^RACSignal *{
        return s3;
    }] subscribeNext:^(id x) {

    }];
    
    //将三个信号量的合集返回给订阅者
    [[RACSignal combineLatest:@[s,s2,s3]] subscribeNext:^(id x) {

    }];
}

-(RACSignal*)signalFromJson:(NSString*)urlStr{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionConfiguration *c=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:c];
        NSURLSessionDataTask *data=[session dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [subscriber sendError:error];
            }else{
                NSError *e;
                NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
                if (e) {
                    [subscriber sendError:e];
                }else{
                    [subscriber sendNext:jsonDic];
                    [subscriber sendCompleted];
                }
            }
            
        }];
        [data resume];
        return [RACDisposable disposableWithBlock:^{
       
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
