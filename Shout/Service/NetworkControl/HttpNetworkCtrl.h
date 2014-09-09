//
//  HttpNetworkCtrl.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestInfoBase;
@interface HttpNetworkCtrl : NSObject

DEFINE_SINGLETON_FOR_HEADER(HttpNetworkCtrl)

// 返回request code
- (int)sendHttpRequest:(RequestInfoBase*)requestInfo;
- (void)cancelRequestFromDelegate:(id)requestDelegate;

- (void)cancelAllRequests;
@end
