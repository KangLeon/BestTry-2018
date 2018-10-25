//
//  FindViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "FindViewController.h"
#import "Util.h"
#import "DataSource.h"
#import "ProductDatasource.h"
#import "ProductTableViewCell.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView_product;
    NSMutableArray *productArray;
}

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"浦东新区五星路106号";
    productArray=[[NSMutableArray alloc] init];
    productArray=[[DataSource getInstance] getFruitArray];
    
    NSArray *array_bttitle = @[@"时令水果",@"四季水果",@"夏季水果",@"秋季水果",@"冬季水果",@"春季水果",@"时令水果",@"四季水果",@"夏季水果",@"秋季水果",];
    
    for (int i=0; i<10; i++) {
        UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, i*66, 80, 66)];
        
        NSString *title=[array_bttitle objectAtIndex:i];
        [bt setTitle:title forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=10000+i;
        [self.view addSubview:bt];
        if (i==0) {
            [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
    tableView_product=[[UITableView alloc] initWithFrame:CGRectMake(80, 44, SCREEN_WIDTH-80, SCREEN_HEIGHT-44)];
    tableView_product.delegate=self;
    tableView_product.dataSource=self;
    [self.view addSubview:tableView_product];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return productArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDatasource *product=[productArray objectAtIndex:indexPath.row];
    ProductTableViewCell *cell=[ProductTableViewCell createCellWithTableView:tableView];
    [cell loadData:product];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDatasource *itemdataSource=[productArray objectAtIndex:indexPath.row];
    ProductDatasource *itemorder=[[ProductDatasource alloc] init];
    itemorder.imageData=itemdataSource.imageData;
    itemorder.title=itemdataSource.title;
    itemorder.subTitle1=itemdataSource.subTitle1;
    itemorder.subTitle2=itemdataSource.subTitle2;
    itemorder.subTitle3=itemdataSource.subTitle3;
    itemorder.saledNum=itemdataSource.saledNum;
    itemorder.flag=itemdataSource.flag;
    
    [[DataSource getInstance] loadOrderItem:itemorder];
    NSMutableArray *array=[[DataSource getInstance] getOrderArray];
    NSString *orderNum=[NSString stringWithFormat:@"%ld",array.count];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:orderNum forKey:@"orderNum"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imoocorder" object:nil userInfo:dic];
    [[DataSource getInstance] add:itemdataSource.title];
    [[DataSource getInstance] search];
}

-(void)btAction:(UIButton*)bt{
    for (UIView *item in self.view.subviews) {
        if (item.tag==bt.tag) {
            [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else if (item.tag<10100 && item.tag>9999){
            [(UIButton*)item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    if(bt.tag%2==0){
        productArray=[[DataSource getInstance] getFruitArray];
    }else{
        productArray=[[DataSource getInstance] getFoodArray];
    }
    [tableView_product reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
