//
//  ViewController.m
//  请求百度
//
//  Created by jitengjiao      on 2018/3/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <sys/socket.h>//这三个是使用socket所必须导入的头文件
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(assign,nonatomic)int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.连接百度的服务器 ,到gnetcat上ping百度就可以得到百度的ip地址
    BOOL result=[self connect:@"119.75.216.20" port:80];
    if (!result) {
        NSLog(@"连接失败");
        return;
    }
    NSLog(@"连接成功");
    
    //构造http请求头
    NSString *request=@"GET / HTTP/1.1\r\n"
    "Host: www.baidu.com\r\n"
    "User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Mobile Safari/537.36\r\n"
    "Connection: keep-alive\r\n\r\n";//这是一种换行连接方式，好他妈的神奇啊，
    //http1.0短连接，响应结束后立即断开
    //http1.1长连接，响应结束后，连接会等待非常短的时间，如果这个时间内没有新的请求，就断开连接，是为了提高服务器的性能，，但是只要把Connection：改为keep-alive就可以了，
    
    
    //服务器返回的响应头和响应体
    NSString *response=[self sendAndRecv:request];
    
    //截取响应头，留下响应体，相应头结束的表示是\r\n\r\n
    NSRange range=[response rangeOfString:@"\r\n\r\n"];
    //从\r\n\r\n之后的第一个位置开始截取字符串 响应体
    NSString *html=[response substringFromIndex:range.length+range.location];
    
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    //关闭连接,http协议要求，请求结束后要关闭连接
    close(self.clientSocket);
    
    NSLog(@"-----%@",response);
}

//链接服务器
-(BOOL)connect:(NSString *)ip port:(int)port{
    //1.创建socket
    //第一个参数 domain 协议簇 指定IPv4
    //第二个参数 type socket的类型 流socket、数据包socket
    //第三个参数 protocol 协议
    //返回值 如果创建成功返回的是socket的描述符，失败为-1
    self.clientSocket=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    //2.连接服务器
    //第一个参数：socket描述符
    //第二个参数：结构体 ip地址和端口
    //第三个参数：结构体的长度 sizeof
    //返回值 成功0 失败非0
    struct sockaddr_in addr;
    addr.sin_family=AF_INET;//使用什么类型的地址，4还是6
    addr.sin_addr.s_addr=inet_addr(ip.UTF8String);//将oc字符串转成c语言的字符串
    addr.sin_port=htons(port);//计算机存的数据顺序可能不一样，所以需要一个转换，转换成大尾顺序
    int result=connect(self.clientSocket, (const struct sockaddr *)&addr, sizeof(addr));//需要转一下，这是c语言的知识
    //    if (result==0) {
    //        NSLog(@"成功");//使用gNetcat的命令 nc -lk 12345创建服务器
    //        //顺便说一下，这里使用了MacPorts软件，他是一个安装其他软件的软件很方便，你只需要搜索有没有这个软件，然后你就可以安装，
    //    }else{
    //        NSLog(@"失败");
    //    }
    if(result!=0){//这样写法相比于上面的，他的好处是可以减少大括号的嵌套
        NSLog(@"失败");
        return false;
    }
    return true;
}

//发送和接受数据
-(NSString *)sendAndRecv:(NSString *)sendMsg{
    //3.向服务器发送数据
    //第一个参数指定发送端socket描述符
    //第二个参数是要传的数据，
    //第三个参数是要发送的数据的字节个数
    //第四个参数一般置0，即阻塞或者不阻塞
    //返回值 成功则返回实际传送出去的字符数，失败返回-1 ，
    const char *msg=sendMsg.UTF8String;//将oc字符串转成c语言的字符串
    ssize_t sendcount=send(self.clientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数 %zd",sendcount);
    
    //4.接受服务器返回的数据
    //返回的是实际接受的字节个数
    //第二参数是接受的字符数组（不准确）
    //第三个参数是接受的字符数组个数（不准确）
    //第四个参数一般置0 即阻塞或者不阻塞
    uint8_t buffer[1024];
    
    NSMutableData *mData=[NSMutableData data];
    
    ssize_t recvcount=recv(self.clientSocket, buffer, sizeof(buffer), 0);;
    
    [mData appendBytes:buffer length:recvcount];
    
    //服务器会返回多次数据，等所有的数据都接收完成，再转换成字符串
    while (recvcount!=0) {
        recvcount=recv(self.clientSocket, buffer, sizeof(buffer), 0);
        [mData appendBytes:buffer length:recvcount];
        NSLog(@"接受的字节数 %zd",recvcount);
    }
    
    //把字节数组转换成字符串
//    NSData *data=[NSData dataWithBytes:buffer length:recvcount];
    NSString *recvMsg=[[NSString alloc] initWithData:mData.copy encoding:NSUTF8StringEncoding];
    NSLog(@"收到：%@",recvMsg);
    return recvMsg;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
