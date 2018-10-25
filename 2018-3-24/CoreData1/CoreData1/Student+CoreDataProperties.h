//
//  Student+CoreDataProperties.h
//  CoreData1
//
//  Created by jitengjiao      on 2018/3/23.
//  Copyright © 2018年 MJ. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *age;
@property (nonatomic) float height;

@end

NS_ASSUME_NONNULL_END
