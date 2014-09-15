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
#import "RequestMessage.h"
#import "RequestMsgClick.h"
#import "RequestSignIn.h"
#import "RequestAddDB.h"
#import "RequestRanking.h"
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

//发送发泄数据
- (void)sendVentShow:(NSString *)ventShow ventColor:(NSString *)ventColor resultBlock:(void(^)(WoundPasteEntity *woundPaste,NSString * errorStr)) resultBlock{
    RequestMessage *requestMessage = [[RequestMessage alloc]init];
    requestMessage.memberId = [LoginModel sharedInstance].memberId;
    requestMessage.completionBlock = ^(NetBaseRst *netBaseRst) {
        SendMessageRst *sendMessageRst = (SendMessageRst *)netBaseRst;
        if (resultBlock) {
            resultBlock(sendMessageRst.woundPaste,sendMessageRst.message);
        }
        
    };
    
    requestMessage.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(nil,netBaseRst.message);
        }
        
    };
    
    [requestMessage run];
}

//消息点击(你惨、我惨)
- (void)messageClick:(NSString *)ventId resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestMsgClick *msgClick = [[RequestMsgClick alloc]init];
    msgClick.ventId = ventId;
    msgClick.completionBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
        
    };
    
    msgClick.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
        
    };
    
    [msgClick run];
}

//签到
- (void)signIn:(void(^)(NSString * errorStr)) resultBlock{
    RequestSignIn *signIn = [[RequestSignIn alloc]init];
    signIn.memberId = [LoginModel sharedInstance].memberId;
    signIn.completionBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
    };
    
    signIn.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
        
    };
    
    [signIn run];
}

//写入分贝
- (void)addDB:(NSString *)memberDB resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestAddDB *addDB = [[RequestAddDB alloc]init];
    addDB.memberId = [LoginModel sharedInstance].memberId;
    addDB.memberDB = memberDB;
    addDB.completionBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
    };
    
    addDB.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
        
    };
    
    [addDB run];
}

//分贝排名
- (void)getRanking:(void(^)(NSMutableArray *rankings, NSString * errorStr)) resultBlock{
    RequestRanking *ranking = [[RequestRanking alloc]init];
    ranking.completionBlock = ^(NetBaseRst *netBaseRst) {
        GetRankingsRst *rankingRst = (GetRankingsRst *)netBaseRst;
        if (resultBlock) {
            resultBlock(rankingRst.rankings,netBaseRst.message);
        }
    };
    
    ranking.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(nil,netBaseRst.message);
        }
        
    };
    
    [ranking run];
}
@end
