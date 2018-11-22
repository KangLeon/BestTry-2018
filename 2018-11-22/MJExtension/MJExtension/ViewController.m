//
//  ViewController.m
//  MJExtension
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import <MJExtension.h>
#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Student.h"
#import "Ad.h"
#import "Bag.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.简单的字典转模型
    NSDictionary *dict_user = @{
                                @"name" : @"Jack",
                                @"icon" : @"lufy.png",
                                @"age" : @20,
                                @"height" : @"1.55",
                                @"money" : @100.9,
                                @"sex" : @(SexFemale),/* 枚举需要使用NSNumber包装 */
                                @"gay" : @YES
                                };
    User *user_dic=[User mj_objectWithKeyValues:dict_user];
    NSLog(@"%@",user_dic);
    
    //2.Json字符串转模型
    NSString *jsonStr = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    User *user_json = [User mj_objectWithKeyValues:jsonStr];
    NSLog(@"MJ---%@----%@---%u",user_json.name,user_json.icon,user_json.age);
    
    //3.复杂的字典 --> 模型 (模型里面包含了模型)
    NSDictionary *dict_m8m = @{
                               @"text" : @"Agree!Nice weather!",
                               @"user" : @{
                                       @"name" : @"Jack",
                                       @"icon" : @"lufy.png"
                                       },
                               @"retweetedStatus" : @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       }
                               };
    //字典转模型，模型里面含有模型
    Status *status = [Status mj_objectWithKeyValues:dict_m8m];
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
    NSLog(@"mj-----text=%@, name=%@, icon=%@", text, name, icon);
    NSString *text2 = status.retweetedStatus.text;
    NSString *name2 = status.retweetedStatus.user.name;
    NSString *icon2 = status.retweetedStatus.user.icon;
    NSLog(@"mj-----text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
    
    //4.模型中有个数组属性，数组里面又要装着其它模型
    // Tell MJExtension what type of model will be contained in statuses and ads.
    [StatusResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"Status",
                 // @"statuses" : [Status class],
                 @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
    // Equals: StatusResult.m implements +mj_objectClassInArray method.
    
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };
    
    // JSON -> StatusResult
    StatusResult *result = [StatusResult mj_objectWithKeyValues:dict];
    
    NSLog(@"totalNumber=%@", result.totalNumber);
    // totalNumber=2014
    
    // Printing
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    // text=Nice weather!, name=Rose, icon=nami.png
    // text=Go camping tomorrow!, name=Jack, icon=lufy.png
    
    // Printing
    for (Ad *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
    // image=ad01.png, url=http://www.ad01.com
    // image=ad02.png, url=http://www.ad02.com

    //5.模型中的属性名和字典中的key不相同(或者需要多级映射)
    NSDictionary *dict_more = @{
                           @"id" : @"20",
                           @"desciption" : @"孩子",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @{
                                           @"nameChangedTime" : @"2013-08"
                                           }
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"小书包",
                                           @"price" : @100.7
                                           }
                                   }
                           };

    // 将字典转为Student模型
    Student *stu = [Student mj_objectWithKeyValues:dict_more];
    // 打印Student模型的属性
    NSLog(@"ID=%@, desc=%@, oldName=%@, nowName=%@, nameChangedTime=%@", stu.ID, stu.desc, stu.oldName, stu.nowName, stu.nameChangedTime);
    // ID=20, desc=孩子, oldName=kitty, nowName=lufy, nameChangedTime=2013-08
    NSLog(@"bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
    // bagName=小书包, bagPrice=100.700000

    //6.将一个字典数组转成模型数组
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png",
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png",
                               }
                           ];

    // 将字典数组转为User模型数组
    NSArray *userArray = [User mj_objectArrayWithKeyValuesArray:dictArray];
    // 打印userArray数组中的User模型属性
    for (User *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);}
    // name=Jack, icon=lufy.png
    // name=Rose, icon=nami.png
    
    //7.将一个模型转成字典
    //创建一个模型对象
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    Status *status_seven = [[Status alloc] init];
    status_seven.user = user;
    status_seven.text = @"Nice mood!";
    //模型转字典，使用的是mj_keyValues属性
    NSDictionary *statusDict = status_seven.mj_keyValues;
    NSLog(@"%@", statusDict);
    /*
     {
     text = "Nice mood!";
     user =     {
     icon = "lufy.png";
     name = Jack;
     };
     }
     */

    //8. 模型数组 --> 字典数组
    //创建模型数组
    User *user1 = [[User alloc] init];
    user1.name = @"Jack";
    user1.icon = @"lufy.png";
    User *user2 = [[User alloc] init];
    user2.name = @"Rose";
    user2.icon = @"nami.png";
    NSArray *userArray_eight = @[user1, user2];
    //模型数组转字典数组，使用的是mj_keyValuesArrayWithObjectArray:方法
    NSArray *dictArray_eight = [User mj_keyValuesArrayWithObjectArray:userArray_eight];
    NSLog(@"%@", dictArray_eight);
    /*
     (
     {
     icon = "lufy.png";
     name = Jack;
     },
     {
     icon = "nami.png";
     name = Rose;
     }
     )
     */
    
    //9.字典 --> CoreData模型
    NSDictionary *dict_coreData = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           };
    //字典转为CoreData模型
    NSManagedObjectContext *context = nil;
    User *user_coreData = [User mj_objectWithKeyValues:dict_coreData
                                      context:context];
    [context save:nil];
    
    //10.归档与解档
    //创建模型
    Bag *bag_encode = [[Bag alloc] init];
    bag_encode.name = @"Red bag";
    bag_encode.price = 200.8;
    //获取归档路径
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/bag.data"];
    //归档
    [NSKeyedArchiver archiveRootObject:bag_encode toFile:file];
    [NSKeyedArchiver archivedDataWithRootObject:bag_encode requiringSecureCoding:YES error:nil];
    //解档
    Bag *decodedBag = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSLog(@"name=%@, price=%f", decodedBag.name, decodedBag.price);
    // name=(null), price=200.800000
    
    //11.过滤字典的值
    NSDictionary *dict_filter = @{
                           @"name" : @"5分钟突破iOS开发",
                           @"publishedTime" : @"2011-09-10"
                           };
    //字典转模型，过滤name为nil的情况，把NSString转为NSDate
    Book *book_filter = [Book mj_objectWithKeyValues:dict_filter];
    //打印
    NSLog(@"name=%@, publishedTime=%@", book_filter.name, book_filter.publishedTime);
    // name=5分钟突破iOS开发, publishedTime=Sat Sep 10 00:00:00 2011
    
}


@end
