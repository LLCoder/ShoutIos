//
//  AppRequest.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "Data_Struct.h"
#import "NetRst_Struct.h"


#define HTTP_METHOD_POST		@"POST"
#define HTTP_METHOD_GET			@"GET"
@class RequestInfoBase;
@protocol HTTP_REC_RESPOND;
@protocol UploadRatDelegate;
@interface MsgRequest : ASIFormDataRequest
{
	int    _requestCode;
}

@property (nonatomic, assign)int requestType;
@property (nonatomic, assign)int requestCode;
@property (nonatomic, assign)int cmdCode;
@property (nonatomic, weak)id<HTTP_REC_RESPOND>   modelDelegage;
@property (nonatomic, assign)int timeoutSeconds;
@property (nonatomic, assign)BOOL needSessionCheck;
-(id)initWithURL:(NSURL *)newURL;
-(void)setReqInfo:(RequestInfoBase *)reqInfo;
-(void)setInfoWithRequest:(MsgRequest *)msgRequest;
@end


