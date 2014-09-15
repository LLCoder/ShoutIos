//
//  RequestRanking.m
//  Shout
//
//  Created by shana on 14-9-8.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "RequestRanking.h"
#import "RankingEntity.h"

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

- (GetRankingsRst *)requestDecode:(id)recData{
    GetRankingsRst *rankingsRst = [[GetRankingsRst alloc]init];
    [RequestInterfaceBase decodeResults:rankingsRst recData:recData];
    if (rankingsRst.requestCode > 0 && (rankingsRst.requestCode % 100 == 0)) {
        NSDictionary *dicData = (NSDictionary *)recData;
        if (ISDICTIONARYCLASS(dicData)) {
            RankingEntity *ranking = [[RankingEntity alloc]init];
            [rankingsRst.rankings addObject:ranking];
//            woundPasteRst.woundPaste.ventId = [dicData objectForKey:@"VentId"];
//            woundPasteRst.woundPaste.ventShow = [dicData objectForKey:@"VentShow"];
//            woundPasteRst.woundPaste.ventColor = [dicData objectForKey:@"VentColor"];
//            woundPasteRst.woundPaste.ventClicks = [[dicData objectForKey:@"VentClicks"] intValue];
        }
    }else if (self.statusCode == 404){
        rankingsRst.message = @"服务器异常";
    }else {
        rankingsRst.message = [[RequestInterfaceBase errorDic]objectForKey:INTTOSTR(rankingsRst.requestCode)];
    }
    
	return rankingsRst;
}

@end
