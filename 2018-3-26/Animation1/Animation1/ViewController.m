//
//  ViewController.m
//  Animation1
//
//  Created by jitengjiao      on 2018/3/25.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *positionButton;
@property (weak, nonatomic) IBOutlet UIButton *opcaityButton;
@property (weak, nonatomic) IBOutlet UIButton *scaleButton;
@property (weak, nonatomic) IBOutlet UIButton *coclorButton;
@property (weak, nonatomic) IBOutlet UIButton *rotationButton;
@property (weak, nonatomic) IBOutlet UIButton *RepeatButton;
@property (weak, nonatomic) IBOutlet UIButton *springButton;
@property (weak, nonatomic) IBOutlet UIButton *Login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _positionButton.backgroundColor=[UIColor blueColor];
//    [_positionButton setTintColor:[UIColor whiteColor]];
    _positionButton.frame=CGRectMake(160, 121 ,57, 25);
    _positionButton.layer.cornerRadius=12;
    
//    [opcaityButton setTintColor:[UIColor whiteColor]];
    _opcaityButton.frame=CGRectMake(160, _positionButton.frame.origin.y+40 ,57, 25);
    _opcaityButton.layer.cornerRadius=12;
    
    self.scaleButton.frame=CGRectMake(160, _opcaityButton.frame.origin.y+40 ,57, 25);
    self.scaleButton.layer.cornerRadius=12;
    
    self.coclorButton.frame=CGRectMake(160, self.scaleButton.frame.origin.y+40 ,57, 25);
    self.coclorButton.layer.cornerRadius=12;
    
    self.rotationButton.frame=CGRectMake(160, self.coclorButton.frame.origin.y+40 ,57, 25);
    self.rotationButton.layer.cornerRadius=12;
    
    self.RepeatButton.frame=CGRectMake(160, self.rotationButton.frame.origin.y+40 ,57, 25);
    self.RepeatButton.layer.cornerRadius=12;
    
    self.springButton.frame=CGRectMake(160, self.RepeatButton.frame.origin.y+40 ,57, 25);
    self.springButton.layer.cornerRadius=12;
    
    self.Login.frame=CGRectMake(160, self.springButton.frame.origin.y+40 ,57, 25);
    self.Login.layer.cornerRadius=12;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
