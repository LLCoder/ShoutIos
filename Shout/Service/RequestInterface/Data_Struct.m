//
//  Data_Struct.m
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Data_Struct.h"

@implementation ServerInfo

@end

@implementation RequestElem

- (id)initWithValue:(NSString *)vaue ForKey:(NSString *)key{
    self = [super init];
    if (self) {
        self.strValue = vaue;
        self.strKey = key;
    }
    return self;
}

-(NSString *)elemStr{
    NSString *result = nil;
    
    if ((nil != self.strKey) && (nil != self.strValue)) {
        result = [[NSString alloc]initWithFormat:@"%@=%@",self.strKey,self.strValue];
    }
    return result;
}

@end

@interface RequestUrlBody(){
    NSMutableArray *_aryElem;
}

@end

@implementation RequestUrlBody

- (id)init{
    self = [super init];
    
    if (self) {
        _aryElem = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return self;
}

- (id)initWithRequestHead:(NSString *)head{
    self = [self init];
    if (self) {
        
        if (ISEXISTSTR(head)) {
            _strHead = head;
        }
    }
    return self;
}

- (BOOL)addElemValue:(NSString *)value ForKey:(NSString *)key{
    BOOL result = NO;
    if (ISEXISTSTR(value) && ISEXISTSTR(key)) {
        RequestElem *element = [[RequestElem alloc]initWithValue:value ForKey:key];
        [_aryElem addObject:element];
        result = YES;
    }
    
    return result;
}

-(NSString *)requestStr{
    NSString *strResult = nil;
    if (ISEXISTSTR(_strHead)) {
        strResult = [NSString stringWithString:_strHead];
    }
    
    for (RequestElem *element in _aryElem) {
        if (0 == [_aryElem indexOfObject:element]) {
            strResult = [strResult stringByAppendingString:@"?"];
        }else{
            strResult = [strResult stringByAppendingString:@"&"];
        }
        strResult = [strResult stringByAppendingString:element.elemStr];
    }

    return  strResult;
}
@end

@interface RequestPostBody(){
    NSMutableDictionary *_dicElem;
}

@end
@implementation RequestPostBody
- (id)init{
    self = [super init];
    
    if (self) {
        _dicElem = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    
    return self;
}

- (BOOL)addElemValue:(NSString *)value ForKey:(NSString *)key{
    BOOL result = NO;
    if (ISEXISTSTR(value) && ISEXISTSTR(key)) {
        [_dicElem setObject:value forKey:key];
        result = YES;
    }
    
    return result;
}

-(NSDictionary *)requestDic{
    return  _dicElem;
}
@end