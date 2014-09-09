//
//  RequestRegister.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestRegister.h"

@implementation RequestRegister
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_Register;
        self.methodName = @"Json/Reg.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberTel ForKey:@"MemberTel"];
    [urlBody addElemValue:self.memberPWD ForKey:@"MemberPassword"];
    [urlBody addElemValue:self.memberName ForKey:@"MemberName"];
    
    return urlBody.requestStr;
}
@end
