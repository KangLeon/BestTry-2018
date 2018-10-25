//
//  ViewController.m
//  3DTouchDemo
//
//  Created by 吉腾蛟 on 2018/7/24.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *nextVCView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(strong,nonatomic)NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.nextVCView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextVC)]];
    [self registerForPreviewingWithDelegate:self sourceView:self.myTableView];
    [self registerForPreviewingWithDelegate:self sourceView:self.nextVCView];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    self.dataArray=@[@"Jodan",@"Kobe",@"James",@"Durant",@"Jones",@"Steven",@"IMac",@"IPhone",@"iPod",@"Apple"];
}

-(void)showNextVC{
    SecondViewController *secondVC=[[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (IBAction)add:(id)sender {
    
    //动态增加快捷启动选项
    UIApplicationShortcutItem *shortCutItem1=[[UIApplicationShortcutItem alloc] initWithType:@"dynamicOne" localizedTitle:@"动态快捷启动选项"];
    
    UIApplicationShortcutIcon *shortcutIcon=[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
    
    NSDictionary *userInfoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",nil];
    
    UIApplicationShortcutItem *shortCutItem2=[[UIApplicationShortcutItem alloc] initWithType:@"dynamicTwo" localizedTitle:@"动态快捷启动选项2" localizedSubtitle:@"使用代码创建" icon:shortcutIcon userInfo:userInfoDict];
    
    NSArray *shortCutItems=[[NSArray alloc] initWithObjects:shortCutItem1,shortCutItem2, nil];
    
    [[UIApplication sharedApplication] setShortcutItems:shortCutItems];
    
}
- (IBAction)delete:(id)sender {
    [[UIApplication sharedApplication] setShortcutItems:nil];
}

//pick功能
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    if (previewingContext.sourceView==self.nextVCView) {
        //重按了
        SecondViewController *secondVC=[[SecondViewController alloc] init];
        return secondVC;
    }else{
        //重按了tableView
        NSIndexPath *indexPath=[self.myTableView indexPathForRowAtPoint:location];
        if (indexPath) {
            //如果点击的cell不为空的时候
            UITableViewCell *cell=[self.myTableView cellForRowAtIndexPath:indexPath];
            previewingContext.sourceRect=cell.frame;
        }
        SecondViewController *secondVC=[[SecondViewController alloc] init];
        return secondVC;
    }
    return nil;
    
}


//pop功能
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text=[self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
