//
//  ViewController.m
//  客户端
//
//  Created by jitengjiao      on 2018/3/24.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>
@property(strong,nonatomic)GCDAsyncSocket *clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //建立连接
    [self.clientSocket connectToHost:@"127.0.0.1" onPort:54321 error:nil];
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"已经连接成功后调用");//为什么这个就可以连接呢，是真的奇怪？
    //读取数据
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //发送数据
    NSString *str=@"你好，我是客户端";
    [self.clientSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    //接受数据
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

//懒加载
-(GCDAsyncSocket *)clientSocket{
    if (_clientSocket==nil) {
        _clientSocket=[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:NULL];
    }
    return _clientSocket;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
