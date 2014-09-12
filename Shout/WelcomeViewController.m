//
//  WelcomeViewController.m
//  Shout
//
//  Created by zhousl on 14-9-11.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "WelcomeViewController.h"

#define k_PageControl_CountPages    3

@interface WelcomeViewController ()
{
    IBOutlet UIPageControl* pageCtrl;
    IBOutlet UIScrollView* scrollPage;
}
@end

@implementation WelcomeViewController

- (void)dealloc
{
    scrollPage.delegate = nil;
}

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
    // Do any additional setup after loading the view from its nib.
//    if (kScreenIs4InchRetina) { // height 1136
//        //[BaseViewController adjustmentSizeFor4Inch:scrollPage];
//        CGRect rect = pageCtrl.frame;
//        rect.origin.y += 80;//k_Height_IOS7_Move;
//        pageCtrl.frame = rect;
//    }
    
    scrollPage.pagingEnabled = YES;
    if ([pageCtrl respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)]
        && [pageCtrl respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
        pageCtrl.pageIndicatorTintColor = [UIColor grayColor];
    }
    [self initPageControl:k_PageControl_CountPages];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    scrollPage.contentSize = CGSizeMake(scrollPage.bounds.size.width*k_PageControl_CountPages, scrollPage.bounds.size.height);
}

#pragma mark controlls init
-(void)initPageControl:(int)iCount
{
    // programmatically add the page control
	NSArray* ary = [NSArray arrayWithObjects:@"00lead_01",@"00lead_02", @"00lead_03",nil];
	CGRect pageFrame ;
    BOOL b4Inch = kScreenIs4InchRetina;
	for (int i = 0 ; i < iCount ; i++)
	{
		// determine the frame of the current page
		pageFrame = CGRectMake(i * scrollPage.bounds.size.width, 0.0f, scrollPage.bounds.size.width, b4Inch?568:480) ;
        UIImageView* imgPage = [[UIImageView alloc] initWithFrame:pageFrame];
        imgPage.backgroundColor = [UIColor clearColor];
        imgPage.image = [UIImage imageNamed:[ary objectAtIndex:i]];
        [scrollPage addSubview:imgPage];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
    if (0 < fractionalPage - (k_PageControl_CountPages-1.0)) {
        [PublicFunction setIsFirst];
        [[PublicFunction appDelegate] goLoginController];
        return;
    }
    
	if (pageCtrl.currentPage != nearestNumber)
	{
		pageCtrl.currentPage = nearestNumber ;
        
		// if we are dragging, we want to update the page control directly during the drag
		if (scrollView.dragging)
			[pageCtrl updateCurrentPageDisplay] ;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
