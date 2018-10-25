//
//  ViewController.m
//  JsonForReal
//
//  Created by jitengjiao      on 2018/3/12.
//  Copyright © 2018年 MJ. All rights reserved.
//

//该实例是为了练习NSURLConnection的,已经被废弃，也不是练习Json的，

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(strong,nonatomic)NSMutableData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //不知道是什么原因，命名是正确的地址，但是无法获取返回的数据，但是在Safari上正常的，
//    NSString *urlString=@"http://qzone-music.qq.com/fcg-bin/cgi_playlist_xml.fcg?uin=397879704&json=1&g_tk=1916754934";
    NSString *urlString=@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];
}

//错误处理协议
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error!=nil) {
        NSLog(@"%@",error);
    }
}

//获取数据协议
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
    NSLog(@"返回数据%@",self.data);
}

//服务器响应协议
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *res=(NSHTTPURLResponse*)response;
    NSLog(@"服务器响应吗：%@",res);
}

//加载数据协议
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *dataString=[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"返回结果：%@",dataString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
