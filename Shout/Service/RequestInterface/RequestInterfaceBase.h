//
//  RequestInterfaceBase.h
//  dudu
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestInfo.h"
#import "NetRst_Struct.h"
#import "PublicFunction.h"

#define kNetwrokUnconcect 9999

@interface RequestInterfaceBase : NSObject
{
    NSString               *_dataVersion;
    NSMutableDictionary    *_requestHeaders;
    NSString               *_requestUrl;
}

@property (nonatomic, assign) RequestType requestType;
@property (nonatomic, assign) int cmdCode;
@property (nonatomic, assign) int requestCode;
@property (nonatomic, copy)   NSString *methodName;
@property (nonatomic, assign) int timeoutSeconds;
@property (nonatomic, copy)   NSString *clientVersion;
@property (nonatomic, weak) id  receiveDelegete;
@property (nonatomic, strong)NSString *requestUrl;
@property (nonatomic, readonly)NSDictionary *requestHeaders;
@property (nonatomic, readonly)NSDictionary *requestDic;
@property (nonatomic, assign) int  statusCode;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, copy)BLNetworkBaseBlock  completionBlock;
@property (nonatomic, copy)BLNetworkFaildBlock failedBlock;
@property (nonatomic, assign) BOOL needSessionCheck;


- (NetBaseRst *)requestDecode:(id)recData;
- (int)run;
+ (NSDictionary *)errorDic;
+ (void)decodeResults:(NetBaseRst *)netRst recData:(id)data;
@end