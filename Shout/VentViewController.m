//
//  VentViewController.m
//  Shout
//
//  Created by zhousl on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "VentViewController.h"
#import "VentBrowseViewController.h"


@interface VentViewController ()
{
    IBOutlet UIImageView* imgBottomTip;
    IBOutlet UITextView*  tvInput;
    IBOutlet UIView* viewBg;
    
    NSMutableArray* aryColors;
    NSInteger      uCurrentColor;
}
-(IBAction)clickBack:(id)sender;
-(IBAction)clickToCao:(id)sender;
-(void)clickBg:(id)sender;
-(void)swipeBg:(UISwipeGestureRecognizer*)sender;
@end

@implementation VentViewController

- (void)dealloc
{
    SAFERELEASE(aryColors);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.bShowNav = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (kScreenIs4InchRetina) { // height 1136
        
        
        [BaseViewController adjustmentSizeFor4Inch:viewBg forSize:80];
        
        [BaseViewController adjustmentPositionYFor4Inch:imgBottomTip distance:80];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBg:)];
    tap.delegate = self;
    viewBg.userInteractionEnabled = YES;
    [viewBg addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBg:)];
    swipeR.delegate = self;
    swipeR.direction = UISwipeGestureRecognizerDirectionRight;
    [viewBg addGestureRecognizer:swipeR];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBg:)];
    swipeL.delegate = self;
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    [viewBg addGestureRecognizer:swipeL];
    
    //[swipe requireGestureRecognizerToFail:tap];
    
    aryColors = [[NSMutableArray alloc] initWithCapacity:0];
    [aryColors addObject:[UIColor orangeColor]];
    [aryColors addObject:[UIColor lightGrayColor]];
    [aryColors addObject:viewBg.backgroundColor];
    [aryColors addObject:[UIColor cyanColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBack:(id)sender{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickToCao:(id)sender{
    VentBrowseViewController* lc = [[VentBrowseViewController alloc] initWithNibName:@"VentBrowseViewController" bundle:nil];
    [self.navigationController pushViewController:lc animated:YES];
}

-(void)clickBg:(id)sender{
    [tvInput resignFirstResponder];
}

-(void)swipeBg:(UISwipeGestureRecognizer*)sender{
    
    if (UISwipeGestureRecognizerDirectionLeft == sender.direction) {
        --uCurrentColor;
    }
    else if(UISwipeGestureRecognizerDirectionRight == sender.direction){
        ++uCurrentColor;
    }
    if (uCurrentColor < 0) {
        uCurrentColor = [aryColors count]-1;
    }
    else if([aryColors count] <= uCurrentColor){
        uCurrentColor = 0;
    }
    
    viewBg.backgroundColor = [aryColors objectAtIndex:uCurrentColor];
}

@end
