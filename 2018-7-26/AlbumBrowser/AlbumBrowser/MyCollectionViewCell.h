//
//  MyCollectionViewCell.h
//  AlbumBrowser
//
//  Created by 吉腾蛟 on 2018/7/26.
//  Copyright © 2018年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;

@interface MyCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) PHAsset *asset;
@end
