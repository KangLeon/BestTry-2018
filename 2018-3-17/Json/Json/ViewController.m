//
//  ViewController.m
//  Json
//
//  Created by jitengjiao      on 2018/3/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *autorLabel;
@property (weak, nonatomic) IBOutlet UILabel *cateLabel;
@property (weak, nonatomic) IBOutlet UILabel *attrLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getData4];

}

-(void)getData4{
    //使用的sendSynchronousRequest方法
    NSString *path=@"http://api.douban.com/book/subjects?q=IOS&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1";
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSData *jsonData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    id jsonObj=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@",jsonObj);
    }
}

-(void)getData3{
    //使用的stringWithContentsOfURL方法
    NSString *path=@"http://api.douban.com/book/subjects?q=IOS&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1";
    NSURL *url=[NSURL URLWithString:path];
    NSString *jsonStr=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObj=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@",jsonObj);
    }
}

-(void)getData2{
    //使用的dataWithContentsOfURL方法
    NSString *path=@"http://api.douban.com/book/subjects?q=IOS&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1";
    NSURL *url=[NSURL URLWithString:path];
    NSData *data=[NSData dataWithContentsOfURL:url];
    id jsonObj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@",jsonObj);
    }
}

-(void)getData{
    NSString *path=@"http://api.douban.com/book/subjects?q=IOS&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1";
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=(NSDictionary *)responseObject;
            [self praseData:dic];
            //            NSLog(@"%@",dic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error!=nil) {
            NSLog(@"%@",error);
        }
    }];
}

-(void)praseData:(NSDictionary *)dic{
    NSArray *entry_arr=[dic objectForKey:@"entry"];
//    self.autorLabel.text=[[entry_arr objectAtIndex:0] objectForKey:@"author"];
    
    NSDictionary *bookDic=[entry_arr objectAtIndex:0];
    
    NSArray *author_arr=[bookDic objectForKey:@"author"];
    
    NSDictionary *name_dic=[author_arr objectAtIndex:0];
    NSDictionary *real_name_dic=[name_dic objectForKey:@"name"];
    
    self.autorLabel.text=[real_name_dic objectForKey:@"$t"];
    
    NSLog(@"%@",real_name_dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
