//
//  PreviewViewController.m
//  AlbumBrowser
//
//  Created by 吉腾蛟 on 2018/7/27.
//  Copyright © 2018年 mj. All rights reserved.
//

#import "PreviewViewController.h"
#import <Photos/Photos.h>

@interface PreviewViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@property(nonatomic,assign) CGFloat finalPinchScale;//最终照片的比例

@property(nonatomic,assign)CGFloat finalRotationAngle;//最终旋转的角度

@property(nonatomic,assign)CGPoint finalPanTranslation;//最终照片平移的位置
@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"预览照片";
    [self updateImageP];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selrctPhoto)]];
    
    [self addGesture];
    
    self.finalPinchScale=1;
}

-(void)addGesture{
    //添加长按手势
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.previewImageView addGestureRecognizer:longPressGesture];
    
    UISwipeGestureRecognizer *right_swipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    right_swipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.previewImageView addGestureRecognizer:right_swipeGesture];
    
    UISwipeGestureRecognizer *left_swipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    left_swipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.previewImageView addGestureRecognizer:left_swipeGesture];
    
    //添加缩放手势
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    pinchGesture.delegate=self;
    [self.previewImageView addGestureRecognizer:pinchGesture];
    
    //添加旋转手势
    UIRotationGestureRecognizer *rotateGesture=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateGesture:)];
    rotateGesture.delegate=self;
    [self.previewImageView addGestureRecognizer:rotateGesture];
    
    //添加滑动手势
    UIPanGestureRecognizer *panGesTure=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesTure:)];
    panGesTure.minimumNumberOfTouches=2;//设置最少操作手指数为2，防止与轻扫操作冲突
    panGesTure.delegate=self;
    [self.previewImageView addGestureRecognizer:panGesTure];
    
    //天际屏幕边缘滑动手势
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture=[[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenedgePanGesture:)];
    screenEdgePanGesture.edges=UIRectEdgeRight;//设置屏幕边缘滑动手势触发的边缘为右侧
    
    [self.previewImageView addGestureRecognizer:screenEdgePanGesture];
}

-(void)selrctPhoto{
    if (self.photoAssetsArray.count>self.photoIndex) {
        PHAsset *asset=self.photoAssetsArray[self.photoIndex];
        //将asset实例传递给入口页面
        //这里是三个页面，所以不适合用代理，所以用通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoSelectedNotification" object:asset];
        
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

-(void)updateImageP{
    __weak typeof(self) weakSelf=self;
    
    if (self.photoAssetsArray.count>self.photoIndex) {
        PHAsset *asset=self.photoAssetsArray[self.photoIndex];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.previewImageView.bounds.size contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                weakSelf.previewImageView.image=result;
            }
        }];
    }
    
   
}

-(void)longPress:(UILongPressGestureRecognizer*)sender{
    NSString *message=[NSString stringWithFormat:@"%.1f x %.1f",self.previewImageView.image.size.width,self.previewImageView.image.size.height];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"照片尺寸" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)swipe:(UISwipeGestureRecognizer *)sender{
    //对手势方向进行一次判断
    if (sender.direction==UISwipeGestureRecognizerDirectionRight) {
        //向右轻扫
        self.photoIndex--;
        if (self.photoIndex<0) {
            self.photoIndex=0;
        }
        [self updateImageP];
    }else if (sender.direction==UISwipeGestureRecognizerDirectionLeft){
        //向左轻扫
        self.photoIndex++;
        if (self.photoIndex>=self.photoAssetsArray.count) {
            self.photoIndex=self.photoAssetsArray.count-1;
        }
        [self updateImageP];
    }
}

-(void)pinchGesture:(UIPinchGestureRecognizer*)sender{
    static CGFloat lastPinchScale=1;//上一次缩放比例，加了static关键字就可以随意的更改，
    CGFloat currentPinchScale=sender.scale;//当前缩放比例

    NSLog(@"Pinch Scale : %f",currentPinchScale);;
    if (sender.state==UIGestureRecognizerStateChanged) {
        //改变照片的缩放比例
        self.finalPinchScale=lastPinchScale*currentPinchScale;
        //将finalPinchScale应用在照片上
        [self applyTransformForImage];
    }else if (sender.state==UIGestureRecognizerStateEnded){
        //更新lastPinchScale的树枝到本次的缩放比例
        lastPinchScale=lastPinchScale*currentPinchScale;
    }
}

//旋转照片
-(void)rotateGesture:(UIRotationGestureRecognizer*)sender{
    static CGFloat lastRotationAngle=0;//上一次旋转的jiaodu
    CGFloat currentRotationAngle=sender.rotation;//当前旋转的角度
    NSLog(@"Rotation Angle:");
    if (sender.state==UIGestureRecognizerStateChanged) {
        //更新照片旋转的角度
        self.finalRotationAngle=lastRotationAngle+currentRotationAngle;
        //将finalRotationAngle应用在照片上
        [self applyTransformForImage];
    }else if (sender.state==UIGestureRecognizerStateEnded){
        //更新lastRotationAngle的树枝到本次的旋转角度
        lastRotationAngle=lastRotationAngle+currentRotationAngle;
    }
}

//照片变换方法
-(void)applyTransformForImage{
    //生成缩放变换形态
    //方法参数1:水平方向缩放比例
    //方法参数2:竖直方向缩放比例
    CGAffineTransform scaleTransform=CGAffineTransformMakeScale(self.finalPinchScale, self.finalPinchScale);
    CGAffineTransform rotationTransform=CGAffineTransformRotate(scaleTransform, self.finalRotationAngle);
    CGAffineTransform panTransform=CGAffineTransformTranslate(rotationTransform, self.finalPanTranslation.x, self.finalPanTranslation.y);
    self.previewImageView.transform=panTransform;
}

//照片平移的方法
-(void)panGesTure:(UIPanGestureRecognizer*)sender{
    static CGPoint lastTranslation={.x=0,.y=0};//上一次平移的位置
    CGPoint currentTranslation=[sender translationInView:self.previewImageView];//当前平移的位置
    if (sender.state==UIGestureRecognizerStateChanged) {
        _finalPanTranslation.x=lastTranslation.x+currentTranslation.x;//计算水平平移位置
        _finalPanTranslation.y=lastTranslation.y+currentTranslation.y;
        [self applyTransformForImage];
    }else if (sender.state==UIGestureRecognizerStateEnded){
        lastTranslation.x=lastTranslation.x+currentTranslation.x;
        lastTranslation.y=lastTranslation.y+currentTranslation.y;
    }
    
}

//屏幕边缘滑动手势触发方法，用于选择照片
-(void)screenedgePanGesture:(UIScreenEdgePanGestureRecognizer*)sender{
    if (sender.state==UIGestureRecognizerStateBegan) {
        [self selrctPhoto];//
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
