//
//  NetworkModel.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetworkModel.h"
#import "HttpNetworkCtrl.h"
#import "RequestInterfaceBase.h"

@interface NetworkModel(){
    NSLock*              _lock;
    NSMutableArray       *_requestList;
}

@end

@implementation NetworkModel

DEFINE_SINGLETON_FOR_CLASS(NetworkModel)

-(id)init{
	self = [super init];
	if (self != nil) {
        _requestList = [[NSMutableArray alloc]initWithCapacity:0];
		_lock = [[NSLock alloc] init];
	}
	return self;
}

-(int)sendRequest:(RequestInterfaceBase*)request{
	int requestType = request.requestType;
    RequestInfoBase *requestInfo = nil;
	switch (requestType) {
		case RequestTypeMsg:{
			requestInfo = [[RequestInfoBase alloc]init];
            requestInfo.requestUrl = request.requestUrl;
            requestInfo.requestDic = request.requestDic;
			break;
		}

		default:
			break;
	}
    requestInfo.needSessionCheck = request.needSessionCheck;
    requestInfo.cmdCode = request.cmdCode;
    requestInfo.requestType = request.requestType;
	requestInfo.timeoutSeconds = request.timeoutSeconds;
    requestInfo.requestHeaders = request.requestHeaders;
    requestInfo.delegate = self;
    
    int iRsp = [[HttpNetworkCtrl sharedInstance] sendHttpRequest:requestInfo];
	requestInfo.requestCode = iRsp;
    request.requestCode = iRsp;
    [_requestList addObject:request];
	return iRsp;
}

- (void)removeAllReuest:(id)requestDelegate{
    NSMutableArray *objs = [[NSMutableArray alloc]initWithCapacity:10];
    for (RequestInterfaceBase* requestInterface in _requestList) {
		if ([requestInterface.receiveDelegete isEqual: requestDelegate]) {
            [objs addObject:requestInterface];
		}
	}
    
    if ([objs count]>0) {
        [_lock lock];
        [_requestList removeObjectsInArray:objs];
        [_lock unlock];
    }
    
    [[HttpNetworkCtrl sharedInstance]cancelRequestFromDelegate:requestDelegate];
}

- (void)cancelAllRequests{
    [[HttpNetworkCtrl sharedInstance] cancelAllRequests];
    [_lock lock];
    [_requestList removeAllObjects];
    [_lock unlock];
}
#pragma mark -
#pragma mark HTTP_REC_RESPOND
-(int)reciveHttpRespond:(RequestInfoBase*)receiveMsg{
    //	char* recData = (char*)[ReceiveMsg.recData bytes];
    NSDictionary *jsonData = nil;
    if (receiveMsg.recData && receiveMsg.recData.length > 0) {
        NSString *string = [[NSString alloc] initWithData:receiveMsg.recData encoding:NSUTF8StringEncoding];
        jsonData = [string JSONValue];
    }
    
    //NSLog(@"the receive data is %@",[NSString stringWithUTF8String:(const char *)[receiveMsg.recData bytes]]);
    if (receiveMsg.requestType == RequestTypeMsg) {
        NSLog(@"\n id = %d\nReciveHttpMsg = \n%@,",  receiveMsg.cmdCode ,jsonData);
    }
    
	NetBaseRst* netRst = nil;
    NSMutableArray *objs = [[NSMutableArray alloc]initWithCapacity:10];
    for (RequestInterfaceBase* requestInterface in _requestList) {
        if (requestInterface.requestCode == receiveMsg.requestCode) {
            requestInterface.statusCode = receiveMsg.statusCode;
            requestInterface.timestamp = receiveMsg.timeStamp;
            int requestType = receiveMsg.requestType;
            switch (requestType) {
                case RequestTypeMsg:
                case RequestTypeUpload:{
                    netRst = [requestInterface requestDecode:jsonData];
                    netRst.cmdCode = receiveMsg.cmdCode;
                    netRst.requestCode = receiveMsg.requestCode;
                    break;
                }
                    
                default:
                    break;
            }
            
            netRst.httpRsp = receiveMsg.httpRsp;
            
            if (receiveMsg.statusCode == 200) {
                if (requestInterface.completionBlock) {
                    requestInterface.completionBlock(netRst);
                }
            }else if(requestInterface.failedBlock){
                requestInterface.failedBlock(netRst);
            }
            [objs addObject:requestInterface];
        }
    }
	
    if ([objs count]>0) {
        [_lock lock];
        [_requestList removeObjectsInArray:objs];
        [_lock unlock];
    }
    
	return 0;
}
@end
