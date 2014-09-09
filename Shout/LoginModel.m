//
//  LoginModel.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "LoginModel.h"
#import "RequestLogin.h"
@interface LoginModel(){
    NSString *_memberId;
    NSString *_memberTel;
    NSString *_memberName;
}

@end

@implementation LoginModel
DEFINE_SINGLETON_FOR_CLASS(LoginModel)

- (NSString *)memberId{
    if (!ISEXISTSTR(_memberId)) {
        _memberId = [PublicFunction objFromUserDefaultWithKey:@"shout.memberid"];
    }
    return _memberId;
}

- (NSString *)memberTel{
    if (!ISEXISTSTR(_memberTel)) {
        _memberTel = [PublicFunction objFromUserDefaultWithKey:@"shout.membertel"];
    }
    return _memberTel;
}

- (NSString *)memberName{
    if (!ISEXISTSTR(_memberName)) {
        _memberName = [PublicFunction objFromUserDefaultWithKey:@"shout.membername"];
    }
    return _memberName;
}

- (void)saveLoginData:(LoginRst *)loginData{
    _memberId = loginData.memberId;
    [PublicFunction saveToUserDefault:_memberId withKey:@"shout.memberid"];
    
    _memberTel = loginData.memberTel;
    [PublicFunction saveToUserDefault:_memberTel withKey:@"shout.membertel"];
    
    _memberName = loginData.memberName;
    [PublicFunction saveToUserDefault:_memberName withKey:@"shout.membername"];
}

- (void)loginWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestLogin *login = [[RequestLogin alloc]init];
    login.memberTel = memberTel;
    login.memberPWD = pwd;
    login.completionBlock = ^(NetBaseRst *netBaseRst) {
        LoginRst *loginData = (LoginRst *)netBaseRst;
        [self saveLoginData:loginData];

    };
    
    login.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }

    };
    
    [login run];
}


@end
