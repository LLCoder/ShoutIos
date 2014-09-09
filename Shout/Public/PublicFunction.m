//
//  PublicFunction.m
//  dudu
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 wisedu. All rights reserved.
//
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "PublicFunction.h"
#include <sys/socket.h>

#include <net/if.h>
#include <net/if_dl.h>
#import <sys/xattr.h>
#import <CoreMedia/CMTime.h>
#include <netdb.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "PublicDef.h"


#define kActivityViewTag 554433


void dispatch_execute_in_worker_queue(dispatch_block_t block)
{
    dispatch_queue_t workerQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(workerQueue, block);
}


void dispatch_execute_in_main_queue(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    }
    else  {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}


void dispatch_execute_in_main_queue_after(int64_t delay, dispatch_block_t block)
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

void dispatch_execute_in_worker_queue_after(int64_t delay, dispatch_block_t block)
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}


CGRect CGBoundFromRect(CGRect rect)
{
    return CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}

@implementation PublicFunction

+ (NSString *) getIPWithHostName:(const NSString *)hostName
{
    const char *hostN= [hostName UTF8String];
    struct hostent* phot;
    
    @try {
        phot = gethostbyname(hostN);
        
        if (phot == NULL || phot->h_addr_list == NULL || *(phot->h_addr_list) == NULL) {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phot->h_addr_list[0], 4);
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    
    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
    return strIPAddress;
}

//Stretch image with insets
+ (UIImage *)resizeImage:(UIImage *)image WithCapInsets:(UIEdgeInsets)capInsets {

    return [image resizableImageWithCapInsets:capInsets];
}

+(UIImage*)convertImage:(UIImage*)srcImage Size:(CGSize)size{
    
    if (nil == srcImage) {
        
        return nil;
    }
    
    CGSize destSize = size;
    UIImage *resultImg = nil;
    int h = srcImage.size.height;
    int w = srcImage.size.width;
    if(h <= destSize.height && w <= destSize.width)
    {
        resultImg = srcImage;
    }
    else
    {
        float b = (float)destSize.width/w < destSize.height/h ? destSize.width/w : destSize.height/h;
        
        CGSize itemSize = CGSizeMake(ceilf(b*w), ceilf(b*h));
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, ceilf(b*w), ceilf(b*h));
        [srcImage drawInRect:imageRect];
        resultImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return resultImg;
}
+ (UIImage *)cropImage:(UIImage *)img withSize:(CGSize)toSize
{
    @autoreleasepool {
        UIImage *timg = img;
        if (img.size.width > 0.0f &&
            img.size.height > 0.0f &&
            toSize.width > 0.0f &&
            toSize.height > 0.0f)
        {
            CGFloat scaleImage = img.size.width/img.size.height;
            CGFloat scaleView = toSize.width/toSize.height;
            CGSize cropSize = CGSizeZero;
            if (scaleImage > scaleView)
            {
                cropSize.height = img.size.height;
                cropSize.width = img.size.height * scaleView;
                
                UIGraphicsBeginImageContextWithOptions(cropSize, NO, [UIScreen mainScreen].scale);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                
                CGContextTranslateCTM(ctx, 0.0, cropSize.height);
                CGContextScaleCTM(ctx, 1.0, -1.0);
                CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
                // Draw view into context
                CGRect drawRect = CGRectMake(0.0f - (img.size.width - cropSize.width)/2.0f, 0.0f - (img.size.height - cropSize.height)/2.0f, img.size.width, img.size.height);
                CGContextDrawImage(ctx, drawRect, img.CGImage);
                timg = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
            }
            else if (scaleImage < scaleView)
            {
                cropSize.width = img.size.width;
                cropSize.height = cropSize.width / scaleView;
                
                UIGraphicsBeginImageContextWithOptions(cropSize, NO, [UIScreen mainScreen].scale);
                
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                
                CGContextTranslateCTM(ctx, 0.0, cropSize.height);
                CGContextScaleCTM(ctx, 1.0, -1.0);
                CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
                
                CGRect drawRect = CGRectMake(0.0f - (img.size.width - cropSize.width)/2.0f, 0.0f - (img.size.height - cropSize.height)/2.0f , img.size.width, img.size.height);
                CGContextDrawImage(ctx, drawRect, img.CGImage);
                timg = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
            }
        }
        return timg;
    }

}

+(void)ImageViewFitImg:(UIImageView *)imgView Img:(UIImage *)img{
    
    if (nil == imgView) {
        
        return;
    }
    
    imgView.image = img;
    
    if (img.size.width < imgView.frame.size.width && img.size.height < imgView.frame.size.height)
    {
        if (imgView.contentMode != UIViewContentModeCenter)
        {
            [imgView setContentMode:UIViewContentModeCenter];
        }
    }
    else if (imgView.contentMode != UIViewContentModeScaleAspectFit)
    {
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
    }
}

+ (BOOL)isRetinaDisplay
{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))? YES : NO;
}


+ (NSString *)stringRemoveTag:(NSString*)strSource StrTag:(NSString *)tag{
    if ((nil == strSource) || (nil == tag)) {
        return nil;
    }
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSArray *ary = [strSource componentsSeparatedByString:tag];
    for (int i = 0; i < ary.count; i++) {
        [result appendString:[ary objectAtIndex:i]];
    }
    return result;
}

+ (NSArray *)rangeArryOfString:(NSString *)strSrc subString:(NSString *)subString{
    if (!ISEXISTSTR(strSrc) || !ISEXISTSTR(subString)) {
        return nil;
    }
    
    //先转换为小写
    NSString *lowerCaseSrc = [strSrc lowercaseString];
    NSString *lowerCaseSub = [subString lowercaseString];
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]initWithCapacity:5];
    NSArray *separateArry = [lowerCaseSrc componentsSeparatedByString:lowerCaseSub];
    if (nil == separateArry || separateArry.count == 1) {
        return nil;
    }
    
    //游标
    int point = 0;
    for (int i = 0; i< separateArry.count-1; i++) {
        //先加上前面的长度
        point += [[separateArry objectAtIndex:i] length];
        
        NSRange range = NSMakeRange(point,subString.length);
        [resultArry addObject:[NSValue valueWithRange:range]];
        
        //加上字符串的长度
        point += subString.length;
    }
    return resultArry;
}

+ (void)clearUserDefault{
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults]dictionaryRepresentation];
    
    for (NSString *key in [defaultsDictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSTimeInterval)currentTimeInterval{
    return [[NSDate date] timeIntervalSince1970];
}

+(BOOL)isContainChinese:(NSString*)strName{
	if(nil == strName || 0 == [strName length])
		return NO;
	
	for(int i = 0; i < [strName length]; ++i){
		NSString *character = [strName substringWithRange:NSMakeRange(i, 1)];
		
		//
		Byte *p = (Byte *)[character UTF8String];
		int mark = p[0]>>7&1;
		
		if(1 == mark){
			//NSLog(@"%@ is chanise",character);
			return YES;
		}
	}
	return NO;
}

+(NSTimeInterval)getDiffTime:(NSString *) time{
	if (nil == time) {
		return -1;
	}
	NSString *formatStr = [NSString stringWithFormat:@"yyyy-MM-dd %@",time];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatStr];
	NSString *localstring=[formatter stringFromDate: [NSDate date]];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *destTime = [formatter dateFromString:localstring];

	return [destTime timeIntervalSinceDate:[NSDate date]];
}

+ (void)showActivityIndicatorInView:(UIView *)view
{
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[view viewWithTag:kActivityViewTag];
    
    if (indicator && [indicator isKindOfClass:[UIActivityIndicatorView class]]) {
        [indicator startAnimating];
    }
    
    else {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        indicator.hidesWhenStopped = YES;
        indicator.tag = kActivityViewTag;
        
        [view addSubview:indicator];
        [indicator startAnimating];
    }
}

+ (void)stopActivityIndicatorInView:(UIView *)view
{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[view viewWithTag:kActivityViewTag];
    
    if (indicator && [indicator isKindOfClass:[UIActivityIndicatorView class]]) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1"))
    {
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    } else if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"5.0.1")) {
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    } else {
        return NO;
    }
}


+ (BOOL)mobilePhoneNumCheck:(NSString *)phoneNum
{
    BOOL result = YES;
    
    if (!ISEXISTSTR(phoneNum)) {
        return NO;
    }
    
    //先去空格
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:phoneNum];
    
    return result;
}
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (BOOL) validatePwd:(NSString *)pwd
{
    NSString *emailRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:pwd];
}
//
+ (BOOL) validateQQ:(NSString *)pwd
{
    NSString *emailRegex = @"^\\d{5,12}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:pwd];
}
+ (BOOL)validateNickName:(NSString *)nickName
{
    NSString *regex = @"^[a-zA-Z0-9_\\u4e00-\\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:nickName];
}

+ (BOOL)urlCheck:(NSString *)urlStr{
    BOOL result = NO;
    if (!ISEXISTSTR(urlStr)) {
        return result;
    }
    
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regulaStr];
    result = [pred evaluateWithObject:urlStr];
    return result;
}

+ (UIColor*)colorFromRGB:(NSInteger)rgbValue andAlpha:(float)alpha
{
	return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
						   green:((float)((rgbValue & 0x00FF00) >> 8))/255.0
							blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alpha];
}

+ (NSString *) uniqueString
{
    CFUUIDRef unique = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *result = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, unique));
    
    CFRelease(unique);
    
    return result;
}

//保存到user default
+ (void)saveToUserDefault:(id)obj withKey:(NSString *)key{
    if (!ISEXISTSTR(key)) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (obj == nil) {
        [defaults removeObjectForKey:key];
    }else{
        [defaults setObject:obj forKey:key];
    }
    
    [defaults synchronize];
}

//从user default 获取对象
+ (id)objFromUserDefaultWithKey:(NSString *)key{
    if (!ISEXISTSTR(key)) {
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

//从user default 删除对象
+ (void)removeOjbFromUserDefaultWithKey:(NSString *)key{
    if (!ISEXISTSTR(key)) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (CGFloat)reservedEffective:(CGFloat)f digital:(NSInteger)d
{
    char buff[255];
    NSString *format = [NSString stringWithFormat:@"%%.%df",d];
    sprintf(buff, [format UTF8String], f);
    NSString *s = [NSString stringWithUTF8String:buff];
    return [s floatValue];
}


+ (NSString *)timeStringWithNormalFormatter:(NSDate *)date
{
    static NSDateFormatter *normalFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        normalFormatter = [[NSDateFormatter alloc] init];
        normalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        normalFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    
    return [normalFormatter stringFromDate:date];
}

@end
