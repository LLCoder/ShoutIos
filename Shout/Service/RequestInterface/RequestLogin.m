//
//  RequestLogin.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestLogin.h"

@implementation RequestLogin
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_Login;
        self.methodName = @"Json/login.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberTel ForKey:@"MemberTel"];
    [urlBody addElemValue:self.memberPWD ForKey:@"MemberPassword"];
    
    return urlBody.requestStr;
}

- (LoginRst*)requestDecode:(id)recData{
    LoginRst *loginRst = [[LoginRst alloc]init];
    [RequestInterfaceBase decodeResults:loginRst recData:recData];
    if (loginRst.requestCode > 0 && (loginRst.requestCode % 100 == 0)) {
        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            loginRst.memberId = [dicData objectForKey:@"MemberId"];
            loginRst.memberTel = [dicData objectForKey:@"MemberTel"];
            loginRst.memberName = [dicData objectForKey:@"MemberNam"];
        }
    }else if (self.statusCode == 404){
        loginRst.message = @"服务器异常";
    }else {
        loginRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(loginRst.requestCode)];
    }

	return loginRst;
}
@end
