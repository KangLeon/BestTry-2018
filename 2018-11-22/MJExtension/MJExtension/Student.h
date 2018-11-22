//
//  Student.h
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Bag;

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) Bag *bag;
@end

NS_ASSUME_NONNULL_END
