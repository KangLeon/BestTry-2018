//
//  CustomCell.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/29.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "CustomCell.h"
@interface CustomCell ()
@property(nonatomic,strong) UIImageView *igv;
@property(nonatomic,strong) UILabel *lbTitle;
@property(nonatomic,strong) UILabel *lbSummary;
@end

@implementation CustomCell


-(UIImageView *)igv{
    if (!_igv) {
        _igv=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 120, 68)];
        _igv.contentMode=UIViewContentModeScaleAspectFill;
        _igv.clipsToBounds=YES;
        [self.contentView addSubview:_igv];
    }
    return _igv;
}

-(UILabel*)lbTitle{
    if (!_lbTitle) {
        _lbTitle=[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
