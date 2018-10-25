//
//  RotationViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()
@property (weak, nonatomic) IBOutlet UIView *pinkView;

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self spin];
}

-(void)spin{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.pinkView.transform=CGAffineTransformRotate(self.pinkView.transform, M_PI);
    } completion:^(BOOL finished) {
        [self spin];
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
