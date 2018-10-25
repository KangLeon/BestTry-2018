//
//  UIImageView+Cache.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "MKImageManager.h"
#import <objc/runtime.h>

static char *ImageLoaderKey;
@implementation UIImageView (Cache)

-(void)mk_setImageWithUrl:(NSString *)url placeHolder:(UIImage*)holder complete:(void(^)(UIImage *image,BOOL cache))complete{
    [self mk_setImageWithUrl:url placeHolder:holder options:MKLoadDefaultOption complete:complete];
}

-(void)mk_setImageWithUrl:(NSString *)url placeHolder:(UIImage*)holder
                  options:(MKLoadOptions)options complete:(void(^)(UIImage *image,BOOL cache))complete{
    if (holder) {
        self.image=holder;
    }
    
    //cancel相关联的loder
    [self cancelImageLoadWithKey:@"currentLoadImage" removeFromQueue:YES];
    
    __weak typeof(self) weakSelf=self;
    MKImageDownloader *loader=[[MKImageManager shareInstance] downloadWithUrl:url options:options complete:^(UIImage *image, BOOL cache, NSError *error) {
        [weakSelf cancelImageLoadWithKey:@"currentLoadImage" removeFromQueue:NO];
        if (image) {
            weakSelf.image=image;
        }
        if (complete) {
            complete(image,cache);
        }
    }];
    
    if (loader) {
        [[self loadImage] setObject:loader forKey:@"currentLoadImage"];
    }
}

-(void)cancelImageLoadWithKey:(NSString *)key removeFromQueue:(BOOL)remove{
    MKImageDownloader *loader=[[self loadImage] objectForKey:key];
    if (loader) {
        if (remove) {
            [[MKImageManager shareInstance] removeLoader:loader];
        }
        [((NSMutableDictionary *)[self loadImage]) removeObjectForKey:key];
    }
}

-(NSMutableDictionary *)loadImage{
    NSMutableDictionary *loadDict=objc_getAssociatedObject(self, &ImageLoaderKey);
    if (!loadDict) {
        loadDict=[NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &ImageLoaderKey, loadDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loadDict;
}

@end
