//
//  RequestOneSentence.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestOneSentence.h"
#import "SentenceEntity.h"

@implementation RequestOneSentence
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_OneSentence;
        self.methodName = @"Json/OneSentence.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (GetSentenceRst *)requestDecode:(id)recData{
    GetSentenceRst *sentenceRst = [[GetSentenceRst alloc]init];
    [RequestInterfaceBase decodeResults:sentenceRst recData:recData];
    if (sentenceRst.requestCode > 0 && (sentenceRst.requestCode % 100 == 0)) {
        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            sentenceRst.sentence.title = [dicData objectForKey:@"OneTitle"];
            sentenceRst.sentence.picUrl = [dicData objectForKey:@"OnePic"];
            sentenceRst.sentence.content = [dicData objectForKey:@"OneShow"];

        }
    }else if (self.statusCode == 404){
        sentenceRst.message = @"服务器异常";
    }else {
        sentenceRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(sentenceRst.requestCode)];
    }
    
	return sentenceRst;
}
@end
