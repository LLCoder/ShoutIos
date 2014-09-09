//
//  RequestMsgClick.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestMsgClick.h"

@implementation RequestMsgClick
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_MsgClick;
        self.methodName = @"Json/MessageClick.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.ventId ForKey:@"VentId"];
    return urlBody.requestStr;
}
@end
