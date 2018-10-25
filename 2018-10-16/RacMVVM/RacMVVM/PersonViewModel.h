//
//  PersonViewModel.h
//  RacMVVM
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface PersonViewModel : NSObject

@property (nonatomic, readonly) Person *person;

@property (nonatomic, readonly) NSString *nameText;
@property (nonatomic, readonly) NSString *birthdateText;

- (instancetype)initWithPerson:(Person *)person;

@end
