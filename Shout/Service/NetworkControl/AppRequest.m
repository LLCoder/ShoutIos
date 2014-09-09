//
//  AppRequest.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppRequest.h"
#import "RequestInfo.h"
#import "PublicFunction.h"
@implementation MsgRequest

- (id)initWithURL:(NSURL *)newURL{
	if (self = [super initWithURL:newURL]) {
		[self setRequestMethod:HTTP_METHOD_GET];
		
		NSMutableDictionary* dicHeaders = [NSMutableDictionary dictionaryWithCapacity:1];
		[dicHeaders setObject:@"applicatioin/bin;charset=UTF-8" forKey:@"Content-Type"];
		[self setRequestHeaders:dicHeaders];
	}
	return self;
}

-(void)setRequestCode:(int)requestCode{
	_requestCode = requestCode;
	self.tag = requestCode;
}

-(void)setReqInfo:(RequestInfoBase *)reqInfo{
    [self.requestHeaders addEntriesFromDictionary:reqInfo.requestHeaders];
	self.requestType = reqInfo.requestType;
	self.cmdCode = reqInfo.cmdCode;
	self.modelDelegage = reqInfo.delegate;
    self.timeoutSeconds = reqInfo.timeoutSeconds;
    
    if (ISDICTIONARYCLASS(reqInfo.requestDic) && reqInfo.requestDic.count > 0) {
        [self setRequestMethod:HTTP_METHOD_POST];
        [reqInfo.requestDic enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop)
         {
             [self addPostValue:obj forKey:key];
         }];

    }
}

-(void)setInfoWithRequest:(MsgRequest *)msgRequest{
    self.requestHeaders = msgRequest.requestHeaders;
    self.tag = msgRequest.tag;
    self.delegate = msgRequest.delegate;
    self.requestType = msgRequest.requestType;
	self.cmdCode = msgRequest.cmdCode;
	self.modelDelegage = msgRequest.modelDelegage;
    self.postBody = msgRequest.postBody;
    self.timeoutSeconds = msgRequest.timeoutSeconds;
}
@end
