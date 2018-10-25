//
//  SQLManager.m
//  Sqlite
//
//  Created by jitengjiao      on 2018/3/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "SQLManager.h"
#define kNamePath @"my.db"

@implementation SQLManager

static SQLManager *manager=nil;

+(SQLManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[SQLManager alloc] init];
    });
    return manager;
}

-(NSString *)applicationDocumentsDirectoyFile{
    NSString *paths=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath=[paths stringByAppendingPathComponent:kNamePath];
    return filePath;
}



@end
