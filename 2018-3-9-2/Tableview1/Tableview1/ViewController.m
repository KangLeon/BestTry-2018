//
//  ViewController.m
//  Tableview1
//
//  Created by jitengjiao      on 2018/3/9.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(copy,nonatomic)NSArray *myArray;
@property(copy,nonatomic)NSArray *myArray1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myArray=[NSArray arrayWithObjects:@"微信",@"支付宝",@"淘宝",@"阿里巴巴", nil];
      self.myArray1=[NSArray arrayWithObjects:@"微信",@"支付宝",@"淘宝",@"阿里巴巴", nil];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id=@"mycell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_id];
    }
    cell.textLabel.text=[self.myArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[self.myArray1 objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
