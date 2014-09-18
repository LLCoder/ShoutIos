//
//  LoginModel.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "LoginModel.h"
#import "RequestLogin.h"
#import "RequestRegister.h"

#define k_shoutMemberId     @"shout.memberid"
#define k_shoutMemberTel     @"shout.membertel"
#define k_shoutMemberName     @"shout.membername"

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
        _memberId = [PublicFunction objFromUserDefaultWithKey:k_shoutMemberId];
    }
    return _memberId;
}

- (NSString *)memberTel{
    if (!ISEXISTSTR(_memberTel)) {
        _memberTel = [PublicFunction objFromUserDefaultWithKey:k_shoutMemberTel];
    }
    return _memberTel;
}

- (NSString *)memberName{
    if (!ISEXISTSTR(_memberName)) {
        _memberName = [PublicFunction objFromUserDefaultWithKey:k_shoutMemberName];
    }
    return _memberName;
}


- (void)saveLoginData:(LoginRst *)loginData{
    _memberId = loginData.memberId;
    [PublicFunction saveToUserDefault:_memberId withKey:k_shoutMemberId];
    
    _memberTel = loginData.memberTel;
    [PublicFunction saveToUserDefault:_memberTel withKey:k_shoutMemberTel];
    
    _memberName = loginData.memberName;
    [PublicFunction saveToUserDefault:_memberName withKey:k_shoutMemberName];
}

- (void)loginWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestLogin *login = [[RequestLogin alloc]init];
    login.memberTel = memberTel;
    login.memberPWD = pwd;
    login.completionBlock = ^(NetBaseRst *netBaseRst) {
        LoginRst *loginData = (LoginRst *)netBaseRst;
        [self saveLoginData:loginData];

        if (resultBlock) {
            resultBlock(nil);
        }
    };
    
    login.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }

    };
    
    [login run];
}

- (void)registerWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestRegister *reqRegister = [[RequestRegister alloc]init];
    reqRegister.memberTel = memberTel;
    reqRegister.memberPWD = pwd;
    reqRegister.completionBlock = ^(NetBaseRst *netBaseRst) {
        RegisterRst *registerData = (RegisterRst *)netBaseRst;
        [self saveLoginData:registerData];
        
        if (resultBlock) {
            resultBlock(nil);
        }
    };
    
    reqRegister.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }
        
    };
    
    [reqRegister run];
}
@end
