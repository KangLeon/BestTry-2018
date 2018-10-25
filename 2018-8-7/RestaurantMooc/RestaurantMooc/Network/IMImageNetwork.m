//
//  IMImageNetwork.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "IMImageNetwork.h"
#import "DataSource.h"
#import "ProductDatasource.h"

@implementation IMImageNetwork
+(instancetype)getInstance{
    static IMImageNetwork *imimageNetwotk=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imimageNetwotk=[[IMImageNetwork alloc] init];
    });
    return imimageNetwotk;
}

//通过url发送获取单张图片的请求
-(void)laodImageData:(NSString*)urlString{
    NSString *urlStr=urlString;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
        if (data &&httpResponse.statusCode==200) {
            if ([request.URL.absoluteString containsString:@"food"]) {//判断URL字符串里面是否包含
                //如果请求url字符串里包含food
                [self parseImageDataFood:data];
            }else{
                //如果请求url字符串里包含fruit
                [self parseImageDataFruit:data];
            }
        }
    }];
    [task resume];

}

//解析Food的图片
-(void)parseImageDataFood:(NSData*)data{
    [[DataSource getInstance] setPDNum:[[DataSource getInstance] getPDNum]+1];//设置商品数目
    ProductDatasource *dataSource=[[ProductDatasource alloc] init];
    dataSource.imageData=data;
    [[DataSource getInstance] loadPDItem:dataSource];//对dataSource进行保存
    
    //如果超过8个商品就发送一个通知
    if ([[DataSource getInstance] getPDNum]==8) {
        [[DataSource getInstance] setPDNum:0];//将数目归零
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imoocloadfood" object:nil userInfo:nil];//超过8个商品就发送一个通知
        
    }
}

//解析水果的图片
-(void)parseImageDataFruit:(NSData*)data{
    [[DataSource getInstance] setFruitNum:[[DataSource getInstance] getFruitNum]+1];
    ProductDatasource *dataSource=[[ProductDatasource alloc] init];
    dataSource.imageData=data;
    [[DataSource getInstance] loadFruitItem:dataSource];//对dataSource进行保存
    
    //如果超过8个商品就发送一个通知
    if ([[DataSource getInstance] getFruitNum]==8) {
        [[DataSource getInstance] setFruitNum:0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imoocloadfruit" object:nil userInfo:nil];
        
    }
}

@end
