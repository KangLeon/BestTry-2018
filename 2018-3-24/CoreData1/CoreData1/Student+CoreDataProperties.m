//
//  Student+CoreDataProperties.m
//  CoreData1
//
//  Created by jitengjiao      on 2018/3/23.
//  Copyright © 2018年 MJ. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic height;

@end
