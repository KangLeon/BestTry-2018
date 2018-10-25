//
//  MainViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "OrderViewController.h"
#import "UserViewController.h"
#import "Util.h"

@interface MainViewController (){
    HomeViewController *home_VC;
    FindViewController *find_VC;
    UserViewController *user_VC;
    OrderViewController *order_VC;
    
    UINavigationController *nav_home;
    UINavigationController *nav_find;
    UINavigationController *nav_user;
    UINavigationController *nav_order;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    home_VC=[[HomeViewController alloc] init];
    home_VC.tabBarItem.title=@"主页";
    home_VC.tabBarItem.image=[UIImage imageNamed:@"home.png"];
    nav_home=[[UINavigationController alloc] initWithRootViewController:home_VC];
    [self addChildViewController:nav_home];
    
    find_VC=[[FindViewController alloc] init];
    find_VC.tabBarItem.title=@"分类";
    find_VC.tabBarItem.image=[UIImage imageNamed:@"find.png"];
    nav_find=[[UINavigationController alloc] initWithRootViewController:find_VC];
    [self addChildViewController:nav_find];
    
    order_VC=[[OrderViewController alloc] init];
    order_VC.tabBarItem.title=@"订单";
    order_VC.tabBarItem.image=[UIImage imageNamed:@"shop.png"];
    nav_order=[[UINavigationController alloc] initWithRootViewController:order_VC];
    [self addChildViewController:nav_order];
    
    user_VC=[[UserViewController alloc] init];
    user_VC.tabBarItem.title=@"用户";
    user_VC.tabBarItem.image=[UIImage imageNamed:@"user.png"];
    nav_user=[[UINavigationController alloc] initWithRootViewController:user_VC];
    [self addChildViewController:nav_user];
    
    self.tabBar.tintColor=MYCOLORBLUE;
    self.view.backgroundColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderItem:) name:@"imoocorder" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnfind) name:@"returnfindvc" object:nil];
}

-(void)returnfind{
    self.selectedIndex=1;
}

-(void)orderItem:(NSNotification*)noti{
    NSDictionary *dic=noti.userInfo;
    NSString *orderNum=[dic valueForKey:@"orderNum"];
    order_VC.tabBarItem.badgeValue=orderNum;
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
