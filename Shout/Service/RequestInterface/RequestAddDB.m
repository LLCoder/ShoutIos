//
//  RequestAddDB.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestAddDB.h"

@implementation RequestAddDB
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_AddDB;
        self.methodName = @"Json/AddDB.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberId ForKey:@"MemberId"];
    [urlBody addElemValue:self.memberDB ForKey:@"MemberDB"];
    return urlBody.requestStr;
}
@end
