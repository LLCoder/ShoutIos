//
//  RequestInfo.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestInfo.h"


@implementation RequestInfoBase

-(id)init{
	self = [super init];
	if (self) {
		_requestType = RequestTypeUnknown;
		_cmdCode = CC_Unknown;
		_recData = [[NSMutableData alloc] init];
	}
	return self;
}

- (BOOL)isPost{
    BOOL result = NO;
    if (ISDICTIONARYCLASS(self.requestDic) && self.requestDic.count > 0) {
        result = YES;
    }
    return result;
}

@end


