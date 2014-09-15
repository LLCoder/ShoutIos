//
//  ShareManager.h
//  Shout
//
//  Created by shana on 14-9-12.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareManager : NSObject
DEFINE_SINGLETON_FOR_HEADER(ShareManager);

- (void)start;
@end
