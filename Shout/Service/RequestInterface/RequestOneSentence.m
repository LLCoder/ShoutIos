//
//  RequestOneSentence.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestOneSentence.h"

@implementation RequestOneSentence
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_OneSentence;
        self.methodName = @"Json/OneSentence.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}
@end
