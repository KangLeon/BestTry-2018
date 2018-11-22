//
//  Bag.h
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Bag : NSObject<NSCoding>
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double price;
@end

NS_ASSUME_NONNULL_END
