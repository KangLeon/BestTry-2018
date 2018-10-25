//
//  ViewController.m
//  MagniDemo
//
//  Created by 吉腾蛟 on 2018/8/6.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>

@interface ViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CLGeocoder *gecode=[[CLGeocoder alloc] init];
    
    //位置-》经纬度
    [gecode geocodeAddressString:@"上海" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *place=placemarks[0];
            CLLocationCoordinate2D mcoordinate=place.location.coordinate;
            NSString *str=[NSString stringWithFormat:@"3.5%f 3.5%f",mcoordinate.latitude,mcoordinate.longitude];
            NSLog(@"%@",str);
        }
    }];
}

-(void)loadMag{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    if ([locationManager headingAvailable]) {
        [locationManager startUpdatingHeading];
    }else{
        NSLog(@"磁力计不可用");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(nonnull CLHeading *)newHeading{
    
//    float x=newHeading.x;
//    float y=newHeading.y;
//    float z=newHeading.z;
//
//    NSLog(@"%f %f %f",x,y,z);
    
    //指南针功能
    if (newHeading.headingAccuracy>0) {
        float heading=-M_PI*newHeading.magneticHeading/180.0;//转换为弧度
        NSLog(@"%.2f",heading);
        self.imageView.transform=CGAffineTransformMakeRotation(heading);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
