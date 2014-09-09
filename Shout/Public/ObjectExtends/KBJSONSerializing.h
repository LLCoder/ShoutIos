//
//  KBJSONSerializing.h
//  DuDuChat
//
//  Created by jacky.ding on 14-5-6.
//  Copyright (c) 2014年 PalmWin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KBJSONSerializing)

- (NSString*)JSONString;

@end


@interface NSDictionary (KBJSONSerializing)

- (NSString*)JSONString;

@end


@interface NSString (KBJSONSerializing)

- (id)JSONValue;

@end
