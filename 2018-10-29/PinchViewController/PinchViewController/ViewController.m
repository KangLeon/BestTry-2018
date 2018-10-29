//
//  ViewController.m
//  PinchViewController
//
//  Created by admin on 2018/10/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController () <UIScrollViewDelegate>
//设置Viewcontroller为代理
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
    imageView.image=[UIImage imageNamed:@"1.jpg"];
    [self.scrollView addSubview:imageView];
    
    self.imageView = imageView;
    
    self.scrollView.contentSize = imageView.frame.size;
    
    //设置缩放比例
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.minimumZoomScale = 1.0;
    
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGes.numberOfTapsRequired=2;
    
    [self.scrollView addGestureRecognizer:tapGes];
    
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    self.scrollView.zoomScale=1.0;
}

#pragma mark -<UIScrollViewDelegate>
/**
 *返回一个需要进行缩放的子控件（scrollView的子控件）
 */

void AudioServicesPlaySystemSoundWithVibration(int, id, NSDictionary *);

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if (!(self.scrollView.zoomScale<3.0)) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        // 可以自己设定震动间隔与时常（毫秒）
        // 是否生效, 时长, 是否生效, 时长……
        NSArray *pattern = @[@YES,@1];
        
        dictionary[@"VibePattern"] = pattern; // 模式
        dictionary[@"Intensity"] = @.3; // 强度（测试范围是0.3～1.0）
        
        AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dictionary);
    }else if(!(self.scrollView.zoomScale>1.0)){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        NSArray *pattern = @[@YES, @1];
        
        dictionary[@"VibePattern"] = pattern;
        dictionary[@"Intensity"] = @.3;
        
        AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dictionary);
    }else{
        //正常情况
    }
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end

