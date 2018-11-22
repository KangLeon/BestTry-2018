//
//  UIScrollView+MJRefreshNoPage.h
//  MJRefresh
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(NSInteger pageIndex);
typedef void(^LoadMoreBlock)(NSInteger pageIndex);

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJRefreshNoPage)
/**页码*/
@property (assign, nonatomic) NSInteger pageIndex;
/**下拉时候触发的block*/
@property (nonatomic, copy) RefreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic, copy) LoadMoreBlock loadMoreBlock;

- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock;
- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock;
@end

NS_ASSUME_NONNULL_END
