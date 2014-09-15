//
//  RequestMessage.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestMessage.h"
#import "WoundPasteEntity.h"

@implementation RequestMessage
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_Message;
        self.methodName = @"Json/Message.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberId ForKey:@"MemberId"];
    [urlBody addElemValue:self.ventShow ForKey:@"VentShow"];
    [urlBody addElemValue:self.ventColor ForKey:@"VentColor"];
    return urlBody.requestStr;
}

- (SendMessageRst *)requestDecode:(id)recData{
    SendMessageRst *sendMessageRst = [[GetWoundPasteRst alloc]init];
    [RequestInterfaceBase decodeResults:sendMessageRst recData:recData];
    if (sendMessageRst.requestCode > 0 && (sendMessageRst.requestCode % 100 == 0)) {
        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            sendMessageRst.woundPaste.ventId = [dicData objectForKey:@"VentId"];
            sendMessageRst.woundPaste.ventShow = [dicData objectForKey:@"VentShow"];
            sendMessageRst.woundPaste.ventColor = [dicData objectForKey:@"VentColor"];
            sendMessageRst.woundPaste.ventClicks = [[dicData objectForKey:@"VentClicks"] intValue];
        }
    }else if (self.statusCode == 404){
        sendMessageRst.message = @"服务器异常";
    }else {
        sendMessageRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(sendMessageRst.requestCode)];
    }
    
	return sendMessageRst;
}
@end
