//
//  PushHandler.m
//  PushTest
//
//  Created by jitengjiao      on 2018/3/18.
//  Copyright © 2018年 MJ. All rights reserved.
//

#import "PushHandler.h"
#import "DiaryControllerViewController.h"

@implementation PushHandler

+(instancetype)sharedInstance{
    static PushHandler *pushHandler=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushHandler=[[PushHandler alloc] init];
    });
    return pushHandler;
}
-(void)handlePush:(NSDictionary*)dic{
    //t：表示操作类型  p：表示操作参数
    //"t":"jump" "p":"diary"
    NSDictionary *custom=[[dic objectForKey:@"aps"] objectForKey:@"custom"];
    
    NSString *t=[custom objectForKey:@"t"];
    NSString *p=[custom objectForKey:@"p"];
    if ([t isEqualToString:@"jump"]&&[p isEqualToString:@"diary"]) {
        DiaryControllerViewController* diaryVC=[[DiaryControllerViewController alloc] init];
        [self.baseViewController presentViewController:diaryVC animated:true completion:nil];
    }
    
}

@end
