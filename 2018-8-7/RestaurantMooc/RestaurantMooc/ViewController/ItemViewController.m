//
//  ItemViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ItemViewController.h"
#import "Util.h"
#import "DataSource.h"
#import "StarRateView.h"

@interface ItemViewController ()<StartRateviewDelegate>{
    UIScrollView *sv_image;
    UIPageControl *pageControl;
    NSTimer *timer;
    int imageIndex;
    UILabel *lab_currentScore;
    StarRateView *starRateView;
}

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    NSString *title=self.itemDataSource.title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.automaticallyAdjustsScrollViewInsets=false;
    UIView *view_head=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
    view_head.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_head];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
    imageView.image=[UIImage imageWithData:self.itemDataSource.imageData];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [view_head addSubview:imageView];
    
    UIView *view_buy=[[UIView alloc] initWithFrame:CGRectMake(0, 64+SCREEN_WIDTH*0.6+5, SCREEN_WIDTH, 50)];
    view_buy.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_buy];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 50)];
    label1.text=@"¥34.8";
    label1.font=[UIFont systemFontOfSize:15.0];
    label1.textColor=MYCOLORYELLOW;
    [view_buy addSubview:label1];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 0, 100, 50)];
    label2.text=@"团购价:¥28";
    label2.font=[UIFont systemFontOfSize:14.0];
    label2.textColor=[UIColor grayColor];
    [view_buy addSubview:label2];
    
    UIButton *bt_buy=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100), 0, 100, 50)];
    [bt_buy setTitle:@"19.9拿下" forState:UIControlStateNormal];
    [bt_buy addTarget:self action:@selector(productBuy) forControlEvents:UIControlEventTouchUpInside];
    bt_buy.backgroundColor=[UIColor orangeColor];
    [view_buy addSubview:bt_buy];
    
    UIView *view_star=[[UIView alloc] initWithFrame:CGRectMake(0, view_buy.frame.origin.y+view_buy.frame.size.height+5, SCREEN_WIDTH, 40)];
    view_star.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_star];
    
    starRateView=[[StarRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    starRateView.delegate=self;
    [view_star addSubview:starRateView];
    
    lab_currentScore=[[UILabel alloc] initWithFrame:CGRectMake(starRateView.frame.size.width+5, 0, 50, 40)];
    lab_currentScore.text=@"0分";
    lab_currentScore.textColor=[UIColor grayColor];
    [view_star addSubview:lab_currentScore];
    
    UIView *view_desc=[[UIView alloc] initWithFrame:CGRectMake(0, view_star.frame.origin.y+view_star.frame.size.height+5, SCREEN_WIDTH, 150)];
    view_desc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_desc];
    
    UILabel *label_desc1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    label_desc1.text=@"商品详细信息";
    label_desc1.textAlignment=NSTextAlignmentCenter;
    label_desc1.font=[UIFont systemFontOfSize:15.0];
    [view_desc addSubview:label_desc1];
    
    UILabel *label_desc2=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
    label_desc2.text=@"该菜品口感纯正，价格公道，分量十足。欢迎进店品尝。门店地址：北京市海淀区XX路YY胡同999号。10月28日之前进店还能享受98折优惠呢！还等什么，手机下单立减五元！";
    label_desc2.numberOfLines=0;
    label_desc2.font=[UIFont systemFontOfSize:14.0];
    [view_desc addSubview:label_desc2];
}

-(void)productBuy{
    ProductDatasource *itemOrder=[[ProductDatasource alloc] init];
    itemOrder.imageData=self.itemDataSource.imageData;
    itemOrder.title=@"超值拿下";
    itemOrder.subTitle1=@"营养搭配，科学膳食，美味挡不住";
    itemOrder.subTitle2=@"¥22.2";
    itemOrder.subTitle3=@"新用户医院抢购";
    itemOrder.saledNum=@"已售:22份";
    itemOrder.flag=true;
    [[DataSource getInstance] loadOrderItem:itemOrder];
    NSMutableArray *array=[[DataSource getInstance] getOrderArray];
    NSString *orderNum=[NSString stringWithFormat:@"%ld",array.count];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:orderNum forKey:@"orderNum"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imoocorder" object:nil userInfo:dic];
    [[DataSource getInstance] add:itemOrder.title];
    [[DataSource getInstance] search];
    
}

-(void)getCurrentScore:(CGFloat)currentScore{
    NSString *score=[NSString stringWithFormat:@"%.1f分",currentScore*5];
    lab_currentScore.text=score;
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
