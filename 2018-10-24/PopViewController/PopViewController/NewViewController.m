//
//  NewViewController.m
//  PopViewController
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NewViewController.h"
#import "TextViewController.h"

@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *name_Array;
@property(nonatomic,strong)TextViewController *text_VC;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"沙雕网友列表";
    self.name_Array=@[@"北京沙雕网友1",@"上海沙雕网友2",@"昆明沙雕网友3",@"日本沙雕网友4",@"美国沙雕网友5",@"韩国沙雕网友6"];
    
    self.tableView=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=self.name_Array[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.text_VC.navigationItem.title=self.name_Array[indexPath.row];
    [self.navigationController pushViewController:self.text_VC animated:true];
}

-(TextViewController *)text_VC{
    if (!_text_VC) {
        _text_VC=[[TextViewController alloc] init];
    }
    return _text_VC;
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
