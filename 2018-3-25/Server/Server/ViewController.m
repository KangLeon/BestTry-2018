//
//  ViewController.m
//  Server
//
//  Created by jitengjiao      on 2018/3/24.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
@interface ViewController ()<GCDAsyncSocketDelegate>

//用于监听的socket
@property(strong,nonatomic)GCDAsyncSocket *listenSocket;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(GCDAsyncSocket *)listenSocket{
    if (_listenSocket==nil) {
        _listenSocket=[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0) socketQueue:NULL];
    }
    return _listenSocket;
}

- (IBAction)clickStart:(id)sender {
    //绑定ip&监听端口&接受新连接封装在一个方法中
    NSError *error=nil;
    [_listenSocket acceptOnInterface:@"127.0.0.1" port:1234 error:&error];
    if (error==nil) {
        NSLog(@"服务器开启成功");//没有成功
    }else{
        NSLog(@"服务器开启失败");
    }
}

////已经接受到新的连接后调用
////第一个参数：服务端用于监听的socket
////第二个参数：服务器用于数据交互的socket
//-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
//    NSLog(@"接受到新的连接");
//}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
