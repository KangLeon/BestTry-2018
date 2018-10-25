//
//  LocationSever.m
//  RestaurantMooc
//
//  Created by 吉腾蛟 on 2018/8/8.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "LocationSever.h"
#import "DataSource.h"
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>

@interface LocationSever ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}


@end

@implementation LocationSever
+(instancetype)getnstance{
    static LocationSever *locationServer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationServer=[[LocationSever alloc] init];
        [locationServer addInit];
    });
    return locationServer;
}
-(void)addInit{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
}
-(void)startLocationServer{
    [locationManager startUpdatingLocation];
    
}
-(void)stopLocationServer{
    [locationManager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location=[locations lastObject];
    NSString *lat=[NSString stringWithFormat:@"%3.5f",location.coordinate.latitude];
    NSString *lon=[NSString stringWithFormat:@"%3.5f",location.coordinate.longitude];
    NSString *alt=[NSString stringWithFormat:@"%3.5f",location.altitude];
    
    float lonf=labs(lon.floatValue);
    //1.write 2SDK
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    CLLocation *loc=[[CLLocation alloc] initWithLatitude:39.92 longitude:116.46];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *place=placemarks[0];
            NSDictionary *address=place.addressDictionary;
            NSString *city=[address valueForKey:@"city"];
            if ([city isEqualToString:@"Beijing"]) {
                [[DataSource getInstance] setcurrentCity:@"北京"];
            }else{
                [[DataSource getInstance] setcurrentCity:@"中国"];
            }
        }
    }];
}
@end
