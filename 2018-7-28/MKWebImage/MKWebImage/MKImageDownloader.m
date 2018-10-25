//
//  MKImageDownloader.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MKImageDownloader.h"

@implementation MKImageDownloader


-(instancetype)initWithUrl:(NSString *)url complete:(void(^)(UIImage *image,NSError *error,MKImageDownloader *loader))complete{
    if (self=[super init]) {
        if (url&&[url isKindOfClass:[NSString class]]) {
            NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            __weak typeof(self) weakself=self;
            NSURLSessionTask *task=[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                //回调
                NSLog(@"图片下载完成");
                if (error) {
                    NSLog(@"图片加载失败 %@",error);
                    if (complete) {
                        complete(nil,error,weakself);
                    }
                    return ;
                }
                
                //需要回到主线程中来实现下面的内容
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSError *err=nil;
                    NSData *data=[NSData dataWithContentsOfURL:location options:NSDataReadingMappedAlways error:&err];
                    if (!data || err) {
                        NSLog(@"图片转换失败 %@",err);
                        if (complete) {
                            complete(nil,error,weakself);
                        }
                        return;
                    }
                    
                    UIImage *image=[[UIImage alloc] initWithData:data];
                    if (image&&complete) {
                        complete(image,nil,weakself);
                    }
                });
            }];
            self.task=task;
        }
    }
    return self;
}

@end
