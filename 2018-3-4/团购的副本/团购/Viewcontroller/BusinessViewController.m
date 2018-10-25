//
//  BusinessViewController.m
//  团购
//
//  Created by jitengjiao      on 2018/2/20.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "BusinessViewController.h"
#import "Util.h"
#import "MyDataSourse.h"
#import "ProductDataSource.h"
#import "ProductTableViewCell.h"

@interface BusinessViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *productArray;
    UIView *view_class;
    UITableView *tableView_product;
}

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"商家";//设置导航栏上标题的文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19.0],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];//设置标题文字的属性
    
    //滚动选择View
    view_class=[[UIView alloc] initWithFrame:CGRectMake(-1, 64, SCREEN_WIDTH+2, 50)];
    view_class.layer.borderColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;//因为是在layer图形下的，所以是CGColor
    view_class.layer.borderWidth=1.0;
    [self.view addSubview:view_class];
    
    productArray=[[NSMutableArray alloc] init];
    productArray=[MyDataSourse sharedMyDataSource].homeProductDataArray;//将保存的数据引入进来
    
    NSArray *array_bttitle=@[@"本地商家",@"外地商家",@"默认排序"];
    for (int i=0; i<3; i++) {
        UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(1+i*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 50)];
        NSString *title=[array_bttitle objectAtIndex:i];
        [bt setTitle:title forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=10000+i;
        [view_class addSubview:bt];
        if (i==0) {
            [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
    
    //添加UITableView
    tableView_product=[[UITableView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114-44)];
    tableView_product.dataSource=self;
    tableView_product.delegate=self;
    [self.view addSubview:tableView_product];
    
    
}

#pragma mark -TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return productArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDataSource *product=[productArray objectAtIndex:indexPath.row];
    ProductTableViewCell *cell=[ProductTableViewCell createCellWithTableview:tableView];
    [cell loadData:product];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.6;
}

-(void)btAction:(UIButton *)bt{
    for (UIView *item in view_class.subviews) {
        if (item.tag==bt.tag) {
            [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else if (item.tag==10000 || item.tag==10001 || item.tag==10002){
            [(UIButton*)item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
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
