//
//  HttpNetworkCtrl.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HttpNetworkCtrl.h"
#import "ASINetworkQueue.h"
#import "AppRequest.h"
#import "RequestInfo.h"
#import "PublicFunction.h"
#import "MsgConstant.h"


#define GETWORKQUEUE(workQueue) 	\
workQueue = [[ASINetworkQueue alloc] init];\
[workQueue reset];\
[workQueue setDelegate:self];\
[workQueue setRequestDidFinishSelector:@selector(operationFinished:)];\
[workQueue setRequestDidFailSelector:@selector(operationFailed:)];\
[workQueue setShouldCancelAllRequestsOnFailure:NO];\
[workQueue setMaxConcurrentOperationCount:3];\

#define WORKQUEQUEADDREQ(netWorkQueue,request,requestInfo)\
[request setReqInfo:requestInfo];\
request.tag = requestCode;\
[netWorkQueue addOperation:request];\
[netWorkQueue go];\

#define CANCEL_REQUEST_WITH_DELEGATE(delegate,reuqestCountDic,workQueue)\
    for (MsgRequest *msgReq in [workQueue operations]) {\
        [_workQueueMsg setShouldCancelAllRequestsOnFailure:NO];\
        if (delegate == msgReq.modelDelegage) {\
            [msgReq clearDelegatesAndCancel];\
            [reuqestCountDic removeObjectForKey:@(msgReq.tag)];\
        }\
    }\


@interface HttpNetworkCtrl()<ASIHTTPRequestDelegate>{
    NSLock*			     _lock;
	ASINetworkQueue*     _workQueueMsg;
	ASINetworkQueue*     _workQueueUpload;
    ASINetworkQueue*     _workQueueDownloadCur;
    
    NSMutableDictionary* _dicRequestCount;
    NSMutableDictionary* _dicUploadCount;
    NSMutableDictionary* _dicDownloadCount;
}

-(void)operationFinished:(ASIHTTPRequest *)request;

-(void)operationFailed:(ASIHTTPRequest *)request;

-(int)getTagCode:(int)cmdCode;
-(int)getCmdcode:(int)tagCode;

@end

@implementation HttpNetworkCtrl

DEFINE_SINGLETON_FOR_CLASS(HttpNetworkCtrl)

-(id)init{
	self = [super init];
	if (self != nil) {
		GETWORKQUEUE(_workQueueMsg);
		
		GETWORKQUEUE(_workQueueUpload);
        
        GETWORKQUEUE(_workQueueDownloadCur);
        [_workQueueDownloadCur setMaxConcurrentOperationCount:1];
		_lock = [[NSLock alloc] init];
        
        _dicDownloadCount = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        _dicRequestCount = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        _dicUploadCount = [[NSMutableDictionary alloc]initWithCapacity:0];
        
	}
	return self;
}


-(void)dealloc{

}

-(int)sendHttpRequest:(RequestInfoBase*)requestInfo{
	if (nil == requestInfo) {
		return -1;
	}
	
	int requestCode = [self getTagCode:requestInfo.cmdCode];
	
	int reqType = requestInfo.requestType;
	
	switch (reqType) {
		case RequestTypeMsg:{
			MsgRequest *msgRequest = [[MsgRequest alloc]initWithURL:[NSURL URLWithString:[requestInfo.requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
			WORKQUEQUEADDREQ(_workQueueMsg,msgRequest,requestInfo);
			break;
		}

		default:
			break;
	}
	return requestCode;
}

- (void)operationFailed:(ASIHTTPRequest *)request
{
    NSInteger codeid = [[request error] code];
	NSLog(@"---RequestDidFailed---\n redID = %d, errorID = %d\n", request.tag, codeid);
    
    RequestInfoBase *requestInfo = nil;
	MsgRequest *baseRequest = (MsgRequest *)request;
	int requestType = baseRequest.requestType;
    switch (requestType) {
		case RequestTypeMsg:{
            NSNumber *requestCount = (NSNumber *)[_dicRequestCount objectForKey:@(baseRequest.tag)];
            int count = 0;
            if (requestCount) {
                count = requestCount.intValue;
            }
            
            if (count < 1 && baseRequest.responseStatusCode != 401) {
                [_dicRequestCount setObject:@(count+1) forKey:@(baseRequest.tag)];
                [self performSelector:@selector(reRequestMsg:) withObject:baseRequest afterDelay:0.5];
                return;
            }
            requestInfo = [[RequestInfoBase alloc]init];
            break;
        }
            
		default:
			break;
	}
    NSLog(@"the error is %@",request.error.description);
    requestInfo.statusCode = baseRequest.responseStatusCode;
	requestInfo.requestType = baseRequest.requestType;
	requestInfo.requestCode = baseRequest.tag;
	requestInfo.cmdCode = [self getCmdcode:baseRequest.tag];
	requestInfo.delegate = baseRequest.modelDelegage;
	
    
	//取内容与请求
	switch (codeid) {
		case ASIConnectionFailureErrorType:{
			
			requestInfo.httpRsp = E_HTTPERR_NETCLOSE ;
			
			break;
		}
		case ASIRequestTimedOutErrorType:{
			
			requestInfo.httpRsp = E_HTTPERR_TIMEOUT ;
			
			break;
		}
		case ASIAuthenticationErrorType:{
			
			requestInfo.httpRsp = E_HTTPERR_AUTH ;
			break;
		}
		case ASIRequestCancelledErrorType:{
			
			requestInfo.httpRsp = E_HTTPERR_CANCEL ;
			break;
		}
		case ASIUnableToCreateRequestErrorType:{
			
			requestInfo.httpRsp = E_HTTPERR_UNABLECREATE ;
			break;
		}
		default:{
			requestInfo.httpRsp = E_HTTPERR_UNKONW ;
			break;
		}
			
	}
    
	if (requestInfo.delegate
		&& [requestInfo.delegate respondsToSelector:@selector(reciveHttpRespond:)]) {
		
		[requestInfo.delegate  reciveHttpRespond:requestInfo];
	}
}

- (void)reRequestMsg:(MsgRequest *)baseRequest{
    MsgRequest *msgRequest = [[MsgRequest alloc]initWithURL:baseRequest.url];
    [msgRequest setInfoWithRequest:baseRequest];
    [_workQueueMsg addOperation:msgRequest];
    [_workQueueMsg go];
}


- (void)operationFinished:(ASIHTTPRequest *)request
{
	RequestInfoBase *requestInfo = nil;
	MsgRequest *baseRequest = (MsgRequest *)request;
	int requestType = baseRequest.requestType;
    
	switch (requestType) {
		case RequestTypeMsg:{
            NSData* tempData = [baseRequest responseData];
			
			requestInfo = [[RequestInfoBase alloc]init];
			if (nil == tempData) {
				
			}
			else {
				char tch = 0 ;
				[requestInfo.recData setData:tempData];
				[requestInfo.recData appendBytes: &tch length:1] ;
			}
        }
            
		default:
			break;
	}
    
    requestInfo.timeStamp = [request.responseHeaders objectForKey:@"timestamp"];
	requestInfo.statusCode = request.responseStatusCode;
	requestInfo.requestType = baseRequest.requestType;
	requestInfo.requestCode = baseRequest.tag;
	requestInfo.cmdCode = [self getCmdcode:baseRequest.tag];
	requestInfo.delegate = baseRequest.modelDelegage;
	
	if (requestInfo.delegate
		&& [requestInfo.delegate respondsToSelector:@selector(reciveHttpRespond:)]) {
		[requestInfo.delegate reciveHttpRespond:requestInfo];
	}
}


-(int)getTagCode:(int)cmdCode{
	static unsigned short int curCode= 0x0001;
	int returnCode = (curCode & 0x0000ffff);
	returnCode |=  cmdCode << 16 & 0xffff0000;
	[_lock lock];
	curCode++;
	if (0xffff == curCode) {
		curCode = 0x0001;
	}
	
	[_lock unlock];
	return returnCode;
}

-(int)getCmdcode:(int)tagCode{
	int returnCode = tagCode >>16 & 0x0000ffff;
	return returnCode;
}

- (void)cancelRequestFromDelegate:(id)requestDelegate
{
    if (nil == requestDelegate) {
        return;
    }
    
    CANCEL_REQUEST_WITH_DELEGATE(requestDelegate,_dicRequestCount,_workQueueMsg);
    
}



- (void)cancelAllRequests{
    _workQueueDownloadCur.downloadProgressDelegate = nil;
    [_workQueueMsg cancelAllOperations];
    [_workQueueUpload cancelAllOperations];
    [_workQueueDownloadCur cancelAllOperations];
    
    [_dicDownloadCount removeAllObjects];
    [_dicRequestCount removeAllObjects];
}
@end
