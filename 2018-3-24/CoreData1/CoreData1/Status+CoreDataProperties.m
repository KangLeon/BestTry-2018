//
//  Status+CoreDataProperties.m
//  CoreData1
//
//  Created by jitengjiao      on 2018/3/24.
//  Copyright © 2018年 MJ. All rights reserved.
//
//

#import "Status+CoreDataProperties.h"

@implementation Status (CoreDataProperties)

+ (NSFetchRequest<Status *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Status"];
}

@dynamic text;
@dynamic time;

@end
