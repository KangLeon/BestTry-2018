//
//  ViewController.h
//  SDWebImage
//
//  Created by jitengjiao      on 2018/3/14.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *myTabelView;//声明数据视图
@property(strong,nonatomic)NSMutableArray *myArrayData;//声明数据源对象
@property(strong,nonatomic)UIBarButtonItem *myLoadDataButton;//加载视图button
@property(strong,nonatomic)UIBarButtonItem *myEditButton;//编辑button

@end

