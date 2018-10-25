//
//  ThirdViewController.m
//  MyRac3
//
//  Created by jitengjiao      on 2018/3/10.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ThirdViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ThirdViewController ()
{
    __weak IBOutlet UISlider *redSlider;
    __weak IBOutlet UISlider *greenSlider;
    __weak IBOutlet UISlider *blueSlider;
    __weak IBOutlet UITextField *redInput;
    __weak IBOutlet UITextField *greenInput;
    __weak IBOutlet UITextField *blueInput;
    __weak IBOutlet UIView *showView;
    
    CGFloat r,g,b;
}

@end

@implementation ThirdViewController

//- (void)viewDidLoad {
//
//    [super viewDidLoad];
//}

-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    redInput.text=blueInput.text=greenInput.text=@"0.5";
    RACSignal *redSignal=[self bingSlider:redSlider textField:redInput];
    RACSignal *greenSignal=[self bingSlider:greenSlider textField:greenInput];
    RACSignal *blueSignal=[self bingSlider:blueSlider textField:blueInput];
    
    //第一种方法 ，把值订阅然后展示在showView上
//    [[[RACSignal combineLatest:@[redSignal,blueSignal,greenSignal]] map:^id(RACTuple* value) {
//        NSLog(@"%@",value);
//        return [UIColor colorWithRed:[value[0] floatValue] green:[value[1] floatValue] blue:[value[1] floatValue] alpha:1];
//    }] subscribeNext:^(id x) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//                   showView.backgroundColor=x;
//        });
//    }];//这是合并返回成一个元组，必须三个值都改变才会返回值，
    
    //第二种方法 ，把值订阅然后展示在showView上
    RACSignal *changeValueSignal=[[RACSignal combineLatest:@[redSignal,blueSignal,greenSignal]] map:^id(RACTuple* value) {
                NSLog(@"%@",value);
                return [UIColor colorWithRed:[value[0] floatValue] green:[value[1] floatValue] blue:[value[1] floatValue] alpha:1];
            }];
    RAC(showView,backgroundColor)=changeValueSignal;//这样就绑定了
}

//双向绑定
-(RACSignal*)bingSlider:(UISlider *)slider textField:(UITextField *)textField{
    
    RACSignal *textSignal=[[textField rac_textSignal] take:1];
    
    //奇怪了，为什么RACChannelTerminal是RACSignal的孩子，但是RACChannelTerminal不可以使用RACSignal的方法呢？-----________------____-----_____------>??????
    RACChannelTerminal* signalSlider=[slider rac_newValueChannelWithNilValue:nil];//实时返回slider的数据更改
    RACChannelTerminal* signalTextField=[textField rac_newTextChannel];
    [signalTextField subscribe:signalSlider];
    [[signalSlider map:^id(id value) {
        return [NSString stringWithFormat:@"%.02f",[value floatValue]];
    }] subscribe:signalTextField];
    
    //将上面的两个信号量合并成一个新的信号量
    return [[signalTextField merge:signalSlider] merge:textSignal];//merge的合并不管先后顺序的
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
