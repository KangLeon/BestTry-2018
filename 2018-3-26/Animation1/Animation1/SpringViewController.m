//
//  SpringViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "SpringViewController.h"

@interface SpringViewController ()
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@property (weak, nonatomic) IBOutlet UIView *blueview;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation SpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:2.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:nil animations:^{
          self.pinkView.center=CGPointMake(self.view.frame.size.width-self.pinkView.center.x, self.pinkView.center.y);
    } completion:nil];
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
