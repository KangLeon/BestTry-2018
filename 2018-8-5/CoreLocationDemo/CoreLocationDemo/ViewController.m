//
//  ViewController.m
//  CoreLocationDemo
//
//  Created by 吉腾蛟 on 2018/8/5.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *reginLabel;
@property (weak, nonatomic) IBOutlet UILabel *loactionName;

@property(nonatomic,strong)CLGeocoder *geoCoder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configLocationManager];
}

-(void)configLocationManager{
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;//设置定位精度,这个根据需求设定，精度越高越费电
    
    //设置通知的过滤值
    self.locationManager.distanceFilter=5;//米为单位
    self.locationManager.headingFilter=2;//角度过滤值
    
    //请求权限
    [self.locationManager requestAlwaysAuthorization];
    
    //更新定位
    [self.locationManager startUpdatingLocation];//开始更新定位
    [self.locationManager startUpdatingHeading];//开始更新方向
    
    //地理围栏
    CLLocationCoordinate2D reginCenter=CLLocationCoordinate2DMake(37.337, -122.035);
    CLCircularRegion *circleRegion=[[CLCircularRegion alloc] initWithCenter:reginCenter radius:500 identifier:@"苹果总部"];
    [self.locationManager requestStateForRegion:circleRegion];//询问现在的位置是否在区域中
    [self.locationManager startMonitoringForRegion:circleRegion];//检查位置在区域中的变换
    
    //地理编码与反编码
    self.geoCoder=[[CLGeocoder alloc] init];
}

//更新定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location=[locations firstObject];
    self.longitudeLabel.text=[NSString stringWithFormat:@"经度：%.6f",location.coordinate.longitude];
    self.latitudeLabel.text=[NSString stringWithFormat:@"纬度：%.6f",location.coordinate.latitude];
    self.altitudeLabel.text=[NSString stringWithFormat:@"海拔：%.6f",location.altitude];
    
    NSLog(@"速度：%.2f",location.speed);       
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            self.loactionName.text=@"反编码错误";
        }else{
            CLPlacemark *plcae=placemarks.firstObject;
            self.loactionName.text=plcae.name;
        }
    }];
}

//更新方向
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    self.headingLabel.text=[NSString stringWithFormat:@"方向：%.6f",newHeading.trueHeading];
}

//获取错误
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }else if (error.code==kCLErrorLocationUnknown){
        NSLog(@"获取位置信息失败");
    }else{
        NSLog(@"定位失败");
    }
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    //进入区域
    self.reginLabel.text=[NSString stringWithFormat:@"进入：%@",region.identifier];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    //离开区域
    self.reginLabel.text=[NSString stringWithFormat:@"离开：%@",region.identifier];
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if (state==CLRegionStateUnknown) {
        self.reginLabel.text=[NSString stringWithFormat:@"未知:%@",region.identifier];
    }else if (state==CLRegionStateInside){
        self.reginLabel.text=[NSString stringWithFormat:@"进入:%@",region.identifier];
    }else{
        self.reginLabel.text=[NSString stringWithFormat:@"离开:%@",region.identifier];
    }
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    self.reginLabel.text=[NSString stringWithFormat:@"观察失败:%@",region.identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
