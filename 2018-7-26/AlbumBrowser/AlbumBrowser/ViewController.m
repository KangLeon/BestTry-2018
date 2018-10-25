//
//  ViewController.m
//  AlbumBrowser
//
//  Created by 吉腾蛟 on 2018/7/26.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "MyCollectionViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [self.myImageView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoSelected:) name:@"PhotoSelectedNotification" object:nil];
}

-(void)selectPhoto:(UITapGestureRecognizer*)sender{
    NSLog(@"选择照片");
    [self loadPhotoAssets];
}

-(void)loadPhotoAssets{
    PHAuthorizationStatus status=[PHPhotoLibrary authorizationStatus];
    if (status==PHAuthorizationStatusNotDetermined) {//如果是为定义的话
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status==PHAuthorizationStatusAuthorized) {
                //有权限读取照片
                [self performLoadPhotoAssets];
            }
        }];
    }else if (status==PHAuthorizationStatusAuthorized){//如果是授权的话
        //有权读取照片
        [self performLoadPhotoAssets];
    }
}
-(void)performLoadPhotoAssets{
    //读取照片
    NSMutableArray *assetsArray=[NSMutableArray array];//存储读取到的照片
    PHFetchOptions *options=[[PHFetchOptions alloc] init];//加载照片的选项
    options.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];//选项排序方法
    
    PHFetchResult *fetchResult=[PHAsset fetchAssetsWithOptions:options];//获取结果
    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {//枚举获取结果
        [assetsArray addObject:obj];//将对象存在数组中
    }];
    NSLog(@"%lu",(unsigned long)assetsArray.count);
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(100, 100);
    CGFloat space=(self.view.bounds.size.width-4*100)/5;
    if (space<5) {
        space=5;
    }
    layout.minimumInteritemSpacing=space;
    layout.minimumLineSpacing=15;
    layout.sectionInset=UIEdgeInsetsMake(15, space, 15, space);
    
    MyCollectionViewController *myCollectionVC=[[MyCollectionViewController alloc] initWithCollectionViewLayout:layout];
    myCollectionVC.assetsArray=[assetsArray copy];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:myCollectionVC];
    [self presentViewController:nav animated:true completion:^{
        
    }];
}

-(void)photoSelected:(NSNotification *)noti{
    NSLog(@"接收到了通知");
    PHAsset *asset=noti.object;
    if (asset) {
        
        __weak typeof(self) weakSelf=self;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.myImageView.bounds.size contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                weakSelf.myImageView.image=result;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
