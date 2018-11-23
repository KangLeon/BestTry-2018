//
//  ViewController.m
//  MMKV
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import <MMKV.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MMKV *mmkv = [MMKV defaultMMKV];
    
    NSDictionary *dic=@{@"nihao":@"nihao"};
    
    [mmkv setObject:dic forKey:@"nameDic"];
    [mmkv setBool:YES forKey:@"bool"];
    [mmkv setInt32:-1024 forKey:@"int32"];
    [mmkv setObject:@"hello, mmkv" forKey:@"string"];
    
    NSDictionary *nameDic=[mmkv getObjectOfClass:[NSDictionary class] forKey:@"nameDic"];
    BOOL bValue = [mmkv getBoolForKey:@"bool"];
    int32_t iValue = [mmkv getInt32ForKey:@"int32"];
    NSString *str = [mmkv getObjectOfClass:NSString.class forKey:@"string"];
    
    NSLog(@"%@%d%d%@",nameDic,bValue,iValue,str);
}


@end
