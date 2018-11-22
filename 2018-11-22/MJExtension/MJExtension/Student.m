//
//  Student.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Student.h"
#import <MJExtension.h>

@implementation Student
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"desc" : @"desciption",
             @"oldName" : @"name.oldName",
             @"nowName" : @"name.newName",
             @"nameChangedTime" : @"name.info.nameChangedTime",
             @"bag" : @"other.bag"
             };
}

@end
