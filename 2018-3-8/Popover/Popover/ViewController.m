//
//  ViewController.m
//  Popover
//
//  Created by jitengjiao      on 2018/3/8.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "JumpViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define MYGRAYCOLOR [UIColor colorWithRed:214.0/255.0 green:223.0/255.0 blue:214.0/255.0 alpha:1.0];
#define MYGREENCOLOR [UIColor colorWithRed:0.16 green:0.72 blue:0.55 alpha:1.0];

@interface ViewController ()<UIPopoverPresentationControllerDelegate,BackString>
@property (strong,nonatomic) TestViewController *test_vc;
@property(strong,nonatomic) UIButton *pop_button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view_nav=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view_nav.backgroundColor=MYGREENCOLOR;
    [self.view addSubview:view_nav];
    
    UILabel *title_lab=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-45)/2, (64-10)/2, 45, 20)];
    title_lab.text=@"微信";
    title_lab.textColor=[UIColor whiteColor];
    title_lab.font=[UIFont systemFontOfSize:20.0];
    [view_nav addSubview:title_lab];
    
    self.pop_button=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50), (64-10)/2, 45, 20)];
    [self.pop_button setTitle:@"添加" forState:UIControlStateNormal];
    self.pop_button.backgroundColor=MYGREENCOLOR;
    [self.pop_button addTarget:self action:@selector(popto) forControlEvents:UIControlEventTouchUpInside];
    [view_nav addSubview:self.pop_button];
    
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
-(void)popto{
    
    _test_vc=[[TestViewController alloc] init];
    _test_vc.preferredContentSize=CGSizeMake(150, 250);//设置浮窗的宽高
    _test_vc.modalPresentationStyle=UIModalPresentationPopover;
    _test_vc.delegate=self;
        
    UIPopoverPresentationController *popover=[_test_vc popoverPresentationController];
    popover.delegate=self;
    popover.permittedArrowDirections=UIPopoverArrowDirectionUp;//设置箭头位置
    popover.sourceView=self.pop_button;//设置目标视图
    popover.sourceRect=self.pop_button.bounds;//弹出视图显示位置
    popover.backgroundColor=[UIColor whiteColor];
    [self presentViewController:_test_vc animated:true completion:nil];
}

-(void)getMyString:(NSString *)string{
    if ([string isEqualToString:@"发起群聊"]) {
        JumpViewController *jump_vc=[[JumpViewController alloc] init];
        NSLog(@"haha");
        [self presentViewController:jump_vc animated:true completion:nil];
    }
}
- (IBAction)myact:(UIButton *)sender {
    NSLog(@"Oh,i have been selected");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
