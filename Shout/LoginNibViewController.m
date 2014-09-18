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
        self.bShowNav = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden = YES;
    
    if ([[LoginModel sharedInstance] memberId]
        && [[LoginModel sharedInstance] memberTel]) {
        [[PublicFunction appDelegate] performSelector:@selector(goMainViewController) withObject:nil afterDelay:0.1];
    }
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

-(IBAction)clickButton :(UIButton*)sender{
    if (331 ==sender.tag ) {
        // qq
    }
    else if(332 == sender.tag){
        // weibo
    }
}

- (BOOL)conditionsCheck{
    BOOL result = YES;
    
    if (!ISEXISTSTR(tfNumber.text)) {
        [BLTipView showWithTitle:@"手机号不能为空"];
        return NO;
    }
    
    if (!ISEXISTSTR(tfPw.text)) {
        [BLTipView showWithTitle:@"密码不能为空"];
        return NO;
    }
    
    return result;
}

- (IBAction)btnRegisterClick:(id)sender{
    if (![self conditionsCheck]) {
        return;
    }
    
    [[LoginModel sharedInstance]registerWithMemberTel:tfNumber.text password:tfPw.text resultBlock:^(NSString *errorStr) {
        if (nil == errorStr) {
           [BLTipView showWithTitle:@"注册成功"];
        }else{
            [BLTipView showWithTitle:errorStr];
        }
    }];
}


- (IBAction)btnLoginClick:(id)sender{
    
//#if kDebugTest
//        [[PublicFunction appDelegate] goMainViewController];
//        return;
//#endif
    
    if (![self conditionsCheck]) {
        return;
    }
    
    [PublicFunction showActivityIndicatorInView:self.view];
    [[LoginModel sharedInstance]loginWithMemberTel:tfNumber.text password:tfPw.text resultBlock:^(NSString *errorStr) {
        if (nil == errorStr) {
            [[PublicFunction appDelegate] goMainViewController];
            NSLog(@"login successful");
        }else{
            [BLTipView showWithTitle:errorStr];
        }
    }];
}

@end
