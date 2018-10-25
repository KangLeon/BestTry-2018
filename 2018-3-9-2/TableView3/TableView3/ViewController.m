//
//  ViewController.m
//  TableView3
//
//  Created by jitengjiao      on 2018/3/9.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "NameAndCompanyCell.h"

static NSString *cell_id=@"my_cell";

@interface ViewController ()<UITableViewDataSource,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;

@property(copy,nonatomic)NSArray *nameArray;
@property(copy,nonatomic)NSArray *companyArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nameArray=[NSArray arrayWithObjects:@"微信",@"支付宝",@"淘宝",@"阿里巴巴", nil];
    self.companyArray=[NSArray arrayWithObjects:@"社交类App",@"支付类App",@"网络购物类App",@"大型网络公司", nil];
    
    UINib *nib=[UINib nibWithNibName:@"NameAndCompanyCell" bundle:[NSBundle mainBundle]];
    [self.myTabelView registerNib:nib forCellReuseIdentifier:cell_id];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NameAndCompanyCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    cell.nameLabel.text=[self.nameArray objectAtIndex:indexPath.row];
    cell.companyLabel.text=[self.companyArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
