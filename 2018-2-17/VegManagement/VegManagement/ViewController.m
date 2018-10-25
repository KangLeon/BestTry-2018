//
//  ViewController.m
//  VegManagement
//
//  Created by jitengjiao      on 2018/2/17.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "VegetableManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *vegListView;
@property (weak,nonatomic) UIAlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _vegListView.delegate=self;
    _vegListView.dataSource=self;
    
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(addVegetables)];
    [self.navigationItem setRightBarButtonItem:rightBarBtn];
}

-(void)addVegetables{
    //生成提示框
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"增加蔬菜" message:nil preferredStyle:UIAlertControllerStyleAlert];
    _alertController=alertController;
    //增加蔬菜名的输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"蔬菜名";
        textField.tag=1;
    }];
    //增加菜价输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"菜价";
        textField.tag=2;
    }];
    //增加确定按钮
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *textFields=_alertController.textFields;
        NSString *vegName=nil;
        double vegPrice=0;
        for (UITextField *tf in textFields) {
            if (tf.tag==1) {
                vegName=tf.text;
            }else if (tf.text){
                vegPrice=[tf.text doubleValue];
            }
        }
        Vegetable *veg=[[Vegetable alloc] init];
        veg.name=vegName;
        veg.price=vegPrice;
        [[VegetableManager sharedInstance] addVegetable:veg];
        [_vegListView reloadData];
        _alertController=nil;
    }];
    [alertController addAction:confirmAction];
    //增加取消按钮
    UIAlertAction *cancelAction=[UIAlertAction
                                 actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    //显示提示框
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[VegetableManager sharedInstance] vegetables].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Vegetable *veg=[[[VegetableManager sharedInstance] vegetables] objectAtIndex:indexPath.row];
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text=veg.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"人民币%.2f",veg.price];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击涨一块
    UITableViewRowAction *actionEdit=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"涨一块" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Vegetable* veg=[[[VegetableManager sharedInstance] vegetables] objectAtIndex:indexPath.row];
        [[VegetableManager sharedInstance] changePrice:veg.price+1 forVegetableName:veg.name];
        [_vegListView reloadData];
    }];
    //点击删除
    UITableViewRowAction *actionDelete=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Vegetable* veg=[[[VegetableManager sharedInstance] vegetables] objectAtIndex:indexPath.row];
        [[VegetableManager sharedInstance] removeVegetableWithName:veg.name];
        [_vegListView reloadData];
    }];
    return @[actionEdit,actionDelete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
