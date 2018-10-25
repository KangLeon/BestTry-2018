//
//  ViewController.m
//  SDWebImage
//
//  Created by jitengjiao      on 2018/3/14.
//  Copyright © 2018年 MJ. All rights reserved.
//

//该实例即有AFNetworking也有SDWebImage

#import "ViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "BookModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationController.title=@"你好啊";//这种方法给添加标题是无法的显示的，错的
    self.navigationItem.title=@"加载网络视图Demo";
//    self.title=@"你好啊";//这种优先级是最高的，
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    self.myTabelView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.myTabelView.delegate=self;
    self.myTabelView.dataSource=self;
    
    //自动调整视图的大小属性
    self.myTabelView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.myTabelView];
    
    //数据
    self.myArrayData=[[NSMutableArray alloc] init];
    
    
    //加载按钮的初始化
    
    self.myLoadDataButton=[[UIBarButtonItem alloc] initWithTitle:@"加载" style:UIBarButtonItemStylePlain target:self action:@selector(loadArrData)];
    
    self.navigationItem.rightBarButtonItem=self.myLoadDataButton;
    
}
-(void)loadArrData{
    //每次点击加载新的数据
//    static int i=0;
//
//    for (int j=0; j<4; i++,j++) {
//        NSString *str=[NSString stringWithFormat:@"数据%d",i+1];
//        [self.myArrayData addObject:str];
//    }
    
    
    [self loadDataFromNet];
}

//下载数据
-(void)loadDataFromNet{
    AFHTTPSessionManager *sessionMana=[AFHTTPSessionManager manager];
    
    NSArray *arrayG=[NSArray arrayWithObjects:@"IOS",@"PHP",@"AI", nil];
    
    static int counter=0;
    
    NSString *path=[NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1",arrayG[counter]];
    
    counter++;
    
    if (counter>=3) {
        counter=0;
    }
    
    //下载网络数据
    [sessionMana GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"dic=%@",responseObject);
        
            //解析数据
            [self parseData:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
}

//解析数据函数
-(void)parseData:(NSDictionary *)dicData{
    //()表示数组
    NSArray *arrEntry=[dicData objectForKey:@"entry"];
    for (NSDictionary* dicBook in arrEntry) {
        NSDictionary *dicTitle=[dicBook objectForKey:@"title"];
        
        NSString *strTitle=[dicTitle objectForKey:@"$t"];
        
        BookModel *bModel=[[BookModel alloc] init];
        
        //获得书籍名字
        bModel.mBookName=strTitle;
        
        NSArray *arrLink=[dicBook objectForKey:@"link"];
        
        for (NSDictionary *dicLink in arrLink) {
            NSString *strValue=[dicLink objectForKey:@"@rel"];
            
            NSLog(@"%@",[dicLink objectForKey:@"@rel"]);
            
            if ([strValue isEqualToString:@"image"]) {
                bModel.mImageURL=[dicLink objectForKey:@"@href"];
                NSLog(@"%@",bModel.mImageURL);
            }
        }
        
        [_myArrayData addObject:bModel];
    }
    [self.myTabelView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myArrayData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id=@"my_cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    BookModel *bModel=_myArrayData[indexPath.row];
    cell.textLabel.text=bModel.mBookName;
    
    //使用webImage来加载网络图片
    NSLog(@"%@",[NSURL URLWithString:bModel.mImageURL]);
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:bModel.mImageURL] placeholderImage:[UIImage imageNamed:@"书.png"]];
    
    return cell;
}


//该方法存为类别后使用比较方便

//- setItem:(CustomItem *)item
//{
//    _item = item;
//
//    // 占位图片
//    UIImage *placeholder = [UIImage imageNamed:@"placeholderImage"];
//
//    // 从内存\沙盒缓存中获得原图
//    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.originalImage];
//    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//    } else { // 内存\沙盒缓存没有原图
//        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
//            [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
//            //     用户的配置项假设利用NSUserDefaults存储到了沙盒中
//            //    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
//            //    [[NSUserDefaults standardUserDefaults] synchronize];
//#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
//            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
//            if (alwaysDownloadOriginalImage) { // 下载原图
//                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//            } else { // 下载小图
//                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
//            }
//        } else { // 没有网络
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.thumbnailImage];
//            if (thumbnailImage) { // 内存\沙盒缓存中有小图
//                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
//            } else {
//                [self.imageView sd_setImageWithURL:nil placeholderImage:placeholder];
//            }
//        }
//    }
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
