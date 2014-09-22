//
//  PayofManager.h
//  Shout
//
//  Created by zhousl on 14-9-22.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface modelProduct : NSObject

@property (nonatomic, assign) float price;
@property (nonatomic, assign) NSUInteger number;     // 商品个数 最小值1
@property (nonatomic, strong) NSString* goodsID;
@property (nonatomic, strong) NSString *subject;    // 商品名称
@property (nonatomic, strong) NSString *body;       // 支付描述

@end


@protocol PaylibDelegate <NSObject>

-(void)paymentResultDelegate:(NSString *)result;

@end


@interface PayofManager : NSObject

DEFINE_SINGLETON_FOR_HEADER(PayofManager)

/**
 *	@brief	同步支付接口
 *
 @param  Product 产品信息（名称 描述 价格 数量 eg）
 *	@param 	order 	订单信息
 *	@param  AppId
 *	@param  AppKey
 *	@param  AppName
 *	@param 	scheme 	应用程序scheme   用于应用外支付回调
            delegate  用于支付结果的直接回调 * 只记录最后一次的delegate，重复调用会覆盖
 */
- (void)MMUniPay:(modelProduct*)Product
           order:(NSString*)order
           AppID:(NSString*)AppId
          AppKey:(NSString*)AppKey
         AppName:(NSString*)AppName
       AndScheme:(NSString*)scheme
    withDelegate:(id<PaylibDelegate>)delegate;

- (void)parse:(NSURL *)url application:(UIApplication *)application;
@end
