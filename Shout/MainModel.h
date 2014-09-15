//
//  MainModel.h
//  Shout
//
//  Created by shana on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SentenceEntity.h"
#import "WoundPasteEntity.h"

@interface MainModel : NSObject
DEFINE_SINGLETON_FOR_HEADER(MainModel);

//获取一句话信息
- (void)getOneSentence:(void(^)(SentenceEntity *sentence,NSString * errorStr)) resultBlock;

//获取创口贴
- (void)getWoundPaste:(void(^)(WoundPasteEntity *woundPaste,NSString * errorStr)) resultBlock;
@end
