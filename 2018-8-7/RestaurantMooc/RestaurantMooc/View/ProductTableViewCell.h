//
//  ProductTableViewCell.h
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDatasource.h"

@interface ProductTableViewCell : UITableViewCell
+(instancetype)createCellWithTableView:(UITableView*)tableView;
-(void)loadData:(ProductDatasource*)product;

@end
