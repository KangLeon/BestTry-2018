//
//  MKImageCache.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MKImageCache.h"
#import <objc/runtime.h>

static char *memCacheKey;

@implementation MKImageCache

//保存图片到本地
+(void)saveImageToDisk:(UIImage *)image forKey:(NSString *)key{
    NSString *filePath=[[[self class] imageCacheDirectory] stringByAppendingString:key];
    NSData *data=UIImageJPEGRepresentation(image, 1);
    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"保存图片失败");
    }
}
//从本地读取图片
+(UIImage *)diskImageForKey:(NSString *)key{
    NSString *filePath=[[[self class] imageCacheDirectory] stringByAppendingPathComponent:key];
    NSData *data=[[NSData alloc] initWithContentsOfFile:filePath];
    if (!data) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    return image;
}

+(NSString *)imageCacheDirectory{
    NSString *path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"MKImageDefault"];
    BOOL dir=YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+(NSMutableArray *)memCache{
    NSMutableArray *images=objc_getAssociatedObject(self, &memCacheKey);
    if (!images) {
        images=[NSMutableArray array];
        objc_setAssociatedObject(self, &memCacheKey, images, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return images;
}

//保存图片到内存
+(void)saveImageToMemory:(UIImage*)image forKey:(NSString*)key{
    NSMutableArray *images=[self memCache];
    [images addObject:@{@"key":key,@"image":image}];
    if (images.count>10) {
        [images removeObjectAtIndex:0];
    }
}
//从内存中读取图片
+(UIImage *)memoryImageForKey:(NSString *)key{
    NSMutableArray *images=[self memCache];
    __block UIImage *img=nil;
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict=obj;
        if ([dict[@"key"] isEqualToString:key]) {
            img=dict[@"image"];
            *stop=YES;
        }
    }];
    return img;
}

@end
