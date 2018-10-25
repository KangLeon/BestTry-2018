//
//  Status+CoreDataProperties.h
//  CoreData1
//
//  Created by jitengjiao      on 2018/3/24.
//  Copyright © 2018年 MJ. All rights reserved.
//
//

#import "Status+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Status (CoreDataProperties)

+ (NSFetchRequest<Status *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSDate *time;

@end

NS_ASSUME_NONNULL_END
