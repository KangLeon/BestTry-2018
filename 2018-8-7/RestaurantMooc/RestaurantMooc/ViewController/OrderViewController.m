//
//  OrderViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "OrderViewController.h"
#import "Util.h"
#import "DataSource.h"
#import "ProductTableViewCell.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    UITableView *tableView_product;
    NSMutableArray *productArray;
}

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"购物车";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    productArray=[[DataSource getInstance] getOrderArray];
    if (productArray.count==0) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"message" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"继续", nil];
        [alertView show];
    }
    NSString *deviceName=@"iphone 8";
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH-99, SCREEN_WIDTH, 50)];
    if (SCREEN_HEIGHT==812) {
        footView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-134, SCREEN_WIDTH, 50)];
    }
    footView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:footView];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 50)];
    label1.text=@"合计";
    [footView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(60, 0, 80, 50)];
    label2.text=@"¥88.88";
    label2.font=[UIFont systemFontOfSize:20.0];
    [footView addSubview:label2];
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(140, 0, 80, 50)];
    label3.text=@"(全场包邮)";
    label3.textColor=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    label3.font=[UIFont systemFontOfSize:12.0];
    [footView addSubview:label3];
    
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 0, 120, 50)];
    [bt setTitle:@"结算" forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor orangeColor]];
    [footView addSubview:bt];
    
    tableView_product=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44-50)];
    if (SCREEN_HEIGHT==812) {
        tableView_product=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44-90)];
    }
    tableView_product.dataSource=self;
    tableView_product.delegate=self;
    [self.view addSubview:tableView_product];
}

-(void)viewWillAppear:(BOOL)animated{
    productArray=[[DataSource getInstance] getOrderArray];
    [tableView_product reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"returnfindvc" object:nil];
    }
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
