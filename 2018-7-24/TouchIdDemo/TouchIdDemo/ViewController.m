//
//  ViewController.m
//  TouchIdDemo
//
//  Created by 吉腾蛟 on 2018/7/24.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)requestTouchID:(id)sender {

    __block typeof(self) weakSelf=self;
    [TouchIDTool authenTouchIDWithSuccess:^{
        weakSelf.resultLabel.text=@"验证成功";
    } andfailure:^(NSInteger errorCode, NSString *errorReason) {
        weakSelf.resultLabel.text=errorReason;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
