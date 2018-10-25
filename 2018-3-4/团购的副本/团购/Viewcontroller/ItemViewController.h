//
//  ItemViewController.h
//  团购
//
//  Created by jitengjiao      on 2018/3/3.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDataSource.h"

@interface ItemViewController : BaseViewController
@property(nonatomic,strong)ProductDataSource *itemDataSource;

@end
