//
//  SharedMarcro.h
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#ifndef SharedMarcro_h
#define SharedMarcro_h

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
#define IS_IOS10_OR_ABOVE SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")

#endif /* SharedMarcro_h */
