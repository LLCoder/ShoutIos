//
//  RequestRegister.h
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestInterfaceBase.h"

@interface RequestRegister : RequestInterfaceBase
@property (nonatomic, strong)NSString *memberTel;
@property (nonatomic, strong)NSString *memberPWD;
@property (nonatomic, strong)NSString *memberName;
@end
