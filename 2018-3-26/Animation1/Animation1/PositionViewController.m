//
//  PositionViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "PositionViewController.h"

@interface PositionViewController ()
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        [self.blueView setCenter:CGPointMake(self.view.bounds.size.width-self.blueView.center.x, self.blueView.center.y)];
        
        
        
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pinkView setCenter:CGPointMake(self.view.bounds.size.width-self.pinkView.center.x,self.view.bounds.size.height-self.blueView.center.y)];
        
    } completion:nil];
    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.yellowView setCenter:CGPointMake(self.view.bounds.size.width-self.yellowView.center.x, self.view.bounds.size.height-self.yellowView.center.y)];
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
