//
//  ItemViewController.m
//  团购
//
//  Created by jitengjiao      on 2018/3/3.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ItemViewController.h"
#import "Util.h"
#import "StarRateView.h"

@interface ItemViewController ()<UIScrollViewDelegate,StarRateViewDelegate>{
    UIScrollView *sv_image;
    UIPageControl *pageControl;
    NSTimer *timer;
    int imageIndex;//当前图片的下标
    StarRateView *starRateView;
    UILabel *lab_currentScore;
}

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置标题栏上的文字是白色
    self.view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];//整个背景颜色为灰色
    NSString *title=self.itemDataSource.title;
    
    self.navigationItem.title=title;//设置导航栏上标题的文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19.0],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];//设置标题文字的属性
    
    //这个属性是为了解决scrollView的空白，让它不显示
//    self.automaticallyAdjustsScrollViewInsets=false;
    UIView *view_head=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
    view_head.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_head];
    
    sv_image=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
    sv_image.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);//这里难道真的是0⃣️ 吗？
    sv_image.directionalLockEnabled=true;
    sv_image.delegate=self;
    sv_image.showsHorizontalScrollIndicator=false;
    sv_image.bounces=true;
    sv_image.pagingEnabled=true;//按照整页来滚动
    [view_head addSubview:sv_image];
    
    for (int index=0; index<4; index++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
        NSString *imagePath=[NSString stringWithFormat:@"图片轮播%d.png",index+1];
        imageView.image=[UIImage imageNamed:imagePath];
        imageView.contentMode=UIViewContentModeScaleToFill;//内容显示模式是缩放并且填充
        [sv_image addSubview:imageView];
    }
    
    //页面滚动控制
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*0.6-20, SCREEN_WIDTH, 20)];
    pageControl.numberOfPages=4;
    pageControl.currentPage=0;
    pageControl.backgroundColor=[UIColor clearColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];

    [view_head addSubview:pageControl];
    
    //为了让轮播图定时播放
    imageIndex=0;
    timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imagePlay) userInfo:nil repeats:true];
    
    UIView *view_buy=[[UIView alloc] initWithFrame:CGRectMake(0, 64+SCREEN_WIDTH*0.6+5, SCREEN_WIDTH, 50)];
    view_buy.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_buy];
    
    
    UILabel *originLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 50)];
    originLabel.text=@"¥27.8";
    originLabel.font=[UIFont systemFontOfSize:15.0];
    originLabel.textColor=MYGREENCOLOR;
    [view_buy addSubview:originLabel];
    
    UILabel *groupLabel=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 0, 100, 50)];
    groupLabel.text=@"团购价：¥22";
    groupLabel.font=[UIFont systemFontOfSize:14.0];
    groupLabel.textColor=[UIColor grayColor];
    [view_buy addSubview:groupLabel];
    
    UIButton *bt_buy=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100), 0, 100, 50)];
    [bt_buy setTitle:@"¥19.9拍下" forState:UIControlStateNormal];
    bt_buy.backgroundColor=[UIColor orangeColor];
    [view_buy addSubview:bt_buy];
    
    //评分功能
    UIView *view_star=[[UIView alloc] initWithFrame:CGRectMake(0, view_buy.frame.origin.y+view_buy.frame.size.height, SCREEN_WIDTH, 40)];
    view_star.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_star];
    
    starRateView=[[StarRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    starRateView.delegate=self;
    [view_star addSubview:starRateView];
    
    lab_currentScore=[[UILabel alloc] initWithFrame:CGRectMake(starRateView.frame.size.width+5, 0, 50, 40)];
    lab_currentScore.text=@"零分";
    lab_currentScore.textColor=[UIColor grayColor];
    [view_star addSubview:lab_currentScore];
    
    //商品描述部分
    UIView *view_descri=[[UIView alloc] initWithFrame:CGRectMake(0, view_star.frame.origin.y+view_star.frame.size.height+5, SCREEN_WIDTH, 150)];
    view_descri.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_descri];
    
    UILabel *lab_title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    lab_title.text=@"商品详细信息";
    lab_title.textAlignment=NSTextAlignmentCenter;
    lab_title.font=[UIFont systemFontOfSize:15.0];
    [view_descri addSubview:lab_title];
    
    UILabel *lab_content=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
    lab_content.text=@"西冷牛排（Sir loin)，主要是由上腰部的脊肉构成，西冷牛排按质量的不同又可分为小块西冷牛排（entrecte）和大块西冷牛排（sirloin steak）。事实上Sirloin是法语Sur（上）和Loin（柳肉）合成的词，即牛柳上方的肉。每份都在250—300克左右。西冷（Sir loin）即下腰肉，也被称为纽约客，因牛下腰部运动量较菲力沙朗多，故此部位肉质较粗一点。";
    lab_content.numberOfLines=0;//可以多行显示
    lab_content.font=[UIFont systemFontOfSize:14.0];
    [view_descri addSubview:lab_content];
}

-(void)getCurrentScore:(CGFloat)currentScore{
    //当前的小数保留一位
    NSString *score=[NSString stringWithFormat:@"%.1f分",currentScore*5];//将分数扩大5倍
    lab_currentScore.text=score;
}

-(void)imagePlay{
    pageControl.currentPage=imageIndex;
    sv_image.contentOffset=CGPointMake(imageIndex*SCREEN_WIDTH, 0);
    imageIndex++;
    if (imageIndex>=4) {
        imageIndex=0;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{//为了让手指触摸滚动时更加顺滑，
    float x=scrollView.contentOffset.x;
    imageIndex=x/SCREEN_WIDTH;
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
