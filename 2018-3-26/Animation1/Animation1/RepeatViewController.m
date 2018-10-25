//
//  RepeatViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "RepeatViewController.h"

@interface RepeatViewController ()
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation RepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        self.pinkView.center=CGPointMake(self.view.frame.size.width-self.pinkView.center.x, self.pinkView.center.y);
    }];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self.blueView.center=CGPointMake(self.view.frame.size.width-self.blueView.center.x, self.blueView.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
         self.greenView.center=CGPointMake(self.view.frame.size.width-self.greenView.center.x, self.greenView.center.y);
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
