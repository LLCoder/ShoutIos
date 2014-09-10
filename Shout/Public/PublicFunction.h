//
//  PublicFunction.h
//  dudu
//
//  Created by jacky.ding on 12-8-15.
//  Copyright (c) 2012年 wisedu. All rights reserved.
//

extern void dispatch_execute_in_worker_queue(dispatch_block_t block);
extern void dispatch_execute_in_worker_queue_after(int64_t delay, dispatch_block_t block);

extern void dispatch_execute_in_main_queue(dispatch_block_t block);
extern void dispatch_execute_in_main_queue_after(int64_t delay, dispatch_block_t block);

extern struct CGRect CGBoundFromRect(CGRect rect);

@interface PublicFunction : NSObject
//通过域名获取ip地址
+ (NSString *) getIPWithHostName:(const NSString *)hostName;

+ (void)ImageViewFitImg:(UIView *)imgView Img:(UIImage *)img;

+ (BOOL)isRetinaDisplay;

+ (NSString *)stringRemoveTag:(NSString*)strSource StrTag:(NSString *)tag;

+ (NSArray *)rangeArryOfString:(NSString *)strSrc subString:(NSString *)subString;

+ (void)clearUserDefault;

+ (NSTimeInterval)currentTimeInterval;

+ (UIImage *)resizeImage:(UIImage *)image WithCapInsets:(UIEdgeInsets)capInsets;

+ (UIImage*)convertImage:(UIImage*)srcImage Size:(CGSize)size;

+ (UIImage *)cropImage:(UIImage *)img withSize:(CGSize)toSize;

+ (BOOL)isContainChinese:(NSString*)strName;

+ (NSTimeInterval)getDiffTime:(NSString *) time;

+ (void)showActivityIndicatorInView:(UIView *)view;

+ (void)stopActivityIndicatorInView:(UIView *)view;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

// 其实只校验中国的手机
+ (BOOL)mobilePhoneNumCheck:(NSString *)phoneNum;

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL) validatePwd:(NSString *)pwd;

+ (BOOL) validateQQ:(NSString *)pwd;

+ (BOOL)validateNickName:(NSString *)nickName;

+ (BOOL)urlCheck:(NSString *)urlStr;

+ (UIColor*)colorFromRGB:(NSInteger)rgbValue andAlpha:(float)alpha;


//get unique string for file name
+ (NSString *) uniqueString;

//保存到user default,若为空，则清除掉，注意判空！！！
+ (void)saveToUserDefault:(id)obj withKey:(NSString *)key;

//从user default 获取对象
+ (id)objFromUserDefaultWithKey:(NSString *)key;

//从user default 删除对象
+ (void)removeOjbFromUserDefaultWithKey:(NSString *)key;

+ (CGFloat)reservedEffective:(CGFloat)f digital:(NSInteger)d;

//格式化时间对象为字符串，格式为"yyyy-MM-dd HH:mm:ss"
+ (NSString *)timeStringWithNormalFormatter:(NSDate *)date;

@end
