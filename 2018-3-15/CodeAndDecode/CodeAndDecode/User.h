//
//  User.h
//  CodeAndDecode
//
//  Created by jitengjiao      on 2018/3/15.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
@property(strong,nonatomic)NSString *name;
@property(assign,nonatomic)NSInteger age;
@property(strong,nonatomic)NSString *sex;
@end
