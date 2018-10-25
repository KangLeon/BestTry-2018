//
//  ScaleViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ScaleViewController.h"

@interface ScaleViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        self.blueView.transform=CGAffineTransformMakeScale(1.0*3, 1.0*3);
    }];
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
