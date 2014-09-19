//
//  VentBrowseViewController.m
//  Shout
//
//  Created by zhousl on 14-9-16.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "VentBrowseViewController.h"

@interface VentBrowseViewController ()
{
    IBOutlet UILabel* labContent;
    IBOutlet UIView* viewCry;
    IBOutlet UIView* viewSmile;
    
    IBOutlet UIView* viewLabBg;
}

-(IBAction)clickBack:(id)sender;
-(void)clickCry:(UITapGestureRecognizer*)sender;
-(void)clickSmile:(UITapGestureRecognizer*)sender;
@end

@implementation VentBrowseViewController

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
    
    if (kScreenIs4InchRetina) { // height 1136
        
        
        [BaseViewController adjustmentSizeFor4Inch:viewLabBg forSize:80];
        
        [BaseViewController adjustmentPositionYFor4Inch:viewCry distance:80];
        [BaseViewController adjustmentPositionYFor4Inch:viewSmile distance:80];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCry:)];
    tap.delegate = self;
    viewCry.userInteractionEnabled = YES;
    [viewCry addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapSmile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSmile:)];
    tapSmile.delegate = self;
    viewSmile.userInteractionEnabled = YES;
    [viewSmile addGestureRecognizer:tapSmile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickCry:(UITapGestureRecognizer*)sender{
    
}

-(void)clickSmile:(UITapGestureRecognizer*)sender{
    
}

@end
