//
//  StatusResult.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "StatusResult.h"
#import <MJExtension.h>

@implementation StatusResult
// 实现这个方法的目的：告诉MJExtension框架statuses和ads数组里面装的是什么模型
/*    + (NSDictionary *)objectClassInArray{
 return @{
 @"statuses" : [Status class],
 @"ads" : [Ad class]    };
 }
 + (Class)objectClassInArray:(NSString *)propertyName{
 if ([propertyName isEqualToString:@"statuses"]) {
 return [Status class];
 } else if ([propertyName isEqualToString:@"ads"]) {
 return [Ad class];    }
 return nil;}
 */
// 这个方法对比上面的2个方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"statuses" : @"Status",
             @"ads" : @"Ad"
             };
}

@end
