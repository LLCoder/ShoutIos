//
//  RequestInterfaceBase.m
//  dudu
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestInterfaceBase.h"
#import "Data_Struct.h"
#import "NetworkModel.h"

@interface RequestInterfaceBase(){

}

@end

@implementation RequestInterfaceBase

-(id)init{
	self = [super init];
	if (self) {
		_requestType = RequestTypeMsg;
		_cmdCode = CC_Unknown;
        _methodName = @"";
        _dataVersion = @"";
        _timeoutSeconds = HTTP_TIMEOUT;

        self.requestUrl = HttpRestUrlFormat;
        _requestHeaders = [[NSMutableDictionary alloc]initWithCapacity:0];
	}
	return self;
}

+ (NSDictionary *)errorDic{
    static NSDictionary * _errorDic = nil;
    if (nil == _errorDic) {
        
        NSString* path=[[NSBundle mainBundle] pathForResource:@"errorMsg" ofType:@"plist"];
        _errorDic =[[NSDictionary alloc]initWithContentsOfFile:path];
    }
    return _errorDic;
}

- (NSString *)requestUrl{
    return _requestUrl;
}

- (NSDictionary *)requestHeaders{
    return _requestHeaders;
}

- (NSDictionary *)requestDic{
    return nil;
}

- (NetBaseRst*)requestDecode:(id)recData{
    NetBaseRst *netBaseRst = [[NetBaseRst alloc]init];
    [RequestInterfaceBase decodeResults:netBaseRst recData:recData];

    netBaseRst.state =  self.statusCode;
	return netBaseRst;
}

- (int)run{
    return [[NetworkModel sharedInstance]sendRequest:self];
}

+ (void)decodeResults:(NetBaseRst*)netRst recData:(id)recData{
    if ((!ISDICTIONARYCLASS(recData))) {
        return;
    }
    
    netRst.requestCode = [[recData objectForKey:@"Result"] intValue];
    
}
@end
