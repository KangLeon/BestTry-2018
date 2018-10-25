//
//  ProductTableViewCell.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Util.h"

@interface ProductTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;
@property (weak, nonatomic) IBOutlet UILabel *subTitle3;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@end

@implementation ProductTableViewCell

+(instancetype)createCellWithTableView:(UITableView*)tableView{
    static NSString *ID=@"www.imoox.com.tb.cell";
    ProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
-(void)loadData:(ProductDatasource*)product{
    NSData *imageData=product.imageData;
    NSString *title=product.title;
    NSString *subTitle1=product.subTitle1;
    NSString *subTitle2=product.subTitle2;
    NSString *subTitle3=product.subTitle3;
    NSString *saledNum=product.saledNum;
    
    self.imageView.image=[UIImage imageWithData:imageData];
    self.title.text=title;
    self.subTitle1.text=subTitle1;
    self.subTitle2.text=subTitle2;
    self.subTitle3.text=subTitle3;
    
    self.subTitle1.textColor=[UIColor grayColor];
    self.subTitle1.font=[UIFont systemFontOfSize:10.0];
    
    self.subTitle2.textColor=MYCOLORYELLOW;
    
    self.subTitle3.textColor=[UIColor orangeColor];
    self.subTitle3.font=[UIFont systemFontOfSize:12.0];
    
    self.saleNum.text=saledNum;
    self.saleNum.textColor=[UIColor grayColor];
    self.saleNum.font=[UIFont systemFontOfSize:12.0];
    self.saleNum.textAlignment=NSTextAlignmentRight;
    
    if (product.flag) {
        self.addImageView.image=[UIImage imageNamed:@"add.png"];
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
