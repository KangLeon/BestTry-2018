//
//  MyDataSourse.m
//  团购
//
//  Created by jitengjiao      on 2018/2/22.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "MyDataSourse.h"


@implementation MyDataSourse

+(instancetype)sharedMyDataSource{
    static MyDataSourse *myDataSource=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myDataSource=[[MyDataSourse alloc] init];
    });
    return myDataSource;
}
@end
