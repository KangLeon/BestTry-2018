//
//  Person.m
//  RacMVVM
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, readwrite,strong) NSString *salutation;
@property (nonatomic, readwrite,strong) NSString *firstName;
@property (nonatomic, readwrite,strong) NSString *lastName;
@property (nonatomic, readwrite,strong) NSDate *birthdate;

@end

@implementation Person

-(instancetype)initwithSalutation:(NSString *)salutation firstName:(NSString *)firstName lastName:(NSString *)lastName birthdate:(NSDate *)birthdate{
    if (self==[super init]) {
        self.salutation=salutation;
        self.firstName=firstName;
        self.lastName=lastName;
        self.birthdate=birthdate;
    }
    return self;
}

@end
