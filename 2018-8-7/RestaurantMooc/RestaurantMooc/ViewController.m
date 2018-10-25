//
//  ViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/7.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"
#import "DataPersisit.h"
#import "IMNetwork.h"
#import "IMImageNetwork.h"
#import "DataSource.h"
#import "ProductDatasource.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property(nonatomic,strong)AppDelegate *app;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.获取版本号
    NSString *appVersion=[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    float appVersionf=appVersion.floatValue;
    if (appVersionf<APPCURRENTNUM) {
        //如果小于最新版本号，就执行更新操作
        
    }else{
        NSLog(@"app版本号最新！");
    }
    NSLog(@"%@",appVersion);
    
    //2.引导页面
    NSString *firstLoad=[DataPersisit readValuePre:@"loadNum"];//读取存的值，用来判断是不是首次进入
    int loadNum=firstLoad.intValue;
    if (!loadNum) {
        //如果是首次进入的话，就显示引导页面
        UIScrollView *vc_boot=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        vc_boot.contentSize=CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
        vc_boot.contentOffset=CGPointMake(0, 0);
        vc_boot.pagingEnabled=true;
        vc_boot.showsHorizontalScrollIndicator=false;
        for (int i=0; i<3; i++) {
            NSString *imageName=[NSString stringWithFormat:@"guide%d.jpg",i+1];
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageView.image=[UIImage imageNamed:imageName];
            [vc_boot addSubview:imageView];
        }
        //屏幕适配
        CGFloat bt_w=SCREEN_WIDTH*0.6;
        CGFloat bt_h=40;
        CGFloat bt_x=SCREEN_WIDTH*2+(SCREEN_WIDTH-bt_w)/2;
        CGFloat bt_y=SCREEN_HEIGHT-bt_h-30;
        
        UIButton *bt_enter=[[UIButton alloc] initWithFrame:CGRectMake(bt_x, bt_y, bt_w, bt_h)];
        [bt_enter setTitle:@"开始体验" forState:UIControlStateNormal];
        [bt_enter setTitleColor:MYCOLORYELLOW forState:UIControlStateNormal];
        bt_enter.layer.cornerRadius=5.0;
        bt_enter.layer.borderWidth=2.0;
        bt_enter.layer.borderColor=MYCOLORYELLOW.CGColor;
        [bt_enter addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
        [vc_boot addSubview:bt_enter];
        [self.view addSubview:vc_boot];
        
        [self uppdateLoadNum:1];
    }else{
        //直接进入app
        NSString *countStr=[DataPersisit readValuePre:@"loadNum"];
        int count=countStr.intValue;
        [self uppdateLoadNum:count+1];
        
        [self enterApp];
    }
}

-(void)uppdateLoadNum:(int)count{
    [DataPersisit writeValuePre:[NSString stringWithFormat:@"%d",count] key:@"loadNum"];
}

-(void)enterApp{
    //1.notifi 2 http
    //订阅4个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage:) name:@"loadimagefood" object:nil];//IMNetwork
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage:) name:@"loadimagefruit" object:nil];//IMNetwork
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFoodImage) name:@"imoocloadfood" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFruitImage) name:@"imoocloadfruit" object:nil];
    
    
    IMNetwork *network=[[IMNetwork alloc] init];
    [network getProductInfo:FOODURL];
}

-(void)loadImage:(NSNotification*)notif{
    NSDictionary *dic=notif.userInfo;
    NSArray *array=[dic valueForKey:@"url"];
    for (int i=0 ; i<array.count; i++) {
        NSString *string=[array objectAtIndex:i];
        [[IMImageNetwork getInstance] laodImageData:string];//根据数组中的url发松网络请求
    }
}

-(void)loadFoodImage{
    NSMutableArray *productArray=[[DataSource getInstance] getPdArray];
    [self generateSimulateData:productArray];
    IMNetwork *network=[[IMNetwork alloc] init];
    [network getProductInfo:FRUITURL];
}

-(void)loadFruitImage{
    NSMutableArray *fruitArray=[[DataSource getInstance] getFruitArray];
    NSMutableArray *pdArray=[[DataSource getInstance] getPdArray];
    for (int i=0; i<8; i++) {
        ProductDatasource *dataSource=[pdArray objectAtIndex:i];
        ProductDatasource *fruitSource=[fruitArray objectAtIndex:i];
        
        fruitSource.title=dataSource.title;
        fruitSource.subTitle1=dataSource.subTitle1;
        fruitSource.subTitle2=dataSource.subTitle2;
        fruitSource.subTitle3=dataSource.subTitle3;
        fruitSource.saledNum=dataSource.saledNum;
        
        fruitSource.flag=1;
        
        
        ProductDatasource *item=[[ProductDatasource alloc] init];
        item.title=dataSource.title;
        item.subTitle1=dataSource.subTitle1;
        item.subTitle2=dataSource.subTitle2;
        item.subTitle3=dataSource.subTitle3;
        item.saledNum=dataSource.saledNum;
        item.imageData=dataSource.imageData;
        item.flag=1;
        
        [[DataSource getInstance] loadFoodItem:item];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        MainViewController *tb_main=[[MainViewController alloc] init];
        self.app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.app.window.rootViewController=tb_main;
    });
}

//生成图片的模拟信息
-(void)generateSimulateData:(NSMutableArray*)productArray{
    NSArray *productTitle = @[@"牛排",@"地三鲜",@"松仁大虾",@"冷饮",@"牛排",@"地三鲜",@"松仁大虾",@"冷饮"];
    NSArray *productSubTitle1 = @[@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉",@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉",@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉"];
    NSArray *productSubTitle2 = @[@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9"];
    NSArray *productSubTitle3 = @[@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢"];
    NSArray *productSaleNum = @[@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份"];
    
    for (int i = 0; i<8; i++) {
        ProductDatasource *dataSource = [productArray objectAtIndex:i];
        NSString *title = [productTitle objectAtIndex:i];
        NSString *subTitle1 = [productSubTitle1 objectAtIndex:i];
        NSString *subTitle2 = [productSubTitle2 objectAtIndex:i];
        NSString *subTitle3 = [productSubTitle3 objectAtIndex:i];
        NSString *saleNum = [productSaleNum objectAtIndex:i];
        
        dataSource.title = title;
        dataSource.subTitle1 = subTitle1;
        dataSource.subTitle2 = subTitle2;
        dataSource.subTitle3 = subTitle3;
        dataSource.saledNum = saleNum;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
