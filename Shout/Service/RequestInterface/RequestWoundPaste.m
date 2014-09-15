//
//  RequestWoundPaste.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestWoundPaste.h"
#import "WoundPasteEntity.h"

@implementation RequestWoundPaste
-(id)init{
	self = [super init];
	if (self != nil) {
		self.cmdCode = CC_WoundPaste;
        self.methodName = @"Json/WoundPaste.asp";
        
        self.requestUrl = [[super requestUrl] stringByAppendingString:self.methodName];
	}
	return self;
}

- (NSString *)requestUrl{
    RequestUrlBody *urlBody = [[RequestUrlBody alloc]initWithRequestHead:[super requestUrl]];
    [urlBody addElemValue:self.memberId ForKey:@"MemberId"];
    
    return urlBody.requestStr;
}

- (GetWoundPasteRst *)requestDecode:(id)recData{
    GetWoundPasteRst *woundPasteRst = [[GetWoundPasteRst alloc]init];
    [RequestInterfaceBase decodeResults:woundPasteRst recData:recData];
    if (woundPasteRst.requestCode > 0 && (woundPasteRst.requestCode % 100 == 0)) {
        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            woundPasteRst.woundPaste.ventId = [dicData objectForKey:@"VentId"];
            woundPasteRst.woundPaste.ventShow = [dicData objectForKey:@"VentShow"];
            woundPasteRst.woundPaste.ventColor = [dicData objectForKey:@"VentColor"];
            woundPasteRst.woundPaste.ventClicks = [[dicData objectForKey:@"VentClicks"] intValue];
        }
    }else if (self.statusCode == 404){
        woundPasteRst.message = @"服务器异常";
    }else {
        woundPasteRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(woundPasteRst.requestCode)];
    }
    
	return woundPasteRst;
}
@end
