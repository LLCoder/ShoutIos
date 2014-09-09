//
//  BLTipView.h
//  i部落
//
//  Created by wiscom on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIP_DURATION	1.6	 // 默认显示时间

#define COMMON_FAIL_TIP		@"服务或网络不给力，请稍后再试"

//普通的提示框，在屏幕中央显示，不会禁用后面的界面
@interface BLTipView : UIView
{
  @private
    UILabel			*_labTitle;
    NSTimer			*_timer;
}
@property(nonatomic,retain) NSString	*title;
@property(nonatomic,assign) CGFloat		duration;
@property(nonatomic,assign) CGFloat		offsetY;	//self.frame.origin.y的偏移值, 减去此值
//@property(nonatomic,assign) BOOL		isError;
+(void)tipNetworkFail;	//共用的网络异常信息提示
+(void)tipNetworkFailWithOffsetY:(CGFloat)offset;
+(void)showWithTitle:(NSString *)title;
+(void)showWithTitle:(NSString *)title offsetY:(CGFloat)offset;
+(void)showWithTitle:(NSString *)title duration:(CGFloat)duration offsetY:(CGFloat)offset;
-(id)initWithTitle:(NSString *)title duration:(CGFloat)duration;
-(void)show;
-(void)hide;
@end
