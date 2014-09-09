//
//  LoginController.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "LoginController.h"
#import "LoginModel.h"

@interface LoginController ()
@property (nonatomic, strong)UITextField *txtNumberTel;
@property (nonatomic, strong)UITextField *txtPWD;
@property (nonatomic, strong)UIButton    *btnRegister;
@property (nonatomic, strong)UIButton    *btnLogin;
@end

@implementation LoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    _txtNumberTel = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 200, 40)];
    _txtNumberTel.placeholder = @"手机号";
    [self.view addSubview:_txtNumberTel];
    
    _txtPWD = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_txtNumberTel.frame)+20, 200, 40)];
    _txtPWD.placeholder = @"密码";
    [self.view addSubview:_txtPWD];
    
    _btnRegister = [[UIButton alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(_txtPWD.frame)+20, 60, 35)];
    [_btnRegister addTarget:self action:@selector(btnRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:_btnRegister];
    
    _btnLogin = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_btnRegister.frame)+80, CGRectGetMaxY(_txtPWD.frame)+20, 60, 35)];
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:_btnLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnRegisterClick:(id)sender{
    
}


- (void)btnLoginClick:(id)sender{
    if (!ISEXISTSTR(_txtNumberTel.text)) {
        [BLTipView showWithTitle:@"手机号不能为空"];
        return;
    }
    
    if (!ISEXISTSTR(_txtPWD.text)) {
        [BLTipView showWithTitle:@"密码不能为空"];
        return;
    }
    
    [[LoginModel sharedInstance]loginWithMemberTel:_txtNumberTel.text password:_txtPWD.text resultBlock:^(NSString *errorStr) {
        if (nil == errorStr) {
            NSLog(@"login successful");
        }else{
            [BLTipView showWithTitle:errorStr];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
