//
//  ViewController.m
//  PopViewController
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "MyNavViewController.h"
#import "NewViewController.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIPopoverPresentationControllerDelegate>{
    UIButton *myButton;
}

@property(nonatomic,strong)MyNavViewController *nav_ViewController;
@property(nonatomic,strong)NewViewController *my_ViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myButton=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 200, 200, 50)];
    [myButton setTitle:@"回复沙雕网友" forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    myButton.backgroundColor=[UIColor grayColor];
    myButton.layer.cornerRadius=12.0;
    [myButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
}

-(void)pop{
    
    self.my_ViewController=[[NewViewController alloc] init];
    self.nav_ViewController=[[MyNavViewController alloc] initWithRootViewController:self.my_ViewController];
    
    self.nav_ViewController.preferredContentSize=CGSizeMake(300, 500);//设置浮窗的宽高
    self.nav_ViewController.modalPresentationStyle=UIModalPresentationPopover;
    
    //设置弹出视图
    UIPopoverPresentationController *popover=[self.nav_ViewController popoverPresentationController];
    popover.delegate=self;
    popover.permittedArrowDirections=UIPopoverArrowDirectionAny;//设置箭头位置
    popover.sourceView=myButton;//设置目标视图
    popover.sourceRect=myButton.bounds;//弹出视图显示位置
    popover.backgroundColor=[UIColor whiteColor];
    [self presentViewController:self.nav_ViewController animated:true completion:nil];
}

//设置浮窗的弹出样式，效果途中设置style为UIModalPresentationNone
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

//点击浮窗背景popover controller是否消失
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return true;
}

//浮窗消失时调用
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
}

@end
