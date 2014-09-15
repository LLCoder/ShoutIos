//
//  ShareManager.m
//  Shout
//
//  Created by shana on 14-9-12.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "ShareManager.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <RennSDK/RennSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@implementation ShareManager
DEFINE_SINGLETON_FOR_CLASS(ShareManager);

- (void)start{
    [ShareSDK registerApp:@"2fe1d55bb850"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"1582377414"
                               appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://www.ibuluo.cn/getRequest/sina"];
    
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1102001631"
                           appSecret:@"831619f4ec68e99e1902074b237429c9"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1102001631"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx621d9b14c45f1611"
                           wechatCls:[WXApi class]];
    
    //添加人人网应用 注册网址  http://dev.renren.com
    [ShareSDK connectRenRenWithAppId:@"270780"
                              appKey:@"017942e602874368a0fcf631801adbab"
                           appSecret:@"2c256a8280ae4783b0a977735a38fb9f"
                   renrenClientClass:[RennClient class]];
}

- (void)shareWithContent:(NSString *)content{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon"  ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"来自Shout的分享"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"Shout"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}
@end
