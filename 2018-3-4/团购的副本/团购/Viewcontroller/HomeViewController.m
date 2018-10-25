//
//  HomeViewController.m
//  团购
//
//  Created by jitengjiao      on 2018/2/20.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "HomeViewController.h"
#import "Util.h"
#import "CitySelectButton.h"
#import "LoginViewController.h"
#import "CitySelectViewController.h"
#import "MyDataSourse.h"
#import "ClassButton.h"
#import "ProductDataSource.h"
#import "ProductTableViewCell.h"
#import "ItemViewController.h"
#import "BusinessViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    LoginViewController *vc_login;
    CitySelectViewController *vc_citySelect;
    CitySelectButton *bt_selectCity;
    NSMutableArray *productArray;
    UITableView *tableView_product;
    ItemViewController *vc_item;
    BusinessViewController *vc_subClass;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self generateSimulateData];
    
    //1.登录按钮
    UIImage *image=[UIImage imageNamed:@"登录.png"];
    UIImage *newImage=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *bbi_login=[[UIBarButtonItem alloc] initWithImage:newImage style:UIBarButtonItemStyleDone target:self action:@selector(loginAction)];
//    self.navigationItem.leftBarButtonItem=bbi_login;
//    //2.第二个按钮(添加导航栏上的按钮可以有一下两种方式)
//    //2.1通过坐标（下面的方法就是使用的这种方法）
//    //2.2 通过navigationItem来实现
//    UIButton *bt_qrcode=[[UIButton alloc] initWithFrame:CGRectMake(50, 2, 40, 40)];
//    [bt_qrcode setImage:[UIImage imageNamed:@"二维码.png"] forState:UIControlStateNormal];
//    [bt_qrcode addTarget:self action:@selector(qrcodeAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:bt_qrcode];
    UIImage *qr_image=[UIImage imageNamed:@"二维码.png"];
    UIImage *qr_newImage=[qr_image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *bbi_qr_button=[[UIBarButtonItem alloc] initWithImage:qr_newImage style:UIBarButtonItemStyleDone target:self action:@selector(qrcodeAction)];
    NSArray *itemsArray=[[NSArray alloc] initWithObjects:bbi_login,bbi_qr_button, nil];
    self.navigationItem.leftBarButtonItems=itemsArray;
    
    //3.搜索
    UITextField *tf_search=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-130-100, 25)];
    tf_search.backgroundColor=[UIColor whiteColor];
    tf_search.borderStyle=UITextBorderStyleNone;
    tf_search.layer.borderColor=[UIColor whiteColor].CGColor;
    tf_search.layer.cornerRadius=12.5;
    //3.1放大镜的图标的添加有以下的四种方法：（后面三种的方法比较好，自定义比较复杂）
    //a.首先是tf_search.leftView=imageView;但是这种方法的后果是放大镜回紧紧的贴着UITextField的左边，不好看
    //b.第二种方法是通过把图标通过美工留白
    //c.第三种方法是自定义TextField
    //d.第四种方法是把UIImagview添加到UIView上，UIView最左边留空白，再把UIView添加到leftView上就可以了
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"查找.png"]];
    [view addSubview:imageView];
    
    tf_search .leftView=view;
    tf_search.leftViewMode=UITextFieldViewModeAlways;
    tf_search.delegate=self;
    self.navigationItem.titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100-100, 25)];
    self.navigationItem.titleView.backgroundColor=[UIColor clearColor];
    
    [self.navigationItem.titleView addSubview:tf_search];
    
    //城市选择button
    bt_selectCity=[[CitySelectButton alloc] initWithFrame:CGRectMake(30, 0, 65, 44)];//这里的宽高是不起作用的
    [bt_selectCity addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    [bt_selectCity setTitle:@"上海" forState:UIControlStateNormal];
    bt_selectCity.titleLabel.adjustsFontSizeToFitWidth=YES;
//    bt_selectCity.titleLabel.textAlignment=NSTextAlignmentRight;
    [bt_selectCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt_selectCity setImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
    UIBarButtonItem *bbi_selectCity=[[UIBarButtonItem alloc] initWithCustomView:bt_selectCity];
    self.navigationItem.rightBarButtonItem=bbi_selectCity;
    
    //首页机票、车票等8个按钮----->这里有问题，自定义的button上面的图片无法显示，
    NSArray *className=@[@"机票",@"火车票",@"汽车",@"蛋糕",@"美食佳饮",@"手表",@"电脑",@"手机"];
    for (int i=0; i<8; i++) {
        CGRect btRect;
        CGRect imageRect;
        CGRect titleRect;
        if (i<4) {
            btRect=CGRectMake(i*SCREEN_WIDTH/4, 64, SCREEN_WIDTH/4, 50);
        }else{
            btRect=CGRectMake((i-4)*SCREEN_WIDTH/4, 64+60, SCREEN_WIDTH/4, 50);
        }
        imageRect=CGRectMake((SCREEN_WIDTH/4-30)/2, 0, 30, 30);
        titleRect=CGRectMake(0, 32, SCREEN_WIDTH/4, 18);
        ClassButton *bt_class=[[ClassButton alloc] initWithFrame:btRect imageFrame:imageRect titleFrame:titleRect];
        NSString *imageTitle=[className objectAtIndex:i];
        NSString *imageName=[NSString stringWithFormat:@"%@.png",imageTitle];
        UIImage *button_image=[UIImage imageNamed:imageName];
        [bt_class setImage:button_image forState:UIControlStateNormal];
        [bt_class setTitle:imageTitle forState:UIControlStateNormal];
        [bt_class setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt_class addTarget:self action:@selector(classSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt_class];
    }
    
    tableView_product=[[UITableView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT-200-44)];
    tableView_product.dataSource=self;
    tableView_product.delegate=self;
    [self.view addSubview:tableView_product];
    
    UILabel *labelHead=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    labelHead.text=@"-大家都在团-";
    labelHead.textColor=MYGREENCOLOR;
    tableView_product.tableHeaderView=labelHead;
}

#pragma mark --UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  productArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDataSource* product=[productArray objectAtIndex:indexPath.row];
    ProductTableViewCell *cell=[ProductTableViewCell createCellWithTableview:tableView];
    [cell loadData:product];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.6;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDataSource *itemDataSource=[productArray objectAtIndex:indexPath.row];
    vc_item=[[ItemViewController alloc] init];
    vc_item.itemDataSource=itemDataSource;
    [self.navigationController pushViewController:vc_item animated:true];
}

-(void)classSelectAction:(ClassButton *)bt{
    //根据当前button的tag属性，跳转到相应的页面
    vc_subClass=[[BusinessViewController alloc] init];
    [self.navigationController pushViewController:vc_subClass animated:true];
}

-(void)loginAction{
    if (vc_login==nil) {
        vc_login=[[LoginViewController alloc] init];
    }
    [self presentViewController:vc_login animated:true completion:nil];
}

-(void)qrcodeAction{
    
}

-(void)selectCityAction{
    if (vc_citySelect==nil) {
        vc_citySelect=[[CitySelectViewController alloc] init];
    }
    [self.navigationController pushViewController:vc_citySelect animated:true];
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *currentCityName=[MyDataSourse sharedMyDataSource].currentCityName;
    if (currentCityName==nil) {
        [bt_selectCity setTitle:@"上海" forState:UIControlStateNormal];
    }else{
        [bt_selectCity setTitle:currentCityName forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Model 模拟数据
-(void)generateSimulateData{
    NSArray *productTitle=@[@"牛排",@"地三鲜",@"松仁大侠",@"冷饮",@"牛排",@"地三鲜",@"松仁大侠",@"冷饮",@"牛排",@"地三鲜",@"松仁大侠",@"冷饮"];
    NSArray *productSubTitle=@[@"超值单人套餐，10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",
                                @"体验冷热酸甜想吃就就是这种感觉",@"超值单人套餐，10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",
                                @"体验冷热酸甜想吃就就是这种感觉",@"超值单人套餐，10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",
                                @"体验冷热酸甜想吃就就是这种感觉"];
    NSArray *productMoney=@[@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9"];
    NSArray *productDiscount=@[@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢"];
    NSArray *productSale=@[@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份"];
    productArray=[[NSMutableArray alloc] init];
    for (int i=0; i<12; i++) {
        ProductDataSource *dataSource=[[ProductDataSource alloc] init];
        NSString *image=[NSString stringWithFormat:@"product%d.png",i+1];//一般这些内容都是从网络上加载下来的，但是这里只是为了模拟
        NSString *title=[productTitle objectAtIndex:i];
        NSString *subTitle=[productSubTitle objectAtIndex:i];
        NSString *money=[productMoney objectAtIndex:i];
        NSString *discount=[productDiscount objectAtIndex:i];
        NSString *sale=[productSale objectAtIndex:i];
        
        dataSource.image=image;
        dataSource.title=title;
        dataSource.subtitle=subTitle;
        dataSource.money=money;
        dataSource.discount=discount;
        dataSource.sale=sale;
        
        [productArray addObject:dataSource];
        [[MyDataSourse sharedMyDataSource] setHomeProductDataArray:productArray];
    }
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
