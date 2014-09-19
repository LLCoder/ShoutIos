//
//  BaseViewController.h
//  Shout
//
//  Created by zhousl on 14-9-10.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef k_Height_IOS7_Move
#define k_Height_IOS7_Move 10
#endif

@interface BaseViewController : UIViewController

@property(nonatomic, retain)NSString* strNavTitle;
@property(nonatomic, assign)BOOL    bShowMore;
@property(nonatomic, assign)BOOL    bShowBack;
@property(nonatomic, assign)BOOL bLoadingData;
@property(nonatomic, assign)BOOL  bShowNav;
@property(nonatomic, assign)BOOL  bShowNavBar;

-(void) MoreButtonPressed:(id)sender;

-(void)setNavTitle:(NSString*)str;
-(void)setRightButtonImage:(NSString*)str;


+(void)adjustmentSizeFor4Inch:(UIView*)aView forSize:(float)fSize;
+(void)adjustmentSizeFor4Inch:(UIView*)aView;
+(void)adjustmentPositionYFor4Inch:(UIView*)aView distance:(float)fd;
+(void)adjustmentPositionYFor4Inch:(UIView*)aView
                          distance:(float)fd
                        addOrMinus:(BOOL)bAdd;

@end
