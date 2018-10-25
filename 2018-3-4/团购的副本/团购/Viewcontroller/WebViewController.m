//
//  WebViewController.m
//  团购
//
//  Created by jitengjiao      on 2018/3/4.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "WebViewController.h"
#import "Util.h"

@interface WebViewController (){
    UIWebView *webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIView *navigation=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navigation.backgroundColor=MYGREENCOLOR;
    [self.view addSubview:navigation];
    
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:backButton];
    
    //网页:第一种打开方法
//    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    [self.view addSubview:webView];
//    NSString *url=@"https://www.imooc.com";
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [webView loadRequest:request];
    
    //网页：第二种打开方法,这种方法直接打开一个Safari
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.imooc.com"] options:nil completionHandler:nil];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:true];
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
