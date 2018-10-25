//
//  HomeViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "HomeViewController.h"
#import "MyButton.h"
#import "DataSource.h"
#import "Util.h"
#import "CitySelectedButton.h"
#import "ProductTableViewCell.h"
#import "CitySelectViewController.h"
#import "ItemViewController.h"
#import "LoginViewController.h"
#import "LuckView.h"

@interface HomeViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,LuckViewDelegate>{
    MyButton *bt_location;
    CitySelectedButton *bt_selectedCity;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSTimer *timer;
    int imageIndex;
    UITableView *tableView_product;
    NSMutableArray *productArray;
    CitySelectViewController *citySelect_VC;
    ItemViewController *item_VC;
    LoginViewController *login_VC;
    UIView *maskView;
    LuckView *luckView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取当前定位数据
    [[DataSource getInstance] getLocationdata];
    
    
    //1.定位
    bt_location=[[MyButton alloc] initWithFrame:CGRectMake(0, 0, 65, 44) imageFrame:CGRectMake(0, 14, 20, 20) titleFrame:CGRectMake(30, 0, 40, 44)];
    UIImage *image=[UIImage imageNamed:@"location.png"];
    [bt_location setImage:image forState:UIControlStateNormal];
    NSString *currentCity=[[DataSource getInstance] getcurrentCity];
    [bt_location setTitle:@"北京" forState:UIControlStateNormal];
    UIBarButtonItem *bbi_login=[[UIBarButtonItem alloc] initWithCustomView:bt_location];
    
    //2，登录
    image=[UIImage imageNamed:@"qr_code.png"];
    UIImage *qrImgae=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *bt_QRCode=[[UIBarButtonItem alloc] initWithImage:qrImgae style:UIBarButtonItemStyleDone target:self action:@selector(qrcodeAction)];
    NSArray *bt_array=[[NSArray alloc] initWithObjects:bbi_login,bt_QRCode, nil];
    self.navigationItem.leftBarButtonItems=bt_array;
    
    //3.搜索
    UITextField *tf_search=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100-65-70, 25)];
    tf_search.backgroundColor=[UIColor whiteColor];
    tf_search.borderStyle=UITextBorderStyleNone;
    tf_search.layer.borderColor=[UIColor whiteColor].CGColor;
    tf_search.layer.cornerRadius=12.5;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    imageView.image=[UIImage imageNamed:@"search.png"];
    [view addSubview:imageView];
    tf_search.leftView=view;
    tf_search.leftViewMode=UITextFieldViewModeAlways;
    tf_search.delegate=self;
    self.navigationItem.titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100-100, 25)];
    self.navigationItem.titleView.backgroundColor=[UIColor clearColor];
    [self.navigationItem.titleView addSubview:tf_search];
    
    //4.手动定位
    bt_selectedCity=[[CitySelectedButton alloc] initWithFrame:CGRectMake(0, 0, 65, 44)];
    [bt_selectedCity addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    [bt_selectedCity setTitle:@"定位" forState:UIControlStateNormal];
    [bt_selectedCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt_selectedCity setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    UIBarButtonItem *bbi_selectCity=[[UIBarButtonItem alloc] initWithCustomView:bt_selectedCity];
    self.navigationItem.rightBarButtonItem=bbi_selectCity;
    
    //5.轮播图
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 200);
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.pagingEnabled=true;
    scrollView.delegate=self;
    for (int index=0; index<4; index++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 200)];
        NSString *imagePath=[NSString stringWithFormat:@"product%d.jpg",index+1];
        imageView.image=[UIImage imageNamed:imagePath];
        [scrollView addSubview:imageView];
    }
    
    [self.view addSubview:scrollView];
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 64+160, SCREEN_WIDTH, 20)];
    pageControl.numberOfPages=4;
    pageControl.currentPage=0;
    pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imagePlay) userInfo:nil repeats:true];
    imageIndex=0;
    
    //6.分类页面
    int view59Y=269;
    UIImageView *view59=[[UIImageView alloc] initWithFrame:CGRectMake(10, view59Y, 80, 20)];
    view59.image=[UIImage imageNamed:@"59.png"];
    [self.view addSubview:view59];
    
    UILabel *label2=[[UILabel alloc] init];
    label2.frame=CGRectMake(SCREEN_WIDTH-80, view59Y, 80, 20);
    label2.text=@"限时优惠";
    label2.textColor=MYCOLORBLUE;
    [self.view addSubview:label2];
    
    UILabel *label3=[[UILabel alloc] init];
    label3.frame=CGRectMake((SCREEN_WIDTH-160)/2, view59Y, 160, 20);
    label3.text=@"北京五道口体校店";
    label3.textColor=[UIColor blackColor];
    label3.textAlignment=1;
    [self.view addSubview:label3];
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(0, 375+90, SCREEN_WIDTH, 5)];
    view2.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.5];
    [self.view addSubview:view2];
    NSArray *className=@[@"地方菜系",@"浪漫西餐",@"咖啡香茶",@"健康减肥",@"养生美酒",@"每日签到",@"健康素食",@"更多功能"];
    for (int i=0; i<8; i++) {
        CGRect btRect;
        CGRect imageRect;
        CGRect titleRect;
        if (i<4) {
            btRect=CGRectMake(i*SCREEN_WIDTH/4, 65+250, SCREEN_WIDTH/4, 60);
        }else{
            btRect=CGRectMake((i-4)*SCREEN_WIDTH/4, 85+310, SCREEN_WIDTH/4, 60);
        }
        imageRect=CGRectMake((SCREEN_WIDTH/4-40)/2, 0, 40, 40);
        titleRect=CGRectMake(0, 42, SCREEN_WIDTH/4, 18);
        MyButton *bt_class=[[MyButton alloc] initWithFrame:btRect imageFrame:imageRect titleFrame:titleRect];
        NSString *image=[NSString stringWithFormat:@"c%d.png",i+1];
        NSString *title=[className objectAtIndex:i];
        [bt_class setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [bt_class setTitle:title forState:UIControlStateNormal];
        bt_class.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [bt_class setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt_class addTarget:self action:@selector(classSelectAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt_class];
    }
    
    //7.今日爆款
    tableView_product =[[UITableView alloc] initWithFrame:CGRectMake(0, 485, SCREEN_WIDTH, SCREEN_HEIGHT-485-44)];
    tableView_product.dataSource=self;
    tableView_product.delegate=self;
    [self.view addSubview:tableView_product];
    
    productArray=[[DataSource getInstance] getPdArray];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.text=@"----当日爆款----";
    label.textColor=[UIColor blackColor];
    label.textAlignment=1;
    tableView_product.tableHeaderView=label;
    
    //接受广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect) name:@"imooccityselect" object:nil];
    
    
    [self loadLuckView];
}

-(void)citySelect{
    NSString *currentCity=[[DataSource getInstance] getcurrentCity];
    [bt_location setTitle:currentCity forState:UIControlStateNormal];
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
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDatasource *itemDataSource=[productArray objectAtIndex:indexPath.row];
    item_VC=[[ItemViewController alloc] init];
    item_VC.itemDataSource=itemDataSource;
    [self.navigationController pushViewController:item_VC animated:true];
}


-(void)selectCityAction{
    if (citySelect_VC==nil) {
        citySelect_VC=[[CitySelectViewController alloc] init];
    }
    [self.navigationController pushViewController:citySelect_VC animated:true];
    
}

-(void)classSelectAction{
    ProductDatasource *itemDataSource=[productArray objectAtIndex:0];
    item_VC=[[ItemViewController alloc] init];
    item_VC.itemDataSource=itemDataSource;
    [self.navigationController pushViewController:item_VC animated:true];
}

-(void)qrcodeAction{
    if (login_VC==nil) {
        login_VC=[[LoginViewController alloc] init];
    }
    [self presentViewController:login_VC animated:true completion:nil];
}


-(void)imagePlay{
    pageControl.currentPage=imageIndex;
    scrollView.contentOffset=CGPointMake(imageIndex*SCREEN_WIDTH, 0);
    imageIndex++;
    if (imageIndex>=4) {
        imageIndex=0;
    }
}

-(void)loadLuckView{
    maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    maskView.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
    [self.view addSubview:maskView];
    NSMutableArray *array=[NSMutableArray array];
    for (int i=0; i<9; i++) {
        [array addObject:[NSString stringWithFormat:@"luck%d",i+1]];
    }
    luckView=[[LuckView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-350)/2.0, (self.view.frame.size.height-350)/2.0, 350, 350) imageArray:array];
    luckView.delegate=self;
    [maskView addSubview:luckView];
    
    //close
    CGRect closeRect=CGRectMake((SCREEN_WIDTH-50)/2, SCREEN_HEIGHT-luckView.frame.origin.y, 50, 50);
    UIButton *bt_closr=[[UIButton alloc] initWithFrame:closeRect];
    [bt_closr setImage:[UIImage imageNamed:@"close1.png"] forState:UIControlStateNormal];
    [bt_closr setBackgroundImage:[UIImage imageNamed:@"close1.png"] forState:UIControlStateNormal];
    [bt_closr addTarget:self action:@selector(animationClose) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:bt_closr];
}

-(void)animationClose{
    [maskView removeFromSuperview];
}

-(void)luckViewDidStop:(int)index{
    NSLog(@"%d",index);
    [luckView removeFromSuperview];
    [maskView removeFromSuperview];
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
