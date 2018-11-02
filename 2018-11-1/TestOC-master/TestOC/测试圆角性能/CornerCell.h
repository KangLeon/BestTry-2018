//
//  CornerCell.h
//  TestOC
//
//  Created by 李亚军 on 2017/3/4.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CornerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *img2;


-(void)fill;


@end
