//
//  SecondViewController.m
//  3DTouchDemo
//
//  Created by 吉腾蛟 on 2018/7/25.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"第二个视图";
}

//pick选项功能
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action1=[UIPreviewAction actionWithTitle:@"选项1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了选项1");
    }];
    UIPreviewAction *action2=[UIPreviewAction actionWithTitle:@"选项2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了选项2");
    }];
    UIPreviewAction *action3=[UIPreviewAction actionWithTitle:@"选项3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了选项3");
    }];
    
    return [NSArray arrayWithObjects:action1,action2,action3, nil];
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
