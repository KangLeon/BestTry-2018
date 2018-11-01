//
//  ViewController.m
//  ScrollTest
//
//  Created by admin on 2018/10/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)CGSize size;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.size=CGSizeMake(SCREEN_WIDTH-40, 64);
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 200, self.size.width, self.size.height)];
    self.scrollView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.scrollView.contentSize=CGSizeMake(self.size.width*3, self.size.height);
    self.scrollView.contentOffset=CGPointMake(self.size.width, 0);
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.decelerationRate=0.5;//降速比例调低
    self.scrollView.delegate=self;
    
    [self.view addSubview:self.scrollView];
    [self addButton];
}

-(void)addButton{
    @autoreleasepool {
        UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(self.size.width, 0, self.size.width, self.size.height)];
        [backView setTag:10000];
        [self.scrollView addSubview:backView];
        for (int i=0; i<7; i++) {
            UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake((self.size.width-100*7)/8*(i+1)+100*i, 8.6, 100, 43)];
            button.backgroundColor=[UIColor clearColor];
            [button addTarget:self action:@selector(myself:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[self trans_string:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [backView addSubview:button];
        }
    }
}

-(void)myself:(UIButton *)button{
    NSLog(@"你好");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    NSLog(@"%f",scrollView.bounds.size.width);

    if (scrollView.contentOffset.x>scrollView.bounds.size.width) {
        NSLog(@"往左");
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *view in self.scrollView.subviews) {
                if (view.tag==10000) {
                    view.transform=CGAffineTransformTranslate(view.transform, -self.size.width, self.size.height*0.5);
                    view.transform=CGAffineTransformScale(view.transform, 0.01, 0.01);
                }
            }
        }];
    }else if (scrollView.contentOffset.x<scrollView.bounds.size.width){
        NSLog(@"往右");
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *view in self.scrollView.subviews) {
                if (view.tag==10000) {
                    view.transform=CGAffineTransformTranslate(view.transform, self.size.width*2, self.size.height*0.5);
                    view.transform=CGAffineTransformScale(view.transform, 0.01, 0.01);
                }
            }
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (scrollView == self.scrollView) {

        if (scrollView.contentOffset.x>scrollView.bounds.size.width+100) {
            [self addButton];
        }else if (scrollView.contentOffset.x<scrollView.bounds.size.width-100){
            [self addButton];
        }

        CGRect bounds = self.scrollView.bounds;
        bounds.origin.x = CGRectGetWidth(bounds);
        bounds.origin.y = 0;
        [self.scrollView scrollRectToVisible:bounds animated:NO];
    }
}

-(NSString *)trans_string:(NSInteger )week_num{
    switch (week_num) {
            case 0:
            return [NSString stringWithFormat:@"%d",arc4random()];
            break;
            case 1:
            return @"周二";
            break;
            case 2:
            return @"周三";
            break;
            case 3:
            return @"周四";
            break;
            case 4:
            return @"周五";
            break;
            case 5:
            return @"周六";
            break;
            case 6:
            return @"周日";
            break;
    }
    return nil;
}

@end
