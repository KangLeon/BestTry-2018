//
//  CitySelectViewController.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/9.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "CitySelectViewController.h"
#import "Util.h"
#import "DataSource.h"

@interface CitySelectViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView;
    NSArray *cityArray;
    NSMutableArray *indexArray;
}

@end

@implementation CitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path=[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
    cityArray=[NSArray arrayWithContentsOfFile:path];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    indexArray=[[NSMutableArray alloc] init];
    for (NSArray *array in cityArray) {
        NSDictionary *dic=[array firstObject];
        NSString *cityLetter=[dic valueForKey:@"cityLetter"];
        [indexArray addObject:cityLetter];
    }
    
    UIView *view_tbHead=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UILabel *lab_hotCity=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-20, 5)];
    lab_hotCity.text=@"---热门城市---";
    lab_hotCity.font=[UIFont systemFontOfSize:12.0];
    lab_hotCity.textAlignment=NSTextAlignmentLeft;
    [view_tbHead addSubview:lab_hotCity];
    NSArray *array_hotCity=@[@"北京",@"上海",@"广州",@"深圳",@"重庆",@"集宁"];
    
    for (int i=0; i<6; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20+(i%3)*(SCREEN_WIDTH/3-10), (i/3)*40+25, SCREEN_WIDTH/3-20, 35)];
        NSString *cityName=[array_hotCity objectAtIndex:i];
        label.text=cityName;
        label.font=[UIFont systemFontOfSize:18.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        [view_tbHead addSubview:label];
    }
    tableView.tableHeaderView=view_tbHead;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cityArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *item=[cityArray objectAtIndex:section];
    return item.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"www.imooc.com.ciaomucanting.tb";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
         cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSArray *array=[cityArray objectAtIndex:indexPath.section];
    NSDictionary *dic=[array objectAtIndex:indexPath.row];
    NSString *cityName=[dic valueForKey:@"cityName"];
    cell.textLabel.text=cityName;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str=[indexArray objectAtIndex:section];
    return str;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return indexArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array=[cityArray objectAtIndex:indexPath.section];
    NSDictionary *dic=[array objectAtIndex:indexPath.row];
    NSString *str=[dic valueForKey:@"cityName"];
    [[DataSource getInstance] setcurrentCity:str];
    NSLog(@"当前城市=%@",[[DataSource getInstance] getcurrentCity]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imooccityselect" object:nil];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
