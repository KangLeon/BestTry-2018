//
//  NameAndCompanyCell.m
//  TableView2
//
//  Created by jitengjiao      on 2018/3/9.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "NameAndCompanyCell.h"
@interface NameAndCompanyCell ()



@end
@implementation NameAndCompanyCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UILabel *nameMarker=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 70, 15)];
        nameMarker.textAlignment=NSTextAlignmentRight;
        nameMarker.text=@"name";
        nameMarker.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameMarker];

        UILabel *companyMarker=[[UILabel alloc] initWithFrame:CGRectMake(0, 26, 70, 15)];
        companyMarker.textAlignment=NSTextAlignmentRight;
        companyMarker.text=@"company";
        companyMarker.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:companyMarker];

        self.nameLable=[[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 15)];
        self.nameLable.font=[UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.nameLable];

        self.companyLable=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, 200, 15)];
        self.companyLable.font=[UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.companyLable];
    }
    return self;

}

//会出错，不知道为甚么
//-(void)setName:(NSString *)n{
//    if (![n isEqualToString:self.name]) {
//        self.name=[n copy];
//        self.nameLable.text=self.name;
//    }
//}

//-(void)setCompany:(NSString *)c{
//    if (![c isEqualToString:self.company]) {
//        self.company=[c copy];
//        self.companyLable.text=self.company;
//    }
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
