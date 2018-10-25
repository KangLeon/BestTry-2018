//
//  ViewController.m
//  MKWebImage
//
//  Created by 吉腾蛟 on 2018/7/28.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import "MKImageDownloader.h"
#import "MKImageManager.h"
#import "UIImageView+Cache.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tbView;
@property(nonatomic,strong)NSMutableArray *datesource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datesource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(UITableView *)tbView{
    if (!_tbView) {
        _tbView=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tbView.delegate=self;
        _tbView.dataSource=self;
        [self.view addSubview:_tbView];
    }
    return _tbView;
}


-(NSMutableArray *)datesource{
    if (!_datesource) {
        _datesource=[[NSMutableArray alloc] init];
    }
    return _datesource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
