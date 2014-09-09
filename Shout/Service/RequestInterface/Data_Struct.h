//
//  Data_Struct.h
//  Showcase
//
//  Created by jianlong ding on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum tagRegisterType
{
    ACCOUNT_REGISTER_TYPE = 0,
    DEVICE_REGISTER_TYPE,
    UNKNOW_REGISTER_TYPE = -1
}RegisterType;

typedef enum tagDeviceType
{
    IOS_DEVICE_TYPE = 1,
    ANDROID_DEVICE_TYPE,
    UNKNOW_DEVICE_TYPE = -1
}DeviceType;

typedef enum tagSQLStatus
{
    SQL_ADD_STATUS = 1,
    SQL_UPDATE_STATUS,
    SQL_DEL_STATUS = -1
}SQLStatus;

#pragma mark 服务器ip与port信息
@interface ServerInfo: NSObject
@property (nonatomic, copy)NSString      *strIP;
@property (nonatomic, assign)NSInteger   httpPort;
@property (nonatomic, copy)NSString      *websiteServer;
@end

@interface RequestElem : NSObject
@property (nonatomic ,copy)NSString     *strKey;
@property (nonatomic ,copy)NSString     *strValue;
@property (nonatomic ,readonly)NSString *elemStr;

- (id)initWithValue:(NSString *)value ForKey:(NSString *)key;
@end

@interface RequestUrlBody : NSObject
@property (nonatomic, copy)NSString     *strHead;
@property (nonatomic, readonly)NSString *requestStr;

- (id)initWithRequestHead:(NSString *)head;
- (BOOL)addElemValue:(NSString *)value ForKey:(NSString *)key;
@end

@interface RequestPostBody : NSObject
@property (nonatomic, readonly)NSDictionary *requestDic;
- (BOOL)addElemValue:(NSString *)value ForKey:(NSString *)key;
@end
