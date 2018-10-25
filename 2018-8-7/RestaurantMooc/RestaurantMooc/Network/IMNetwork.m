//
//  IMNetwork.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "IMNetwork.h"
#import <CommonCrypto/CommonDigest.h>
#import "DataSource.h"

@implementation IMNetwork
//获得商品信息的请求 food fruit
-(void)getProductInfo:(NSString *)urlString{
    NSString *urlStr=urlString;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
        int flag=-1;
        if ([request.URL.absoluteString containsString:@"food"]) {
            flag=1;
        }else if ([request.URL.absoluteString containsString:@"fruit"]){
            flag=2;
        }
        if (data&&httpResponse.statusCode==200) {
            [self parseData:data type:flag];
        }
    }];
    [task resume];
}
//登录功能的请求
-(void)login:(NSString*)urlString userName:(NSString *)userName password:(NSString*)password{
    NSString *urlStr=urlString;
    NSString *md5Str1=[self md5:@"imooc"];
    //md5(time+md5(key))=token
    NSString *md5Str2=[self md5:[NSString stringWithFormat:@"%@%@",@"20180808",md5Str1]];
    NSString *fullUrl=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",urlStr,@"?",@"username=",userName,@"&",@"password=",password,@"&",@"time=20180808&token=",md5Str2];
    NSURL *url=[NSURL URLWithString:fullUrl];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    
    //login
    [[DataSource getInstance] setLoginFlag:false];
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
        if (data&&httpResponse.statusCode==200) {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"%@",dic.allValues);
            if ([dic.allValues containsObject:@"login success"]) {
                //login success
                [[DataSource getInstance] setLoginFlag:true];
            }
        }
    }];
    [task resume];
}

//解析数据，同时将商品的url封装成字典返回出来
-(void)parseData:(NSData*)data type:(int)type{
    NSString *jsonStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    NSError *error=nil;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"%@",dic);
    for (NSString *key in dic.allKeys) {
        if ([key isEqualToString:@"code"]) {
            NSString *code=[dic valueForKey:@"code"];
        }else if ([key isEqualToString:@"url"]){
            NSArray *pd_url=[dic valueForKey:key];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
            [dic setValue:pd_url forKey:@"url"];
            if (type==1) {
                //notifi
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadimagefood" object:nil userInfo:dic];
            }else if (type==2){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadimagefruit" object:nil userInfo:dic];
            }
        }else if ([key isEqualToString:@"id"]){
            NSString *pd_id=[dic valueForKey:@"id"];
        }
    }
}

-(NSString *)md5:(NSString*)input{
    const char *cStr=[input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);;
    
    NSMutableString *output=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    //32位长度数据
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}

@end
