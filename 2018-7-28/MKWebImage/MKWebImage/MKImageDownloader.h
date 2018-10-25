//
//  MKImageDownloader.h
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKImageDownloader : NSObject

@property(nonatomic,strong)NSURLSessionTask *task;

-(instancetype)initWithUrl:(NSString *)url complete:(void(^)(UIImage *image,NSError *error,MKImageDownloader *loader))complete;
@end
