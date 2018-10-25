//
//  ViewController.m
//  NSOperation
//
//  Created by jitengjiao      on 2018/3/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self test1];
}

-(void)test1{
    NSLog(@"%@",[NSThread mainThread]);
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    NSInvocationOperation *op=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operaion) object:nil];
    [queue addOperation:op];
}

-(void)operaion{
    NSLog(@"misson 1");
    NSLog(@"%@",[NSThread currentThread]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
