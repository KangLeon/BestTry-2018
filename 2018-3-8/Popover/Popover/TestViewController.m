//
//  TestViewController.m
//  Popover
//
//  Created by jitengjiao      on 2018/3/8.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "TestViewController.h"
#import "JumpViewController.h"


@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *myTableView;
@property(copy,nonatomic)NSArray *myArray;
@property(strong,nonatomic)JumpViewController *jump_vc;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, 250)];
    _myTableView.dataSource=self;
    _myTableView.delegate=self;
    _myTableView.backgroundColor=MYGRAYCOLOR;
    _myTableView.scrollEnabled=false;
    [self.view addSubview:_myTableView];
    _myArray=[[NSArray alloc] initWithObjects:@"发起群聊", @"添加朋友",@"扫一扫",@"收付款",nil];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id=@"mycell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text=[_myArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *mystring=[_myArray objectAtIndex:indexPath.row];
    NSLog(@"%@",mystring);
    //这种方法虽然可以，但是有点稍微的卡卡的，不流畅（原来是模拟器的运行速度慢，真机上很溜）
    [self dismissViewControllerAnimated:false completion:^{
        if (_jump_vc==nil) {
            _jump_vc=[[JumpViewController alloc] init];
        }
        if ([mystring isEqualToString:@"发起群聊"]) {
            if ([self.delegate respondsToSelector:@selector(getMyString:)]) {
                [self.delegate getMyString:mystring];//虽然值可以传过去，但是还是卡卡的，一点都不流畅（原来是模拟器的运行速度慢，真机上很溜）
            }
        }
    }];
}

//重写preferredContentSize（iOS7之后）来返回最合适的大小，如果不重写，会返回一整个tableview尽管下面一部分cell是没有内容的，重写后只会返回有内容的部分，我这里还修改了宽，让它窄一点。可以尝试注释这一部分的代码来看效果，通过修改返回的size得到你期望的popover的大小。
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.myTableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
        //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        CGSize size = [self.myTableView sizeThatFits:tempSize];
        return size;
    }else {
        return [super preferredContentSize];
    }
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize{
    super.preferredContentSize = preferredContentSize;
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
