//
//  ViewController.m
//  ShakeIt
//
//  Created by admin on 2018/10/29.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 声明震动函数及使用

void AudioServicesPlaySystemSoundWithVibration(int, id, NSDictionary *);

- (IBAction)shakeItAction:(id)sender {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    // 可以自己设定震动间隔与时常（毫秒）
    // 是否生效, 时长, 是否生效, 时长……
    NSArray *pattern = @[@YES,@10];
    
    dictionary[@"VibePattern"] = pattern; // 模式
    dictionary[@"Intensity"] = @.8; // 强度（测试范围是0.3～1.0）
    
    AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dictionary);
}




@end
