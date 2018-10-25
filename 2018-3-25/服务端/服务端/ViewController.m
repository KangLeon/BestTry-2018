//
//  ViewController.m
//  服务端
//
//  Created by jitengjiao      on 2018/3/24.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <GCDAsyncSocket.h>

@interface ViewController ()<GCDAsyncSocketDelegate>

//用于监听的socket
@property(strong,nonatomic)GCDAsyncSocket *listenSocket;
@property(nonatomic,strong)NSMutableArray *connectedSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

//点击开始服务器
- (IBAction)clickStart:(NSButton *)sender {
    //绑定ip&监听端口&接受新连接封装在一个方法中
//    BOOL success=[_listenSocket acceptOnInterface:@"127.0.0.1" port:54321 error:nil];
    NSError *error = nil;
    [_listenSocket acceptOnPort:54321 error:&error];
    
    if (error == nil) {
        NSLog(@"服务器开启成功");
    }else{
        NSLog(@"服务器开启失败");
    }
    
}
//已经接受到新的连接后调用
//第一个参数：服务端用于监听的socket
//第二个参数：服务器用于数据交互的socket
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"接受到来自%@新的连接",newSocket.connectedHost);
    [self.connectedSocket addObject:newSocket];
    
    //设置欢迎信息
    NSString *str=[NSString stringWithFormat:@"欢迎连接我的服务器～"];
    [newSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
//    //设置定时器 轮询
//    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(readData:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [newSocket readDataWithTimeout:-1 tag:0];//这个地方只能接受一次，不阻塞的方式
}

//-(void)readData:(NSTimer*)obj{
//    GCDAsyncSocket *socket=obj.userInfo;
//    [socket readDataWithTimeout:-1 tag:0];//这个地方只能接受一次，不阻塞的方式
//}

//已经接受到数据后调用
//第一个参数 服务端用于数据交互的socket
//第二个参数 接受到的数据
//第三个参数 标记
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
     [sock readDataWithTimeout:-1 tag:0];//这个地方只能接受一次，不阻塞的方式
    
    //转发数据给其他用户
    for (GCDAsyncSocket *connect in self.connectedSocket) {
        if (connect!=sock) {
            [connect writeData:data withTimeout:-1 tag:0];
        }
    }
}


-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"已经发送数据后调用");
}

//懒加载
-(GCDAsyncSocket *)listenSocket{
    if (_listenSocket==nil) {
        _listenSocket=[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0) socketQueue:NULL];
    }
    return _listenSocket;
}

-(NSMutableArray*)connectedSockets{
    if (_connectedSocket==nil) {
        _connectedSocket=[NSMutableArray array];
    }
    return _connectedSocket;
}



//相当于viewWillAppeaar
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




@end
