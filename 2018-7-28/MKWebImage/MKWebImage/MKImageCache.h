//
//  MKImageCache.h
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKImageCache : NSObject

//保存图片到本地
+(void)saveImageToDisk:(UIImage *)image forKey:(NSString *)key;
//从本地读取图片
+(UIImage *)diskImageForKey:(NSString *)key;

//保存图片到内存
+(void)saveImageToMemory:(UIImage*)image forKey:(NSString*)key;
//从内存中读取图片
+(UIImage *)memoryImageForKey:(NSString *)key;

@end
