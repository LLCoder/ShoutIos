//
//  LoginModel.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "LoginModel.h"
#import "RequestLogin.h"

@implementation LoginModel
DEFINE_SINGLETON_FOR_CLASS(LoginModel)

- (void)loginWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock{
    RequestLogin *login = [[RequestLogin alloc]init];
    login.memberTel = memberTel;
    login.memberPWD = pwd;
    login.completionBlock = ^(NetBaseRst *netBaseRst) {

    };
    
    login.failedBlock = ^(NetBaseRst *netBaseRst) {
        if (resultBlock) {
            resultBlock(netBaseRst.message);
        }

    };
    
    [login run];
}
@end
