//
//  RequestMessage.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestMessage.h"

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
@end
