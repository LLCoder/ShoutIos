//
//  MainViewController.h
//  Shout
//
//  Created by zhousl on 14-9-11.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    view_OneSentence,
    view_Shout,
    view_Tucao
    
}ViewName;

@interface MainViewController : BaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic, assign)ViewName showView;

@end
