//
//  ViewController.m
//  TableView4
//
//  Created by jitengjiao      on 2018/3/9.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "ViewController.h"
static NSString *cell_id=@"my_cell";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;
@property(copy,nonatomic)NSArray *nameArray;
@property(copy,nonatomic)NSArray *companyArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nameArray=[NSArray arrayWithObjects:@"微信",@"支付宝",@"淘宝",@"阿里巴巴", nil];
    self.companyArray=[NSArray arrayWithObjects:@"社交类App",@"支付类App",@"网络购物类App",@"大型网络公司", nil];
    
    //无需在控制器的- (void)viewDidLoad;方法注册cell，只需要在下面的cellForRowAtIndexPath这个方法中这样实现就行了，通过tableView中indexPath的使用就可以实现重用，
//    [self.myTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: cell_id];
    }
    cell.textLabel.text=[self.nameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[self.companyArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",cell.detailTextLabel.text);
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
