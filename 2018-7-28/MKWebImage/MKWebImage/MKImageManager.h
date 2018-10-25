//
//  MKImageManager.h
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKImageDownloader.h"

typedef NS_ENUM(NSInteger,MKLoadOptions) {
    MKLoadDefaultOption=1<<0,
    MKLoadIgnoreMemoryOption=1<<1,
    MKLoadIgnoreDiskOption=1<<2
};


@class  MKImageDownloader;

@interface MKImageManager : NSObject
+(MKImageManager *)shareInstance;
-(MKImageDownloader*)downloadWithUrl:(NSString*)url options:(MKLoadOptions)options complete:(void(^)(UIImage *image,BOOL cache,NSError *error))complete;
-(void)removeLoader:(MKImageDownloader*)loader;
@end
