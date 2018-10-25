//
//  ViewController.m
//  RacMVVM
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "PersonViewModel.h"

@interface ViewController ()
@property(nonatomic,strong)PersonViewModel *personViewModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdataLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //问题：谁来给Model赋值，是VC吗？还是View-Model？
    //问题：如果给Person赋值的是View-Model，那么他自己怎么发起请求，是由VC驱动的发起请求的吗？
    //问题：如果给Person赋值的是VC，那就没错了，但是怎么可能起到减少代码呢？
    //问题：难道是Model自己给自己赋值的吗？自己发起的请求？holy，shit？
    Person *person=[[Person alloc] initwithSalutation:@"你好" firstName:@"Kang" lastName:@"Jiyoung" birthdate:[NSDate date]];
    
    self.personViewModel=[[PersonViewModel alloc] initWithPerson:person];
    self.nameLabel.text = self.personViewModel.nameText;
    self.birthdataLabel.text = self.personViewModel.birthdateText;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
