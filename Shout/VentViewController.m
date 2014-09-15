//
//  VentViewController.m
//  Shout
//
//  Created by zhousl on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "VentViewController.h"

@interface VentViewController ()
{
    IBOutlet UIImageView* imgBottomTip;
    IBOutlet UITextView*  tvInput;
    IBOutlet UIView* viewBg;
}
-(IBAction)clickBack:(id)sender;
-(IBAction)clickToCao:(id)sender;
-(void)clickBg:(id)sender;
-(void)swipeBg:(UISwipeGestureRecognizer*)sender;
@end

@implementation VentViewController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBg:)];
    tap.delegate = self;
    viewBg.userInteractionEnabled = YES;
    [viewBg addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBg:)];
    swipe.delegate = self;
    swipe.direction = UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft;
    [viewBg addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickToCao:(id)sender{
    
}

-(void)clickBg:(id)sender{
    [tvInput resignFirstResponder];
}

-(void)swipeBg:(UISwipeGestureRecognizer*)sender{
    
    
}

@end
