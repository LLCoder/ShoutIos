//
//  RequestRanking.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestRanking.h"

@implementation RequestRanking
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_Ranking;
        self.methodName = @"Json/Ranking.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

@end
