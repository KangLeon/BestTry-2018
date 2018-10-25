//
//  JumpViewController.m
//  Popover
//
//  Created by jitengjiao      on 2018/3/8.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "JumpViewController.h"

@interface JumpViewController ()

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view_nav=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view_nav.backgroundColor=MYGREENCOLOR;
    [self.view addSubview:view_nav];
    
    UILabel *title_lab=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, (64-10)/2, 90, 20)];
    title_lab.text=@"发起群聊";
    title_lab.textColor=[UIColor whiteColor];
    title_lab.font=[UIFont systemFontOfSize:20.0];
    [view_nav addSubview:title_lab];
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
