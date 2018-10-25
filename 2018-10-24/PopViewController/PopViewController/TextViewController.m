//
//  TextViewController.m
//  PopViewController
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *text_view;
@property (weak, nonatomic) IBOutlet UIButton *text_button;
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.confirm_button.hidden=YES;
    self.textField.hidden=YES;
    
    self.text_view.layer.cornerRadius=12.0;
}

- (IBAction)text_something:(id)sender {
}
- (IBAction)confirm_something:(id)sender {
}
- (IBAction)textfiledChange:(id)sender {
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
