//
//  TableViewController.m
//  AutoLayoutDemo1
//
//  Created by jitengjiao      on 2018/2/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "TableViewController.h"
#import "MyTableViewCell.h"

@interface CellData : NSObject

@property (nonatomic,strong) UIImage * avatar;
@property (nonatomic,strong) NSString * textName;
@property (nonatomic,strong) NSString * textContent;

@end

@implementation CellData

@end

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arr;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr=@[].mutableCopy;
    for (int i=0; i<10; i++) {
        CellData *data=[CellData new];
        data.avatar=[UIImage imageNamed:@"IMG_4985"];
        data.textName=[NSString stringWithFormat:@"name_%d",i];
        data.textContent=[NSString stringWithFormat:@"content_%d",i];
        [self.arr addObject:data];
    }
    
    self.tableView.estimatedRowHeight=80;//上下滑动时。估算的rowheight，
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    
    cell=(MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    CellData *data=self.arr[indexPath.row];
    MyTableViewCell *myCell=(MyTableViewCell*)cell;
    
    myCell.imageView.image=data.avatar;
    myCell.labName.text=data.textName;
    myCell.lbContent.text=data.textContent;

    return cell;
}


@end
