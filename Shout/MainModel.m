//
//  MainModel.m
//  Shout
//
//  Created by shana on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "MainModel.h"
#import "RequestOneSentence.h"
#import "RequestWoundPaste.h"
#import "LoginModel.h"

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


//获取创口贴
- (void)getWoundPaste:(void(^)(WoundPasteEntity *woundPaste,NSString * errorStr)) resultBlock{
    RequestWoundPaste *woundPaste = [[RequestWoundPaste alloc]init];
    woundPaste.memberId = [LoginModel sharedInstance].memberId;
    woundPaste.completionBlock = ^(NetBaseRst *netBaseRst) {
        GetWoundPasteRst *woundPasteRst = (GetWoundPasteRst *)netBaseRst;
        if (resultBlock) {
            resultBlock(woundPasteRst.woundPaste,woundPasteRst.message);
        }
        
    };
    
    woundPaste.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(nil,netBaseRst.message);
        }
        
    };
    
    [woundPaste run];
}

@end
