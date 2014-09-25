//
//  PayofManager.m
//  Shout
//
//  Created by zhousl on 14-9-22.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "PayofManager.h"
#import "PartnerConfig.h"
#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "DataSigner.h"
#import "DataVerifier.h"

@implementation modelProduct
@synthesize body,price,subject,goodsID,number;

- (instancetype)init
{
    self = [super init];
    if (self) {
        number = 1;
    }
    return self;
}
- (void)dealloc
{
#if ! __has_feature(objc_arc)
    [body release];
    [subject release];
    [goodsID release];
    [super dealloc];
#endif
}
@end


@interface PayofManager(){
    SEL payResultSEL_;
}
@property(nonatomic, assign)id<PaylibDelegate> payDelegate;

-(NSString*)getOrderInfo:(modelProduct*)mp order:(NSString*)order notifyURL:(NSString*)notifyUrl;

-(NSString*)doRsa:(NSString*)orderInfo;

@end

@implementation PayofManager
@synthesize payDelegate;

DEFINE_SINGLETON_FOR_CLASS(PayofManager);


- (instancetype)init
{
    self = [super init];
    if (self) {
        payResultSEL_ = @selector(paymentResult:);
    }
    return self;
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    NSLog(@"---payMentResult---\n%@", resultd);
    /*
     resultStatus={9000};memo={操作成功};result={partner="2088511262166198"&seller_id="rengaolong_nj@sina.com"&out_trade_no="HOR9CQZLK1I2FNR"&subject="话费充值"&body="[四钻信誉]北京移动30元 电脑全自动充值 1到10分钟内到账"&total_fee="0.01"&notify_url="http%3A%2F%2Fwwww.xxx.com"&service="mobile.securitypay.pay"&_input_charset="utf-8"&payment_type="1"&return_url="www.xxx.com"&it_b_pay="1d"&show_url="www.xxx.com"&success="true"&sign="grndDZidDorvBBQ9UJlHXLqn33cZ/LvA8dxEnXX8gYifsv6im27RdlORJ6yvppfDehL84M8zqhX08ejC3dRvI0WFM6Xmc1vxyhbFLj5TA9/2O+pkT8qAm5bZkh1c9Zc8lvCgHjNxfge2ph9iIhKbNF2UM0ijAZxCkYfk7VwxiSw="&sign_type="RSA"}
     */
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
			}
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
    if (self.payDelegate
        && [self.payDelegate respondsToSelector:@selector(paymentResultDelegate:)]) {
        [self.payDelegate paymentResultDelegate:resultd];
    }
}

- (void)MMUniPay:(modelProduct*)Product
           order:(NSString*)order
           AppID:(NSString*)AppId
          AppKey:(NSString*)AppKey
         AppName:(NSString*)AppName
       AndScheme:(NSString*)scheme
    withDelegate:(id<PaylibDelegate>)delegate{
    
    
    NSString* orderInfo = [self getOrderInfo:Product order:order notifyURL:nil];
    NSString* signedStr = [self doRsa:orderInfo];
    
    
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    NSLog(@"%@",orderString);
    self.payDelegate = delegate;
    
    [AlixLibService payOrder:orderString AndScheme:scheme
                     seletor:payResultSEL_
                      target:self];
}

-(NSString*)getOrderInfo:(modelProduct*)mp
                   order:(NSString*)order
               notifyURL:(NSString*)notifyUrl;{
    
    AlixPayOrder *aliOrder = [[AlixPayOrder alloc] init];
    aliOrder.partner = PartnerID;
    aliOrder.seller = SellerID;
    
    aliOrder.tradeNO = order; //订单ID（由商家自行制定）
	aliOrder.productName = mp.subject;                     //商品标题
	aliOrder.productDescription = mp.body;                 //商品描述
	aliOrder.amount = [NSString stringWithFormat:@"%.2f",mp.price*mp.number]; //商品价格
	aliOrder.notifyURL =  notifyUrl; //回调URL
	
	NSString* orderDes = [aliOrder description];
    
    return orderDes;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
