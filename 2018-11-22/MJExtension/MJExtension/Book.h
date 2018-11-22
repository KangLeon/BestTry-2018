//
//  Book.h
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book: NSObject
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *publishedTime;
@end

NS_ASSUME_NONNULL_END
