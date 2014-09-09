//
//  BLTipView.m
//  i部落
//
//  Created by wiscom on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BLTipView.h"
#import <QuartzCore/QuartzCore.h>

#define TV_RADIANS(degrees) ((degrees * M_PI) / 180.0)

#define TIP_ANIMATION_DURATION	0.4f
#define TIP_MAX_WIDTH			200.0f
#define TIP_PADDING_X			10.0f

@implementation BLTipView
@synthesize title=_title, duration=_duration, offsetY;

+(void)tipNetworkFail
{
	[BLTipView showWithTitle:COMMON_FAIL_TIP];
}
+(void)tipNetworkFailWithOffsetY:(CGFloat)offset
{
	[BLTipView showWithTitle:COMMON_FAIL_TIP offsetY:offset];
}
+(void)showWithTitle:(NSString *)title
{
	[BLTipView showWithTitle:title duration:TIP_DURATION offsetY:30.0f];
}
+(void)showWithTitle:(NSString *)title offsetY:(CGFloat)offset
{
	[BLTipView showWithTitle:title duration:TIP_DURATION offsetY:offset];
}
+(void)showWithTitle:(NSString *)title duration:(CGFloat)duration offsetY:(CGFloat)offset
{
    if ([title length] < 1)
    {
        return;
    }
	BLTipView *temp = [[BLTipView alloc] initWithTitle:title duration:duration];
	temp.offsetY = offset;
	[temp show];
}
-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];		
		
		self.layer.cornerRadius	 = 8.0f;
		self.layer.masksToBounds = YES;
        
		_duration = TIP_DURATION;
        
        _labTitle = [[UILabel alloc] init];
        _labTitle.numberOfLines = 0;
        _labTitle.textColor = [UIColor whiteColor];
        _labTitle.backgroundColor = [UIColor clearColor];
        _labTitle.font = [UIFont systemFontOfSize:20.0f];
		_labTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_labTitle];
    }
    return self;
}
-(id)initWithTitle:(NSString *)title duration:(CGFloat)duration
{
	self = [self initWithFrame:CGRectZero];
	if (self) 
	{
		self.title = COMMON_FAIL_TIP;
		if ([title isKindOfClass:[NSString class]]) 
		{
			NSString *trimmed = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			if ([trimmed length] > 0) 
			{
				self.title = title;
			}
		}
		self.duration = duration;
	}
	return self;
}
-(void)setTitle:(NSString *)title
{
    if (_title != title) 
    {
        _title = title;
        
        _labTitle.text = _title;
		
		[self setNeedsLayout];
    }
}
-(void)setDuration:(CGFloat)duration
{
    _duration = duration;
    
    [self setupTimer];
}
-(void)setupTimer
{
    [self clearTimer];
    
    if (_duration > 0.0) 
    {
        _timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:_duration]
                                          interval:10.0 
                                            target:self
                                          selector:@selector(hide) 
                                          userInfo:nil 
                                           repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
-(void)clearTimer
{
    SAFE_RELEASE_TIMER(_timer);
}
-(void)show
{
//	[self setTransformForCurrentOrientation:NO];
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self];
}
-(void)hide
{
    [self clearTimer];
    
    [UIView beginAnimations:@"hidetip" context:NULL];
    [UIView setAnimationDuration:TIP_ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didStop)];
    
    self.alpha = 0.1;
    
    [UIView commitAnimations];
}
-(void)didStop
{
    [self removeFromSuperview];
}   
-(void)layoutSubviews
{
    [super layoutSubviews];
    
	if (self.superview) 
	{
		CGSize tsize = [_labTitle.text sizeWithFont:_labTitle.font 
								  constrainedToSize:CGSizeMake(TIP_MAX_WIDTH, 500.0F) 
									  lineBreakMode:0];
		
		CGFloat w = TIP_MAX_WIDTH + 2*TIP_PADDING_X;
		CGFloat h = tsize.height + 2*TIP_PADDING_X;
		
		CGSize supersize = self.superview.bounds.size;
		CGRect rect = CGRectMake((supersize.width - w)/2.0f, (supersize.height - h)/2.0f - offsetY, w, h);
		self.frame = rect;
		
	}	
	_labTitle.frame = CGRectInset(self.bounds, TIP_PADDING_X, TIP_PADDING_X);
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview != nil) 
    {
        self.alpha = 0.0;
        
        [UIView beginAnimations:@"showtip" context:NULL];
        [UIView setAnimationDuration:TIP_ANIMATION_DURATION];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.alpha = 1.0;
        
        [UIView commitAnimations];
    }
}
-(void)didMoveToSuperview
{
    if (self.superview != nil)
    {
        [self setupTimer];
    }
}
- (void)dealloc
{
    [self clearTimer];
}

@end
