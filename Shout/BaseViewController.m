//
//  BaseViewController.m
//  Shout
//
//  Created by zhousl on 14-9-10.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize bLoadingData,bShowBack,bShowMore,strNavTitle;
@synthesize bShowNav;
@synthesize bShowNavBar;

- (void)dealloc
{
    SAFERELEASE(strNavTitle);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.bShowNav = YES;
        self.bShowNavBar = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];
    if (IOS7_OR_LATER)
    {
        //某个仅支持7.0以上版本的方法
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        
//        if ( self.navigationController.navigationBarHidden == YES )
//        {
//            [self.view setBounds:CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height)];
//        }
//        else
//        {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        }
    }
    
    [self initNavBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define k_Tag_TitleName 1500
#define k_Tag_RightButton 1600

-(void)initNavBar{
    
    if (!bShowNav) {
        return;
    }
    
    UIImage* imageN = [UIImage imageNamed:@"ic_header_bg"];// // 图片尺寸问题竖屏：44px(retina 屏则为 88px)横屏：32px (retina 屏则为 64px)
    int iStatusBarHeight = 0;
    
    CGRect rect = CGRectMake(0, iStatusBarHeight, 320, self.navigationController.navigationBar.frame.size.height);
    
    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:rect];
    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:imageN];
    navigationBarBackgroundImageView.frame = rect;
    if (bShowNavBar) {
        navigationBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:22/255.0
                                                                           green:122/255.0
                                                                            blue:237/255.0
                                                                           alpha:1.0];
    }
    else{
        navigationBarBackgroundImageView.backgroundColor = [UIColor whiteColor];
    }
    
    [customNavigationBar addSubview:navigationBarBackgroundImageView];
    SAFERELEASE(navigationBarBackgroundImageView);
    
    UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:@""];
    [customNavigationBar pushNavigationItem:navigationTitle animated:NO];
    //[navigationTitle release];
    
    /// right button
    if (bShowMore) {
        rect = CGRectMake(self.view.frame.size.width-45, iStatusBarHeight+7,
                          30, 30);
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRight.frame = rect;
        btnRight.backgroundColor = [UIColor clearColor];
        btnRight.tag = k_Tag_RightButton;
        [btnRight setBackgroundImage:[UIImage imageNamed:@"listMenu"] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(MoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [customNavigationBar addSubview:btnRight];
    }
    
    if(bShowBack){
        /// backButton
        rect = CGRectMake(20, iStatusBarHeight+20,
                          12, 20);//self.navigationController.navigationBar.frame.size.height
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRight.frame = rect;
        btnRight.backgroundColor = [UIColor clearColor];
        [btnRight setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
//        [btnRight setBackgroundImage:[UIImage imageNamed:@"ic_back_pressed"] forState:UIControlStateHighlighted];
        [btnRight addTarget:self action:@selector(BackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [customNavigationBar addSubview:btnRight];
    }
    if (IOS7_OR_LATER) {/// ios7.0
        iStatusBarHeight = k_Height_IOS7_Move;
    }
    /// titleView
    rect = CGRectMake((self.view.frame.size.width-80)/2, iStatusBarHeight, 80, self.navigationController.navigationBar.frame.size.height);
    rect.origin.x = 50;
    rect.size.width = 220;
    UILabel* labName = [[UILabel alloc] initWithFrame:rect];
    labName.backgroundColor = [UIColor clearColor];
    labName.textAlignment = NSTextAlignmentCenter;
    labName.textColor = [UIColor whiteColor];
    labName.font = [UIFont systemFontOfSize:18];
    labName.text = strNavTitle;
    labName.tag = k_Tag_TitleName;
    //labName.adjustsFontSizeToFitWidth = YES;
    [customNavigationBar addSubview:labName];
   // [labName release];
    [self.view addSubview:customNavigationBar];
    
    SAFERELEASE(customNavigationBar);
}

-(void)setNavTitle:(NSString*)str{
    
    UILabel* lab = (UILabel*)[self.view viewWithTag:k_Tag_TitleName];
    if (nil != lab) {
        lab.text = str;
    }
}

-(void)setRightButtonImage:(NSString*)str{
    UIButton* lab = (UIButton*)[self.view viewWithTag:k_Tag_RightButton];
    if (nil != lab) {
        [lab setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        [lab setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
}

-(void) MoreButtonPressed:(id)sender{
    
}

-(void) BackButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
