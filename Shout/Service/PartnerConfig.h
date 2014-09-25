//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088511262166198"
//收款支付宝账号
#define SellerID  @"rengaolong_nj@sina.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"qh8mny8ih6bdfptf6uuxuy1s5h3boyho"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANGc8J3i/cw3Hg5m\
1zVjI/nzXyoveB0dQFmf+2b3oqEhYws7p86QXGQ3t4czmlyLOT2XJxBU0Ya7+hFX\
Phg2p2sBvVoMSe6v0RSf3QeBfqZNdn+81wS7otep7myYy0t4+EdG3bhBhOo36DnY\
NXdMGvQZi6ofNnXcjrfA+ClBzguBAgMBAAECgYEAuZFJx00kSL1m43MSBRZ+zBIz\
5qHdoVC7Hl0ucMq8dA+dol0uwwU0dhiJZq09c75hb3A4ShH86F3UFbP5qfAAp3Tk\
QTh8fTm9Nsq3/9kNcNxRCxDj+lpmW7LjIuF8x+6gHSo88fFRN75hkeKavC8ENXsX\
enQS4TNLxFjnn87iq40CQQD4HCUWNMrnLdXSNOigzZI0CEFjWfi0F2uB+INL62/K\
WC7yHjbooLJkYTNSxbKtSpu07BWNzJbG5rHInQ0SafjfAkEA2EdknsN0i91OGMqF\
bMKqoK2n9911yrH5BOsfyR5rQPOstluHjMIGygodelh7CWfWLc8XEK+usG7NGK9v\
jL2nnwJAWlY1Eq7KKf5AWjc1dEclMpjG5hu+OCRG2p3XgG8K1wvgm/twVqccDPxv\
KXYeJoaBxxAmkOirBWS92qOEPO4k1QJAfnCuiIqoFiSZRbEQc9cSvcEIU8Yq2QdX\
F+MFwCSCe4R50lqMUmQUaAWl2iLkO0lzU3CggWbT7923Fdlqk5NE7QJBANkm5r+G\
tM1qsx96ygnjAOfHhcAk6kxF5SEyjUmeDusq12lKzGrJZTxQ+0M01A0P9n/0t5qq\
3Fa+Q9ONb1oSWxU="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"

#endif
