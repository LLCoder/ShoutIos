//
//  MainModel.h
//  Shout
//
//  Created by shana on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SentenceEntity.h"
@interface MainModel : NSObject
DEFINE_SINGLETON_FOR_HEADER(MainModel);

- (void)getOneSentence:(void(^)(SentenceEntity *sentence,NSString * errorStr)) resultBlock;
@end
