//
//  ViewController.m
//  GCD
//
//  Created by jitengjiao      on 2018/3/16.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test7];
}

-(void)test7{
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"------%zu-------",index);
    });
}

-(void)test6{
    NSLog(@"%@",[NSThread mainThread]);
    dispatch_queue_t queue=dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test5{
    NSLog(@"%@",[NSThread mainThread]);
    dispatch_queue_t queue=dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test4{
    NSLog(@"%@",[NSThread mainThread]);
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test3{
    NSLog(@"%@",[NSThread mainThread]);
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test2{
    NSLog(@"%@",[NSThread mainThread]);
    dispatch_queue_t queue=dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test1{
    //并行队列+同步添加任务
    NSLog(@"%@",[NSThread mainThread]);
    
    dispatch_queue_t queue=dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"mission 1");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 2");
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"mission 3");
        NSLog(@"%@",[NSThread currentThread]);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
