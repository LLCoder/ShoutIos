//
//  MainModel.m
//  Shout
//
//  Created by shana on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "MainModel.h"
#import "RequestOneSentence.h"

@implementation MainModel
DEFINE_SINGLETON_FOR_CLASS(MainModel);


- (void)getOneSentence:(void(^)(SentenceEntity *sentence,NSString * errorStr)) resultBlock{
    RequestOneSentence *oneSentence = [[RequestOneSentence alloc]init];
    oneSentence.completionBlock = ^(NetBaseRst *netBaseRst) {
        GetSentenceRst *sentenceRst = (GetSentenceRst *)netBaseRst;
        if (resultBlock) {
            resultBlock(sentenceRst.sentence,sentenceRst.message);
        }
        
    };
    
    oneSentence.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(nil,netBaseRst.message);
        }
        
    };
    
    [oneSentence run];
}

@end
