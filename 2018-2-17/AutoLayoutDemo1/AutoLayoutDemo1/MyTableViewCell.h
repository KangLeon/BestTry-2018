//
//  MyTableViewCell.h
//  AutoLayoutDemo1
//
//  Created by jitengjiao      on 2018/2/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView* imageAvatar;
@property(nonatomic,strong)IBOutlet UILabel *labName;
@property(nonatomic,strong)IBOutlet UILabel *lbContent;

@end
