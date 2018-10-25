//
//  UIImageView+Cache.h
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKImageManager.h"

@interface UIImageView (Cache)

-(void)mk_setImageWithUrl:(NSString *)url placeHolder:(UIImage*)holder complete:(void(^)(UIImage *image,BOOL cache))complete;

-(void)mk_setImageWithUrl:(NSString *)url placeHolder:(UIImage*)holder
                  options:(MKLoadOptions)options complete:(void(^)(UIImage *image,BOOL cache))complete;
@end
