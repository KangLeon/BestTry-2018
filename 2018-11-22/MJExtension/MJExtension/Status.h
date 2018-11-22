//
//  Status.h
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;
@class Status;
//Status模型
@interface Status : NSObject

@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;/* 其他模型类型 */
@property (strong, nonatomic) Status *retweetedStatus;/* 自我模型类型 */

@end

NS_ASSUME_NONNULL_END
