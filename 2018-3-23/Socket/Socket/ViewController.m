//
//  ViewController.m
//  Socket
//
//  Created by jitengjiao      on 2018/3/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

#import <sys/socket.h>//这三个是使用socket所必须导入的头文件
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.创建socket
    //第一个参数 domain 协议簇 指定IPv4
    //第二个参数 type socket的类型 流socket、数据包socket
    //第三个参数 protocol 协议
    //返回值 如果创建成功返回的是socket的描述符，失败为-1
    int clientSocket=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    //2.连接服务器
    //第一个参数：socket描述符
    //第二个参数：结构体 ip地址和端口
    //第三个参数：结构体的长度 sizeof
    //返回值 成功0 失败非0
    struct sockaddr_in addr;
    addr.sin_family=AF_INET;//使用什么类型的地址，4还是6
    addr.sin_addr.s_addr=inet_addr("127.0.0.1");
    addr.sin_port=htons(12345);//计算机存的数据顺序可能不一样，所以需要一个转换，转换成大尾顺序
    int result=connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));//需要转一下，这是c语言的知识
//    if (result==0) {
//        NSLog(@"成功");//使用gNetcat的命令 nc -lk 12345创建服务器
//        //顺便说一下，这里使用了MacPorts软件，他是一个安装其他软件的软件很方便，你只需要搜索有没有这个软件，然后你就可以安装，
//    }else{
//        NSLog(@"失败");
//    }
    if(result!=0){//这样写法相比于上面的，他的好处是可以减少大括号的嵌套
        NSLog(@"失败");
        return;
    }
    
    //3.向服务器发送数据
    //第一个参数指定发送端socket描述符
    //第二个参数是要传的数据，
    //第三个参数是要发送的数据的字节个数
    //第四个参数一般置0，即阻塞或者不阻塞
    //返回值 成功则返回实际传送出去的字符数，失败返回-1 ，
    const char *msg="hello world";
    ssize_t sendcount=send(clientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数 %zd",sendcount);
    
    //4.接受服务器返回的数据
    //返回的是实际接受的字节个数
    //第二参数是接受的字符数组（不准确）
    //第三个参数是接受的字符数组个数（不准确）
    //第四个参数一般置0 即阻塞或者不阻塞
    uint8_t buffer[1024];
    ssize_t recvcount=recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接受的字节数 %zd",recvcount);
    
    //把字节数组转换成字符串
    NSData *data=[NSData dataWithBytes:buffer length:recvcount];
    NSString *recvMsg=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到：%@",recvMsg);
    
    //5.关闭连接
    close(clientSocket);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
