//
//  LoginNibViewController.m
//  Shout
//
//  Created by zhousl on 14-9-10.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "LoginNibViewController.h"
#import "LoginModel.h"

@interface LoginNibViewController ()
{
    IBOutlet UITextField* tfNumber;
    IBOutlet UITextField* tfPw;
    
    IBOutlet UIButton* btnRegister;
    IBOutlet UIButton* btnLogin;
    
    IBOutlet UIImageView* ivInputBg;
}
@end

@implementation LoginNibViewController

- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.strNavTitle = @"登陆界面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBg :(id)sender{
    
    [tfNumber resignFirstResponder];
    [tfPw resignFirstResponder];
}

- (IBAction)btnRegisterClick:(id)sender{
    
}


- (IBAction)btnLoginClick:(id)sender{
    if (!ISEXISTSTR(tfNumber.text)) {
        [BLTipView showWithTitle:@"手机号不能为空"];
        return;
    }
    
    if (!ISEXISTSTR(tfPw.text)) {
        [BLTipView showWithTitle:@"密码不能为空"];
        return;
    }
    
    [[LoginModel sharedInstance]loginWithMemberTel:tfNumber.text password:tfPw.text resultBlock:^(NSString *errorStr) {
        if (nil == errorStr) {
            NSLog(@"login successful");
        }else{
            [BLTipView showWithTitle:errorStr];
        }
    }];
}

@end
