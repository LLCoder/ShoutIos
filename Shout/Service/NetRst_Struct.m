//
//  NetRst_Struct.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetRst_Struct.h"
#import "SentenceEntity.h"
#import "WoundPasteEntity.h"

@implementation NetBaseRst

@end


@implementation LoginRst

-(void)dealloc{
    
}
@end

@implementation GetSentenceRst

- (instancetype)init{
    self = [super init];
    if (self) {
        _sentence = [[SentenceEntity alloc]init];
    }
    return self;
}

@end

@implementation GetWoundPasteRst

- (instancetype)init{
    self = [super init];
    if (self) {
        _woundPaste = [[WoundPasteEntity alloc]init];
    }
    return self;
}

@end

@implementation GetRankingsRst
- (instancetype)init{
    self = [super init];
    if (self) {
        _rankings = [[NSMutableArray alloc]initWithCapacity:5];
    }
    return self;
}

@end