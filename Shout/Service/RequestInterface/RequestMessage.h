//
//  RequestMessage.h
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestInterfaceBase.h"

@interface RequestMessage : RequestInterfaceBase
@property (nonatomic, strong)NSString *memberId;
@property (nonatomic, strong)NSString *ventShow;
@property (nonatomic, strong)NSString *ventColor;
@end
