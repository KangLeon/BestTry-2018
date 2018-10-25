//
//  VegetableManager.h
//  VegManagement
//
//  Created by jitengjiao      on 2018/2/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vegetable.h"


@interface VegetableManager : NSObject

+(instancetype)sharedInstance;
-(NSArray*)vegetables;
-(BOOL)addVegetable:(Vegetable*)vegetable;
-(BOOL)removeVegetableWithName:(NSString*)vegetableName;
-(BOOL)changePrice:(double)price forVegetableName:(NSString*)vegetableName;

@end
