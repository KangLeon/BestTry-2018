//
//  ProductTableViewCell.m
//  团购
//
//  Created by jitengjiao      on 2018/2/23.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Util.h"

@interface ProductTableViewCell (){
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;


@end

@implementation ProductTableViewCell
@synthesize imageView=_imageView;

+(instancetype)createCellWithTableview:(UITableView *)tableView{
    static NSString *cell_ID=@"product_cell";
    ProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)loadData:(ProductDataSource *)product{
    NSString *imagePath=product.image;
    NSString *title=product.title;
    NSString *subTitle=product.subtitle;
    NSString *money=product.money;
    NSString *discount=product.discount;
    NSString *sale=product.sale;
    
    self.imageView.image=[UIImage imageNamed:imagePath];
    self.titleLabel.text=title;
    
    self.subTitleLabel.text=subTitle;
    self.subTitleLabel.textColor=[UIColor grayColor];
    self.subTitleLabel.font=[UIFont systemFontOfSize:10.0];
    
    self.moneyLabel.text=money;
    self.moneyLabel.textColor=MYGREENCOLOR;
    
    self.discountLabel.text=discount;
    self.discountLabel.textColor=[UIColor orangeColor];
    self.discountLabel.font=[UIFont systemFontOfSize:12.0];
    
    self.saleLabel.text=sale;
    self.saleLabel.textColor=[UIColor grayColor];
    self.saleLabel.font=[UIFont systemFontOfSize:12.0];
    self.saleLabel.textAlignment=NSTextAlignmentRight;
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
