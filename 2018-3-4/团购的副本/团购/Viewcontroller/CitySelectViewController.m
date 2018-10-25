//
//  CitySelectViewController.m
//  团购
//
//  Created by jitengjiao      on 2018/2/21.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "CitySelectViewController.h"
#import "Util.h"
#import "MyDataSourse.h"

@interface CitySelectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *indexArray;
    NSMutableArray *cityArray;
    UITableView *tableView;
    NSMutableArray *sortedArray;
}
@end

@implementation CitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"cityList.plist" ofType:nil];
    NSDictionary *cityDictionary=[NSDictionary dictionaryWithContentsOfFile:path];
    
    cityArray=[[NSMutableArray alloc] init];
    sortedArray=[[NSMutableArray alloc] init];
    for (NSString  *keys in cityDictionary.allKeys) {
        [sortedArray addObject:keys];
    }
    
    [sortedArray sortUsingSelector:@selector(compare:)];
    
    for (NSString *cityKey in sortedArray) {
        [cityArray addObject:[cityDictionary objectForKey:cityKey]];
    }
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    [self.view addSubview:tableView];
    
    tableView.dataSource=self;
    tableView.delegate=self;
    
    indexArray=[[NSMutableArray alloc] init];
    for (NSMutableArray *array in cityArray) {
        [indexArray addObject:array];//现在的数组虽然正确但是缺少排序
    }
    
    UIView *view_tbHead=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    UILabel *lab_hotCity=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20, 5)];
    lab_hotCity.text=@"热门城市";
    lab_hotCity.font=[UIFont systemFontOfSize:12.0];
    lab_hotCity.textAlignment=NSTextAlignmentLeft;
    [view_tbHead addSubview:lab_hotCity];
    
    NSArray *array_hotCity=@[@"北京",@"上海",@"广州",@"深圳",@"杭州",@"重庆"];
    //热门城市本来是一个个button，但是这里不实现功能的话，就是简单的添加label，不添加button了，
    for (int i=0; i<6; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20+(i%3)*(SCREEN_WIDTH/3-10), (i/3)*40+15, SCREEN_WIDTH/3-20, 35)];
        NSString *cityName=[array_hotCity objectAtIndex:i];
        label.text=cityName;
        label.font=[UIFont systemFontOfSize:18.0];
        label.textAlignment=NSTextAlignmentCenter;
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
    static NSString *cell_ID=@"tuangou";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_ID];
    }
    NSArray *cityNameArray=[cityArray objectAtIndex:indexPath.section];
    NSString *cityName=[cityNameArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=cityName;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str=[sortedArray objectAtIndex:section];
    return str;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return sortedArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cityNameArray=[cityArray objectAtIndex:indexPath.section];
    NSString *cityName=[cityNameArray objectAtIndex:indexPath.row];
    [MyDataSourse sharedMyDataSource].currentCityName=cityName;
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
