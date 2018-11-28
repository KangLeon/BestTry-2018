//
//  ViewController.m
//  MasonryAnimation
//
//  Created by admin on 2018/11/27.
//  Copyright © 2018 JY. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "SecondViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIView *first_view;
@property(nonatomic,strong)UIButton *animation_button;
@property(nonatomic,strong)UIButton *push_button;
@property(nonatomic,assign)BOOL topLeft;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.first_view];
    [self.view addSubview:self.animation_button];
    [self.view addSubview:self.push_button];
    
    [self.view updateConstraintsIfNeeded];//这个是立即更新
    /*updateConstraintsIfNeeded
     更新视图和它的子视图的约束。
     每当一个新的布局，通过触发一个视图，系统调用此方法以确保视图和其子视图的任何约束与当前视图层次结构和约束信息更新。这种方法被系统自动调用，但如果需要检查最新的约束条件，可以手动调用这个方法。
     子类不应重写此方法。
     
     注解：立即出发约束更新。
     */
}

//requiresConstraintBasedLayout ：我们应该在自定义View中重写这个方法。如果我们要使用Auto Layout布局当前视图，应该设置为返回YES。
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

-(UIView *)first_view{
    if (!_first_view) {
        _first_view=[[UIView alloc] init];
        _first_view.backgroundColor=[UIColor grayColor];
    }
    return _first_view;
}
-(UIButton *)animation_button{
    if (!_animation_button) {
        _animation_button=[[UIButton alloc] init];
        [_animation_button addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [_animation_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_animation_button setTitle:@"美少女变身" forState:UIControlStateNormal];
    }
    return _animation_button;
}
-(UIButton *)push_button{
    if (!_push_button) {
        _push_button=[[UIButton alloc] init];
        [_push_button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [_push_button setTitle:@"去吧，皮卡丘" forState:UIControlStateNormal];
        [_push_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _push_button;
}

/*updateViewConstraints
 更新视图的约束。
 
 自定义视图应该通过重写此方法来设置自己的约束。当你的自定义视图有某个约束发生了变化或失效了，应该立即删除这个约束，然后调用setNeedsUpdateConstraints标记约束需要更新。系统在进行布局layout之前，会调用updateConstraints，让你确认（设置）在视图的属性不变时的必要约束。在更新约束阶段你不应该使任何一个约束失效，而且不能让layerout和drawing作为更新约束的一部分。
 在View中是重写updateConstraints方法，在ViewController中是重写updateViewConstraints，
 
 重要提示：要在实现的最后调用[super updateConstraints]。

 */
-(void)updateViewConstraints{
    [super updateViewConstraints];
    [self.animation_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(300);
        make.left.equalTo(self.view.mas_left).offset(80);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(60);
    }];
    [self.push_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(380);
        make.left.equalTo(self.view.mas_left).offset(80);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(60);
    }];
    if (self.topLeft) {
        [self.first_view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(80);
            make.left.equalTo(self.view.mas_left).offset(80);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(160);
        }];
        
    }else{
        [self.first_view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(80);
            make.left.equalTo(self.view.mas_left).offset(80);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
    }
}

//触发动画
-(void)tapAction{
    
    // tell constraints they need updating
    [self.view setNeedsUpdateConstraints];//这个是标记将来在某个时间点进行更新

    // update constraints now so we can animate the change
    [self.view updateConstraintsIfNeeded];//这个是立即更新
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.topLeft=!self.topLeft;
}

-(void)pushAction{
    SecondViewController *second_VC=[[SecondViewController alloc] init];
    [self.navigationController pushViewController:second_VC animated:YES];
}

/*
 - (BOOL)needsUpdateConstraints
 
 这个很简单，返回是否需要更新约束。constraint-based layout system使用此返回值去决定是否需要调用updateConstraints作为正常布局过程的一部分。
 */

/*
 - (void)setNeedsUpdateConstraints
 
 控制视图的约束是否需要更新。
 当你的自定义视图的属性改变切影响到约束，你可以调用这个方法来标记未来的某一点上需要更新的约束。然后系统将调用updateConstraints。
 
 注解：这个方法和updateConstraintsIfNeeded关系有点暧昧，updateConstraintsIfNeeded是立即更新，二.这个方法是标记需要更新，然后系统决定更新时机。
 */

@end
