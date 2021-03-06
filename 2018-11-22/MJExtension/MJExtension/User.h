//
//  User.h
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface User : Base

@property (copy, nonatomic) NSString *name;/* 姓名 */
@property (copy, nonatomic) NSString *icon;/* 头像 */
@property (assign, nonatomic) unsigned int age;/* 年龄 */
@property (copy, nonatomic) NSString *height;/* 身高 */
@property (strong, nonatomic) NSNumber *money;/* 资产 */
@property (assign, nonatomic) Sex sex;/* 性别 */
@property (assign, nonatomic, getter=isGay) BOOL gay;/* 是否是同性恋 */

@end

NS_ASSUME_NONNULL_END
