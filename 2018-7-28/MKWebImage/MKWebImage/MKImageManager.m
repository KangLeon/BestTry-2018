//
//  MKImageManager.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MKImageManager.h"
#import "MKImageDownloader.h"
#import "MKImageCache.h"
#import <CommonCrypto/CommonCrypto.h>

@interface MKImageManager ()
//下载队列 存储当前正在执行下载操作的downloader
@property(nonatomic,strong)NSMutableArray *loaderQueue;

//准备队列 存储超过下载上限后的downLoader，随时准备加入到下载队列下载图片
@property(nonatomic,strong)NSMutableArray *loaderPreviousQueue;

//最大同时请求数
@property int maxImageDownLoadCount;
@end

@implementation MKImageManager

+(MKImageManager *)shareInstance{
    static MKImageManager *mkImageManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkImageManager=[[[self class] alloc] init];
        mkImageManager.maxImageDownLoadCount=5;
    });
    return mkImageManager;
}

-(void)addDownloaderToQueue:(MKImageDownloader *)loader{
    //3.如果大于最大请求数，加入到准备队列中,如果小于，加入到加载队列中并开始下载图片
    if (self.loaderQueue.count>=self.maxImageDownLoadCount) {
        NSLog(@"超过最大请求数，先放入到准备队列中");
        [self.loaderPreviousQueue addObject:loader];
    }else{
        [self.loaderQueue addObject:loader];
        [loader.task resume];
    }
}

//4.下载完成后，从下载队列中移除
-(void)removeLoaderFromQueue:(MKImageDownloader*)loader{
    if (!loader) {
        return;
    }
    if ([self.loaderQueue containsObject:loader]) {
        [self.loaderQueue removeObject:loader];
        [loader.task cancel];
        loader=nil;
    }
}

-(void)checkPreviousQueue{
    if (self.loaderQueue.count<self.maxImageDownLoadCount&&self.loaderPreviousQueue.count>0) {
        MKImageDownloader *loader=[self.loaderPreviousQueue firstObject];
        [self.loaderPreviousQueue removeObject:loader];
        [self addDownloaderToQueue:loader];
    }
}

-(MKImageDownloader*)downloadWithUrl:(NSString*)url options:(MKLoadOptions)options complete:(void(^)(UIImage *image,BOOL cache,NSError *error))complete{
    
    if (!url) {
        NSLog(@"url 不能为空");
        return nil;
    }
    
    NSString *key=[self md5:url];
    
    UIImage *img=nil;
    if (!(options&MKLoadIgnoreMemoryOption)) {
        //需要从内存中读取数据
        img=[MKImageCache memoryImageForKey:key];
    }
    //从内存中读取image
    
    if (!img) {
        if (!(options&MKLoadIgnoreDiskOption)) {
            //需要从本地读取image
            NSLog(@"从本地缓存读取数据");
            img=[MKImageCache memoryImageForKey:key];
            if (img) {
                [MKImageCache saveImageToMemory:img forKey:key];
            }
        }
    }else{
        NSLog(@"从内存中读取数据");
    }
    
    if (img) {
        if (complete) {
            complete(img,YES,nil);
        }
        return nil;
    }

    __weak typeof(self) weakself=self;
    //1.创建loader
    MKImageDownloader *loader=[[MKImageDownloader alloc] initWithUrl:url complete:^(UIImage *image, NSError *error, MKImageDownloader *loader) {
        if (complete) {
            complete(image,NO,error);
        }
        
        //4.下载完成后，从下载队列中移除
        [weakself removeLoaderFromQueue:loader];
        
        //5.检查准备队列中是否有数据，有则将其放到下载队列中加载图片
        [weakself checkPreviousQueue];
        
        //将图片保存到本地缓存和内存缓存
        if (image) {
            [MKImageCache saveImageToDisk:image forKey:key];
            [MKImageCache saveImageToMemory:image forKey:key];
        }
        
    }];
    
    //2.把loader加入到请求队列中，开始加载图片
    [self addDownloaderToQueue:loader];
    
    return nil;
}

-(void)removeLoader:(MKImageDownloader*)loader{
    if (!loader) {
        return;
    }
    [self removeLoaderFromQueue:loader];
    [self removeLoaderFromPreviousQueue:loader];
}

-(void)removeLoaderFromPreviousQueue:(MKImageDownloader *)loader{
    if (!loader) {
        return;
    }
    if ([self.loaderPreviousQueue containsObject:loader]) {
        [self.loaderPreviousQueue removeObject:loader];
        loader=nil;
    }
}

-(NSMutableArray *)loaderQueue{
    if (!_loaderQueue) {
        _loaderQueue=[NSMutableArray array];
    }
    return _loaderQueue;
}

-(NSMutableArray *)loaderPreviousQueue{
    if (!_loaderPreviousQueue) {
        _loaderPreviousQueue=[NSMutableArray array];
    }
    return _loaderPreviousQueue;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
