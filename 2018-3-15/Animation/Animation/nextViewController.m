//
//  nextViewController.m
//  Animation
//
//  Created by jitengjiao      on 2018/3/15.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "nextViewController.h"

@interface nextViewController ()

@end

@implementation nextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(push)];
    
    self.navigationItem.rightBarButtonItem=left;
}

-(void)push{
    
    [self.navigationController popViewControllerAnimated:true];
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
