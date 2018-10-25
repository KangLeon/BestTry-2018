//
//  BookModel.h
//  SDWebImage
//
//  Created by jitengjiao      on 2018/3/14.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject


@property(strong,nonatomic)NSString *mBookName;//书名
@property(strong,nonatomic)NSString *mBookPrice;//图书价格
@property(strong,nonatomic)NSString *mBookPublisher;//出版社
@property(strong,nonatomic)NSString *mImageURL;//图片地址

@end
