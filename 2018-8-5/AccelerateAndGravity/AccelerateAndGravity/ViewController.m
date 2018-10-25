//
//  ViewController.m
//  AccelerateAndGravity
//
//  Created by 吉腾蛟 on 2018/8/6.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController (){
    CMMotionManager *motionManager;
    
    UIAccelerationValue beforeX;
    UIAccelerationValue beforeY;
    UIAccelerationValue beforeZ;
}
@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UILabel *label_2;
@property (weak, nonatomic) IBOutlet UILabel *label_3;
@property (weak, nonatomic) IBOutlet UISlider *slider_1;
@property (weak, nonatomic) IBOutlet UISlider *slider_2;
@property (weak, nonatomic) IBOutlet UISlider *slider_3;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self proxiTest];
}

-(void)proxiTest{
    UIDevice *device=[UIDevice currentDevice];
    
    BOOL flag=device.isProximityMonitoringEnabled;
    if (!flag) {
        device.proximityMonitoringEnabled=true;
    }
    BOOL proState=device.proximityState;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceProStateChange) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)deviceProStateChange{
    UIDevice *device=[UIDevice currentDevice];
    if (device.proximityState==0) {
        NSLog(@"手机远离中");
    }else if (device.proximityState==1){
        NSLog(@"手机接近中");
    }
}


-(void)batteryMonitor{
    UIDevice *currentdevice=[UIDevice currentDevice];
    BOOL flag=currentdevice.isBatteryMonitoringEnabled;
    currentdevice.batteryMonitoringEnabled=true;
    //电池状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceBatteryDidChange) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    UIDeviceBatteryState batteryState=currentdevice.batteryState;
    
//    UIDeviceBatteryStateUnknown,
//    UIDeviceBatteryStateUnplugged,   // on battery, discharging
//    UIDeviceBatteryStateCharging,    // plugged in, less than 100%
//    UIDeviceBatteryStateFull,        // plugged in, at 100%
    
    //电量等级
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceBatteryLevelDidChange) name:@"UIDeviceBatteryLevelStateDidChangeNotification" object:nil];
    float battaryLevel=currentdevice.batteryLevel;
    //0没电 1.0充满 0.5一半电量
}

-(void)deviceBatteryLevelDidChange{
    UIDevice *currentDevice=[UIDevice currentDevice];
    float batteryLevel=currentDevice.batteryLevel;
    
    self.batteryLabel.text=[NSString stringWithFormat:@".2f",batteryLevel];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"触摸开始");
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"触摸移动");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"触摸结束");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"触摸取消");
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"运动开始");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"运动结束 ");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"运动取消");
}

-(void)orientation{
    //通过广播快速检测手机方向,这种方法必须得手机屏幕锁打开
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceMonitor) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //remove end
}

-(void)deviceMonitor{
    NSLog(@"变化了");
}

-(void)gyroTest{
    motionManager=[[CMMotionManager alloc] init];
    motionManager.gyroUpdateInterval=0.5;
    if (motionManager.isGyroAvailable==true) {
        [motionManager startGyroUpdates];
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (error) {
                [self->motionManager stopGyroUpdates];
            }else{
                float x_f=gyroData.rotationRate.x;
                float y_f=gyroData.rotationRate.y;
                float z_f=gyroData.rotationRate.z;
                
                self.label_1.text=[NSString stringWithFormat:@"x:%.3f",x_f];
                self.label_2.text=[NSString stringWithFormat:@"y:%.3f",y_f];
                self.label_3.text=[NSString stringWithFormat:@"z:%.3f",z_f];
                
                self.slider_1.value=fabsf(x_f);
                self.slider_2.value=fabsf(y_f);
                self.slider_3.value=fabsf(z_f);
                
                //角度计算
                float a=fabs(atanf(y_f/x_f)*180/M_PI);
                //                NSLog(@"%f",a);
                
                //低通滤波(保留信号的敏感程度)。 高通滤波（保留信号的非敏感程度）
                CGFloat lowPassX=(x_f*0.1)+(self->beforeX*0.9);
                CGFloat lowPassY=(y_f*0.1)+(self->beforeY*0.9);
                CGFloat lowPassZ=(z_f*0.1)+(self->beforeZ*0.9);
                
                self->beforeX=lowPassX;
                self->beforeY=lowPassY;
                self->beforeZ=lowPassZ;
                
                NSLog(@"x:%.3f y:%.3f z:%.3f",x_f,y_f,z_f);
                NSLog(@"bx:%.3f by:%.3f bz:%.3f",lowPassX,lowPassY,lowPassZ);
            }
        }];
    }
}

-(void)motionTest{
    motionManager=[[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval=0.5;
    if (motionManager.isAccelerometerAvailable==true) {
        [motionManager startAccelerometerUpdates];
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (error) {
                [self->motionManager stopAccelerometerUpdates];
            }else{
                float x_f=accelerometerData.acceleration.x;
                float y_f=accelerometerData.acceleration.y;
                float z_f=accelerometerData.acceleration.z;
                
                self.label_1.text=[NSString stringWithFormat:@"x:%.3f",x_f];
                self.label_2.text=[NSString stringWithFormat:@"y:%.3f",y_f];
                self.label_3.text=[NSString stringWithFormat:@"z:%.3f",z_f];
                
                self.slider_1.value=fabsf(x_f);
                self.slider_2.value=fabsf(y_f);
                self.slider_3.value=fabsf(z_f);
                
                //角度计算
                float a=fabs(atanf(y_f/x_f)*180/M_PI);
                //                NSLog(@"%f",a);
                
                //低通滤波(保留信号的敏感程度)。 高通滤波（保留信号的非敏感程度）
                CGFloat lowPassX=(x_f*0.1)+(self->beforeX*0.9);
                CGFloat lowPassY=(y_f*0.1)+(self->beforeY*0.9);
                CGFloat lowPassZ=(z_f*0.1)+(self->beforeZ*0.9);
                
                self->beforeX=lowPassX;
                self->beforeY=lowPassY;
                self->beforeZ=lowPassZ;
                
                NSLog(@"x:%.3f y:%.3f z:%.3f",x_f,y_f,z_f);
                NSLog(@"bx:%.3f by:%.3f bz:%.3f",lowPassX,lowPassY,lowPassZ);
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
