//
//  User.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "User.h"

@implementation User

-(NSString *)description{
    NSString *string=[NSString stringWithFormat:@"MJ---%@----%@---%u---%@---%@---%u----%d",self.name,self.icon,self.age,self.height,self.money,self.sex,self.gay];
    return string;
}

@end
