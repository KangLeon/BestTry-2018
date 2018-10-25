//
//  MyCollectionViewController.m
//  AlbumBrowser
//
//  Created by 吉腾蛟 on 2018/7/26.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "PreviewViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"选择照片";
    self.collectionView.backgroundColor=[UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   
    PHAsset *asset=self.assetsArray[indexPath.row];
    cell.asset=asset;
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    NSLog(@"点击了第%ld张照片",row+1);
    
    PreviewViewController *previewVC=[[PreviewViewController alloc] init];
    previewVC.photoAssetsArray=self.assetsArray;
    previewVC.photoIndex=row;
    [self.navigationController pushViewController:previewVC animated:true];
}


@end
