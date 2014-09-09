//
//  KBJSONSerializing.m
//  DuDuChat
//
//  Created by jacky.ding on 14-5-6.
//  Copyright (c) 2014年 PalmWin. All rights reserved.
//

#import "KBJSONSerializing.h"

@implementation NSArray (KBJSONSerializing)


- (NSString*)JSONString

{
    
    NSError* error = nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    
    
    if (error != nil) {
        
        NSLog(@"NSArray JSONString error: %@", [error localizedDescription]);
        
        return nil;
        
    } else {
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
}

@end


@implementation NSDictionary (KBJSONSerializing)

- (NSString*)JSONString

{
    
    NSError* error = nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    
    
    if (error != nil) {
        
        NSLog(@"NSDictionary JSONString error: %@", [error localizedDescription]);
        
        return nil;
        
    } else {
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
}

@end


@implementation NSString (KBJSONSerializing)

- (id)JSONValue

{
    if (self.length == 0) {
        return nil;
    }
    
    NSError* error = nil;

    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                 
                                                options:kNilOptions
                 
                                                  error:&error];
    
    if (error != nil) {
        
        NSLog(@"NSString JSONObject error: %@", [error localizedDescription]);
        
    }
    
    return object;
    
}

@end