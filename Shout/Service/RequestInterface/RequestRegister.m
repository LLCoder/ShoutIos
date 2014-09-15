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
        self.memberName = @"test";
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

- (RegisterRst *)requestDecode:(id)recData{
    RegisterRst *registerRst = [[RegisterRst alloc]init];
    [RequestInterfaceBase decodeResults:registerRst recData:recData];
    if (registerRst.requestCode > 0 && (registerRst.requestCode % 100 == 0)) {

        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            registerRst.memberId = [dicData objectForKey:@"MemberId"];
            registerRst.memberTel = [dicData objectForKey:@"MemberTel"];
            registerRst.memberName = [dicData objectForKey:@"MemberName"];
        }
    }else if (self.statusCode == 404){
        registerRst.message = @"服务器异常";
    }else {
        registerRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(registerRst.requestCode)];
    }
    
	return registerRst;
}
@end
