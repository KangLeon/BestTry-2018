//
//  MyCollectionViewCell.m
//  AlbumBrowser
//
//  Created by 吉腾蛟 on 2018/7/26.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <Photos/Photos.h>

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImgaView;


@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setAsset:(PHAsset *)asset{
    _asset=asset;
    __weak typeof(self) weakSelf=self;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.myImgaView.bounds.size contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            weakSelf.myImgaView.image=result;
        }
    }];
}

@end
