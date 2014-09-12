//
//  NetworkModel.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestInfo.h"

@class RequestInterfaceBase;
@interface NetworkModel : NSObject<HTTP_REC_RESPOND>

DEFINE_SINGLETON_FOR_HEADER(NetworkModel)

- (int)sendRequest:(RequestInterfaceBase*)request;
- (void)removeAllReuest:(id)requestDelegate;
- (void)cancelAllRequests;
@end