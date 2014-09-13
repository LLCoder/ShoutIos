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

//发送发泄数据
- (void)sendVentShow:(NSString *)ventShow ventColor:(NSString *)ventColor resultBlock:(void(^)(WoundPasteEntity *woundPaste,NSString * errorStr)) resultBlock;

//消息点击(你惨、我惨)
- (void)messageClick:(NSString *)ventId resultBlock:(void(^)(NSString * errorStr)) resultBlock;

//签到
- (void)signIn:(void(^)(NSString * errorStr)) resultBlock;

//写入分贝
- (void)addDB:(NSString *)memberDB resultBlock:(void(^)(NSString * errorStr)) resultBlock;

//分贝排名
- (void)getRanking:(void(^)(NSMutableArray *rankings, NSString * errorStr)) resultBlock;
@end
