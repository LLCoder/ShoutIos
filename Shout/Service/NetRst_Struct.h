//
//  NetRst_Struct.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetBaseRst;

typedef void (^BLNetworkBaseBlock)(NetBaseRst *netBaseRst);
typedef void (^BLNetworkFaildBlock)(NetBaseRst *netBaseRst);
typedef void (^BLNetworkProgressBlock)(double progress);

@interface NetBaseRst : NSObject

@property (nonatomic, assign) int cmdCode;
@property (nonatomic, assign) int requestCode;
@property (nonatomic, assign) int httpRsp;
@property (nonatomic, copy) NSString       *message;
@property(nonatomic,assign) BOOL		   state;		// 返回子数据是否成功
@property(nonatomic,assign) BOOL		   status;		// session是否失效
@end

@interface LoginRst : NetBaseRst
@property (nonatomic, strong)NSString     *memberId;
@property (nonatomic, strong)NSString     *memberTel;
@property (nonatomic, strong)NSString     *memberName;
@end

@interface RegisterRst : LoginRst

@end
//hendrike zhang
#pragma mark NetworkRecDelegete
@protocol NetworkRecDelegate<NSObject>

@required
- (int)reciveHttpRespondInfo:(NetBaseRst *)reciveMsg;

@end


