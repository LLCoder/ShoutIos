//
//  LoginModel.h
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
@property (nonatomic, readonly)NSString     *memberId;
@property (nonatomic, readonly)NSString     *memberTel;
@property (nonatomic, readonly)NSString     *memberName;

DEFINE_SINGLETON_FOR_HEADER(LoginModel)

- (void)loginWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock;

- (void)registerWithMemberTel:(NSString *)memberTel password:(NSString *)pwd resultBlock:(void(^)(NSString * errorStr)) resultBlock;

- (NSString *)memberTel;
- (NSString *)memberId;
@end
