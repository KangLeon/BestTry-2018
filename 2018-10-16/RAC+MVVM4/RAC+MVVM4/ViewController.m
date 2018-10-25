//
//  ViewController.m
//  RAC+MVVM4
//
//  Created by admin on 2018/10/17.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *secondTextfield;
@property (weak, nonatomic) IBOutlet UITextField *thirdTextfield;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    @weakify(self);
    RACSignal *firstSignal=[[self.firstTextfiled rac_textSignal] distinctUntilChanged];
    RACSignal *secondSignal=[[self.secondTextfield rac_textSignal] distinctUntilChanged];
    RACSignal *thirdSignal=[[self.thirdTextfield rac_textSignal] distinctUntilChanged];
    RACSignal *resultSignal=[RACSignal combineLatest:@[firstSignal,secondSignal,thirdSignal] reduce:^id _Nullable(NSString *s1,NSString *s2,NSString *s3){
        return [NSString stringWithFormat:@"%@",@([s1 integerValue]+[s2 integerValue]+[s3 integerValue])];
    }] ;
    [resultSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.resultLabel.text=[NSString stringWithFormat:@"%@",x];
        [self.resultLabel sizeToFit];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
