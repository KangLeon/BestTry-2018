//
//  ViewController.m
//  BasicAnimation
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import "UIButtonView.h"

@interface ViewController ()
@property(nonatomic,strong)UIButtonView *button_view;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _button_view=[[UIButtonView alloc] initWithFrame:CGRectMake(20, 200, (self.view.frame.size.width-40), 60)];
    [self.view addSubview:self.button_view];
    
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actions)];
    [_button_view addGestureRecognizer:tapGes];
}

-(void)actions{
    [_button_view startAnimation];
}

@end
