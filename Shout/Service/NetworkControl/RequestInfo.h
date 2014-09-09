//
//  RequestInfo.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MsgConstant.h"
#import "Data_Struct.h"
#import "NetRst_Struct.h"
@protocol HTTP_REC_RESPOND;
@interface RequestInfoBase : NSObject{
}
@property (nonatomic, assign) int requestType;
@property (nonatomic, assign) int cmdCode;
@property (nonatomic, assign) int requestCode;
@property (nonatomic, assign) int httpRsp;
@property (nonatomic, assign) id <HTTP_REC_RESPOND> delegate;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) NSDictionary *requestHeaders;
@property (nonatomic, strong) NSDictionary *requestDic;
@property (nonatomic, strong) NSData *postData;
@property (nonatomic, strong) NSMutableData *recData;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, readonly)BOOL    isPost;
@property (nonatomic, assign) int timeoutSeconds;
@property (nonatomic, assign) BOOL needSessionCheck;
@end


#pragma mark delegate_
@protocol HTTP_REC_RESPOND<NSObject>

@required
- (int)reciveHttpRespond:(RequestInfoBase *)ReceiveMsg;

@optional


@end

