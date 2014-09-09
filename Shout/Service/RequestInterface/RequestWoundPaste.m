//
//  RequestWoundPaste.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestWoundPaste.h"

@implementation RequestWoundPaste
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_WoundPaste;
        self.methodName = @"Json/WoundPaste.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberId ForKey:@"MemberId"];
    
    return urlBody.requestStr;
}
@end
