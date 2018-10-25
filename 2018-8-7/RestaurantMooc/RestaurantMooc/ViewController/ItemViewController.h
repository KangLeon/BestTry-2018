//
//  ItemViewController.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDatasource.h"

@interface ItemViewController : BaseViewController
@property(nonatomic,strong)ProductDatasource *itemDataSource;
@end
