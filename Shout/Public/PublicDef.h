//
//  PublicDef.h
//  seu
//
//  Created by shana on 14-7-19.
//  Copyright (c) 2014年 wisedu. All rights reserved.
//

#ifndef seu_PublicDef_h
#define seu_PublicDef_h

// HTTP Server 地址
#define HttpRestUrlFormat           @"http://www.51vent.com/"

#pragma mark - 资源
#define DOCUMENTS                   @"Documents"
#define DOCUMENT_FOLDER             [NSHomeDirectory() stringByAppendingPathComponent:DOCUMENTS]

#pragma mark -
#pragma mark macro

//界面宽高
#define BatteryHeight 20.0
#define NavBarHeight  44.0
#define TabBarHeight  49.0

#define kRecordSampleRate	8000.0f		//录音时的采样频率

#define kPage_Size 20

#define kTrackLimit 30

#define kIMSystemUser 1000 //指定的系统消息用户, im使用

#define kIMFeedbackUser  1001 //指定的意见反馈用户, im使用

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kShareLinkPre @"http://txbang.me"

#define kColorDuDuChatBlue     [UIColor colorWithHexString:@"49bdcc"]
#define kColorDuDuChatGreen    [UIColor colorWithHexString:@"c5e945"]
#define kColorDuDuChatRed      [UIColor colorWithHexString:@"ff4040"]

#define HEART_BEAT_FREQUENCY 180
#define LOCATION_REFRESH_FREQUENCY 20

#define IMAGE_NAME_WITH_ID(imageId) (imageId) ? [imageId stringByAppendingString:IMAGE_EXTENSION]:@""
#define THUMB_IMAGE_WITH_ID(imageId) (imageId) ? [imageId stringByAppendingString:THUMB_EXTENSION]:@""

#define iPhoneHight ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) ? 568 : 480) : 480)

#define viewDisPlayHeight [UIScreen mainScreen].applicationFrame.size.height

#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IOS6_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define TABBARTRAMEOY (IOS7_OR_LATER? viewDisPlayHeight-29:iPhoneHight-49)

#if NS_BLOCKS_AVAILABLE
typedef void (^BLBasicBlock)(void);
#endif



#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])  //应用程序版本号
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]   //ios系统版本号

#define kScreenScale                ([UIScreen instancesRespondToSelector:@selector(scale)]?[[UIScreen mainScreen] scale]:(1.0f))

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0]) //语言

#define INTTOSTR(intNum)         [@(intNum) stringValue]
#define LONGTOSTR(longNum)       [@(longNum) stringValue]
#define DOUBLETOSTR(doubleNum)   [NSString stringWithFormat:@"%.2lf",doubleNum]

#define COPYSTR(srcStr)          (nil == (srcStr)) ? @"" :[NSString stringWithString:srcStr]
#define COPYARY(srcAry)          (nil == (srcAry)) ? [NSMutableArray array]:[NSMutableArray arrayWithArray:srcAry]

#define ReplaceNULL2Empty(str)   ((nil == (str)) ? @"" : (str))
#define ISNIL(obj)               (nil == (obj) || [obj isEqual:[NSNull null]])
#define CLASSSTR(className)      NSStringFromClass([className class])

#define ISNULLCLASS(variable)    ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNull class]])
#define ISDICTIONARYCLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSDictionary class]]))
#define ISARRYCLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSArray class]]))
#define ISNUMBERCLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNumber class]]))
#define OBJTOINT(obj)         ISNUMBERCLASS((obj)) ? ((NSNumber *)(obj)).intValue : 0
#define OBJTODOUBLE(obj)      ISNUMBERCLASS((obj)) ? ((NSNumber *)(obj)).doubleValue : 0

#define ISEXISTSTR(str) ((nil != (str)) &&([(str) isKindOfClass:[NSString class]]) && (((NSString *)(str)).length > 0))


#define TRIM(str)   [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

#define STRHASSBUSTR(str,subStr) ((nil != (str)) && (nil != (subStr)) && ([(str) rangeOfString:(subStr) options:NSCaseInsensitiveSearch].location != NSNotFound))

#define DOUBLETODATE(value)  [NSDate dateWithTimeIntervalSince1970:value]

#if ! __has_feature(objc_arc)
#define SAFERELEASE(obj)     if(obj){[obj release]; obj = nil;}
#else
#define SAFERELEASE(obj)     obj = nil;
#endif

#if ! __has_feature(objc_arc)
#define SAFE_RELEASE_TIMER(timer) \
if (timer && [timer isValid]) {\
[timer invalidate];\
[timer release];\
timer = nil;\
}
#else
#define SAFE_RELEASE_TIMER(timer) \
if (timer && [timer isValid]) {\
[timer invalidate];\
timer = nil;\
}
#endif

#define POINT2NUMBER(point)     @((long)point)
#define NUMBER2POINT(number)    (id)[number longValue]

#define kScreenIs4InchRetina        (([UIScreen mainScreen].scale == 2.0f) && (SCREEN_HEIGHT == 568.0f))

#define SYSTEM_VERSION_EQUAL_TO (v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define kSystemVersion              [[UIDevice currentDevice] systemVersion]
#define kSystemVersionPriorToIOS6   ([kSystemVersion compare:@"6.0" options:NSNumericSearch range:NSMakeRange(0, 3)] == NSOrderedAscending)
#define kSystemVersionPriorToIOS7   ([kSystemVersion compare:@"7.0" options:NSNumericSearch range:NSMakeRange(0, 3)] == NSOrderedAscending)
#define kSystemVersionReachesIOS7   ([kSystemVersion compare:@"7.0" options:NSNumericSearch range:NSMakeRange(0, 3)] != NSOrderedAscending)

#pragma mark -

#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
@synchronized(self){ \
shared##className = [[self alloc] init]; \
} \
}); \
return shared##className; \
}

#endif
