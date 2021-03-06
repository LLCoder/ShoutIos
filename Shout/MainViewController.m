//
//  MainViewController.m
//  Shout
//
//  Created by zhousl on 14-9-11.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "MainViewController.h"
#import "GetViewController.h"
#import "VentViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "ShareManager.h"
#import "EVCircularProgressView.h"
#import "RecorderManager.h"

#define k_ViewControl_Counts    3

#define k_DebicelMaxValue       12000.0

@interface MainViewController ()
{
    IBOutlet UIView* viewSentence;
    IBOutlet UIView* viewShout;
    IBOutlet UIView* viewTucao; //比比惨
    
    IBOutlet UIScrollView* mainScroll;
    IBOutlet UIPageControl* pageCtrl;
    
    IBOutlet UIImageView* imgShare;
    IBOutlet UIImageView* imgRank;
    
    IBOutlet UIButton* btnHold;
    IBOutlet EVCircularProgressView* cricularView;
    IBOutlet UILabel* labDebicelValue;
    
    
    IBOutlet UIImageView* ivSenIcon;
    IBOutlet UIImageView* ivSenContent;
    IBOutlet UILabel* labSenContent;
    
    IBOutlet UIImageView* ivShareIcon;
    IBOutlet UILabel* labShareLab;
    
    NSInteger currentDebicelCount;
    
    NSThread* threadRecorder;
}

-(void)clickShare:(UITapGestureRecognizer*)sender;
-(void)clickShoutRank:(UITapGestureRecognizer*)sender;
-(IBAction)clickBtnGet:(id)sender;
-(IBAction)clickBtnUse:(id)sender;
-(IBAction)clickBtnHold:(id)sender;

-(void)updateCricularByDebicel:(CGFloat)tDebicel;
@end

@implementation MainViewController
@synthesize showView;

- (void)dealloc
{
    mainScroll.delegate = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.strNavTitle = @"一句话";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViewControl:k_ViewControl_Counts];
    
    if (kScreenIs4InchRetina) { // height 1136
        //[BaseViewController adjustmentSizeFor4Inch:scrollPage];
        CGRect rect = pageCtrl.frame;
        rect.origin.y += 80;//k_Height_IOS7_Move;
        pageCtrl.frame = rect;
        
        [BaseViewController adjustmentSizeFor4Inch:ivSenIcon forSize:30];
//        [BaseViewController adjustmentPositionYFor4Inch:ivSenContent distance:(1136-960)/2-10];
                [BaseViewController adjustmentPositionYFor4Inch:ivSenContent distance:50];
        [BaseViewController adjustmentPositionYFor4Inch:labSenContent distance:50];
        
        [BaseViewController adjustmentPositionYFor4Inch:ivShareIcon distance:50];
        [BaseViewController adjustmentPositionYFor4Inch:imgShare distance:50];
        [BaseViewController adjustmentPositionYFor4Inch:labShareLab distance:50];
    }
   
    mainScroll.pagingEnabled = YES;
    if ([pageCtrl respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)]
        && [pageCtrl respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        pageCtrl.currentPageIndicatorTintColor = [UIColor blueColor];
        pageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    
    // Set record start action for UIControlEventTouchDown
    [btnHold addTarget:self action:@selector(recordStart) forControlEvents:UIControlEventTouchDown];
    // Set record end action for UIControlEventTouchUpInside
    [btnHold addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpInside];
    // Set record cancel action for UIControlEventTouchUpOutside
    [btnHold addTarget:self action:@selector(recordCancel) forControlEvents:UIControlEventTouchUpOutside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShare:)];
    tap.delegate = self;
    imgShare.userInteractionEnabled = YES;
    [imgShare addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapRank = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShoutRank:)];
    tapRank.delegate = self;
    imgRank.userInteractionEnabled = YES;
    [imgRank addGestureRecognizer:tapRank];
    
    [RecorderManager sharedInstance].decibelBlock = ^(CGFloat decibel){
        
        [self updateCricularByDebicel:decibel];
    };
    currentDebicelCount = 1000;
    labDebicelValue.text = [NSString stringWithFormat:@"%d", currentDebicelCount];
     cricularView.progress = currentDebicelCount/k_DebicelMaxValue;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (mainScroll.contentSize.width != mainScroll.bounds.size.width*k_ViewControl_Counts) {
        mainScroll.contentSize = CGSizeMake(mainScroll.bounds.size.width*k_ViewControl_Counts, mainScroll.bounds.size.height);
    }
    
    if (view_OneSentence == showView) {
        [mainScroll setContentOffset:CGPointMake(mainScroll.bounds.size.width*0, 0)];
    }
    else if (view_Shout == showView){
        [mainScroll setContentOffset:CGPointMake(mainScroll.bounds.size.width*1, 0)];
    }
    else if (view_Shout == showView){
        [mainScroll setContentOffset:CGPointMake(mainScroll.bounds.size.width*2, 0)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickShare:(UITapGestureRecognizer*)sender{
    
    NSLog(@"share");
    [[ShareManager sharedInstance]shareWithContent:@"hello"];

}

-(void)clickShoutRank:(UITapGestureRecognizer*)sender{
     NSLog(@"ShoutRank");
}

-(IBAction)clickBtnGet:(id)sender{
    GetViewController* lc = [[GetViewController alloc] initWithNibName:@"GetViewController" bundle:nil];
    lc.strNavTitle = @"获取";
    [self.navigationController pushViewController:lc animated:YES];
}

-(IBAction)clickBtnUse:(id)sender{
    VentViewController* lc = [[VentViewController alloc] initWithNibName:@"VentViewController" bundle:nil];
    //lc.strNavTitle = @"获取";
    self.showView = view_Tucao;
    [self.navigationController pushViewController:lc animated:YES];
}

-(IBAction)clickBtnHold:(id)sender{
     NSLog(@"Hold");
}

-(void)updateCricularByDebicel:(CGFloat)tDebicel{
    
    int iDebicel = fabsf(tDebicel)*100;
    
    currentDebicelCount += iDebicel;
    
    if (currentDebicelCount > k_DebicelMaxValue) {
        NSLog(@" 爆表！！！ %d", currentDebicelCount);
    }
     printf("iDebicel = %d, currentDebicelCount = %d\n", iDebicel,currentDebicelCount);
    
    labDebicelValue.text = [NSString stringWithFormat:@"%d", currentDebicelCount];
    cricularView.progress = currentDebicelCount/k_DebicelMaxValue;
    [cricularView setProgress:cricularView.progress animated:YES];
}

-(void) recordStart
{
    currentDebicelCount = 1000;
    [[RecorderManager sharedInstance] startRecorder:nil];
}

-(void) recordEnd
{
    [[RecorderManager sharedInstance] stopRecorder:nil];
}

-(void) recordCancel
{
  [[RecorderManager sharedInstance] stopRecorder:nil];
}


- (void)updateProgress:(NSTimer *)timer
{
//    if (cricularView.progress == 1) {
//        [timer invalidate];
//    } else {
//        [cricularView setProgress:cricularView.progress + 0.01  animated:YES];
//    }
}

#pragma mark controlls init
-(void)initViewControl:(int)iCount
{
    // programmatically add the page control
	NSArray* ary = [NSArray arrayWithObjects:viewSentence,viewShout,viewTucao,nil];
	CGRect pageFrame ;
    BOOL b4Inch = kScreenIs4InchRetina;
	for (int i = 0 ; i < [ary count] ; i++)
	{
		// determine the frame of the current page
		pageFrame = CGRectMake(i * mainScroll.bounds.size.width, 0.0f, mainScroll.bounds.size.width, b4Inch?568:480) ;
        UIView* view = [ary objectAtIndex:i];
        view.frame = pageFrame;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
    if (0 < fractionalPage - (k_ViewControl_Counts-1.0)) {
        printf("is last page\n");
    }
    
	if (pageCtrl.currentPage != nearestNumber)
	{
		pageCtrl.currentPage = nearestNumber ;
		// if we are dragging, we want to update the page control directly during the drag
		if (scrollView.dragging)
			[pageCtrl updateCurrentPageDisplay] ;
	}
    
    switch (pageCtrl.currentPage) {
        case 0:{
            [self setNavTitle:@"一句话"];
            break;
        }
        case 1:{
            [self setNavTitle:@"大声喊"];
            break;
        }
        case 2:{
            [self setNavTitle:@"创可贴"];
            break;
        }
        default:
            break;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageCtrl updateCurrentPageDisplay] ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    CGFloat pageWidth = scrollView.bounds.size.width ;
    //    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
}




@end
