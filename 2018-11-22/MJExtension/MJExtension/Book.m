//
//  Book.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Book.h"
#import "MJExtension.h"

@implementation Book
/* 转化过程中对字典的值进行过滤和进一步转化 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) {
            return @"";
        }
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}
@end

