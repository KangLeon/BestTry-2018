//
//  ViewController.m
//  RAC+MVVM2
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UITextField *redInput;
@property (weak, nonatomic) IBOutlet UITextField *blueInput;
@property (weak, nonatomic) IBOutlet UITextField *greenInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _redInput.text=_blueInput.text=_greenInput.text=@"127";
    RACSignal *redSignal=[self bindSlider:_redSlider textField:_redInput];
    RACSignal *blueSignal=[self bindSlider:_blueSlider textField:_blueInput];
    RACSignal *greenSignal=[self bindSlider:_greenSlider textField:_greenInput];
    //comineLatest：是一种麻绳绑定
    RACSignal *changeValueSignal=[[RACSignal combineLatest:@[redSignal,blueSignal,greenSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        return [UIColor colorWithRed:[value[0] floatValue] green:[value[2] floatValue] blue:[value[1] floatValue] alpha:1.0];
    }];
    RAC(_showView,backgroundColor)=changeValueSignal;
}

-(RACSignal *)bindSlider:(UISlider *)slider textField:(UITextField *)textField{
    RACSignal *textSignal=[[textField rac_textSignal] take:1];//取一次的值
    //RACChannelTermina是一个通道终端，
    RACChannelTerminal *signalSlider=[slider rac_newValueChannelWithNilValue:nil];//获取slider的信号量
    RACChannelTerminal *signalText=[textField rac_newTextChannel];//获取textfield的信号量
    [signalText subscribe:signalSlider];//互相订阅，后面是订阅者
    [[signalSlider map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%0.2f",[value floatValue]];
    }] subscribe:signalText];
    //merge：是一种混乱绑定
    return [[signalText merge:signalSlider] merge:textSignal];//信号量合并
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
