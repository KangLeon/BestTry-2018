//
//  ProductTableViewCell.h
//  团购
//
//  Created by jitengjiao      on 2018/2/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDataSource.h"

@interface ProductTableViewCell : UITableViewCell
+(instancetype)createCellWithTableview:(UITableView *)tableView;
-(void)loadData:(ProductDataSource *)product;
@end
