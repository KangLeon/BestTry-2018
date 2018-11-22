//
//  Bag.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Bag.h"
#import <MJExtension.h>

@implementation Bag
//添加了下面的宏定义
//MJExtensionCodingImplementation

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{ 
    [self mj_encode:encoder];
}

/* 实现下面的方法，说明哪些属性不需要归档和解档 */
+ (NSArray *)mj_ignoredCodingPropertyNames{
    return @[@"name"];
}

@end
