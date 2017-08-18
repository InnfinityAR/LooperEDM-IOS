//
//  AliManagerData.m
//  Looper
//
//  Created by lujiawei on 07/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "AliManagerData.h"
#import <UIKit/UIKit.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataHander.h"



@implementation AliManagerData

+(NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



+(void)doAlipayPay:(NSDictionary*)Paydic
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017080107982118";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCMJhnaDlJfSbV7RC7WfVYd0OadFN+brmq9RVBf5RNtH2avu5kSd/EPO9xhMfWVoQQLmlarBL5Z2Cf5/LJnz1/2QsPXIaE/ROzJrVizFoyItQP9Lt8cw33ki+4yRrUtP1RLalhqKhdHveYLEtny8tca1kdxAf1mMcYA8+WyYlDSJjRnE/q7afuwMczsSD73h+5IwPJ6fjYlei03v0RmjILEBDM2mLQre1YFT+OwMQycyAb5eL4mxsWhkW7SJxNimwDIk2FAEu+Imia5PacudUDNDeq2RpAJvD1K8lpfzCFJS8EQpyQglhny3Qo5wsT7v8yLrBlXuuQU7ZrYvGMRVwl5AgMBAAECgf88OCLjj0PVrdZNIP7/KtvV8+0jkdSDEG7M5PukOMogGV4GJJWhWeg6o34ORWlA4e7bDXYwBdnEwRxsTihacsDJD+cWiVy/0t3rypBSY13/X8hXAczcjyOJEJdJAxjWWF/gB9H1zCA0s2QlXfRIcA/9eBU6eaBoSPrLbgFEpPoVUa7iWr+sE/JNxp5khjtd7Y/OlOivvWxrqj51jfi/cHLX+QF6B3rJYSuTdtvgV2gUGky7eGUNF/Kez0XKj6PTiLGzNb7EJ5l69Z54YMW7S8XpeUINx3ry55V3Dn/Ho5j1FuamCuRvKcLLNuhIDxA/cQ8tGLEnv1JoGUELev410GECgYEA6TdytUth6O5fEqz6ADQqcBo7n2jU3NUwGEa140OS7n/NsNufiTcwihWznC+IyTV6ZbnzPHUNq2+hX7q1/rDJFhAF5ZaAUU4gu0hXG2B+OoiJP2I0//ZIGoe6ZH1bNBGJCh0X3MMJJQyYRdQPotSwwZ7QYxRVJNZATOz9iyKIKB0CgYEAmdcbJMsy2gOiCPt7Vkn5lhJCfqnAXZg6klNAOzJPOyv1si6seC7NOWvOd5Ui80yEmqZ064kF56kxeL9kcOJJuU24qkNn4D3T88AI4/xZ7C7/nnbkGgSYIeb24VHUHwedztVvw+22ZLV0AhRS6ZWXoxZjACZymaZs7iszHniRAA0CgYBkv+d2GpK5pgC8eK2n2OFcfHi1bPxISnD0i9eXzmFzVxLtDHPnO0hk3usw1fgptEikGajSvV6iaR8109s7o/O67EEf5dyZQz8wqRe4Y/8kGkfwceSjjymnDGuhbeYwoEKrc9YTMM6Kit5djDcVCP0zKACuTOJbf5NXqCoAKXLYoQKBgQCJs7eCObhs2S+i5qfB1zlnETUf94ZOwMI80/P8iM3O40xrj8elVA8yxMLs2zuLmARiAXlKkz4L3LCBqp+XQ5ZGHcGb9fX3DKC54DyVBf7foDoCd905RL+AKSL3EK3UkJa62uXN9Ot8Pcd3TQXiO5qdyp4XNlMCIawDi/uX3Me9yQKBgAp7vRNtCWDmmcZNCM13N8bv9/Kv49NVnyFigdJHIehrnDvbnxmmHWHPkk5sKzCSuoJbhgUpZe7tOgoG0sgVOe3OADxFUSoYRgZ2+LwaASQYue06xQXiSFq+/nnrXmDAnpG68+tHvXTf4u3RUixSvKTmboKG75Ki1P6uCIgnJbWE";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = [Paydic objectForKey:@"productid"];
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [Paydic objectForKey:@"ordercode"]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [Paydic objectForKey:@"price"]; //商品价格
    //order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01];
    
    
    order.notify_url = @"http://api2.innfinityar.com/alipay/notify_url.php";
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            int  resultStatus=[[resultDic objectForKey:@"resultStatus"] intValue];
        
            if(resultStatus==9000){
                [[DataHander sharedDataHander] showViewWithStr:@"订单支付成功" andTime:2 andPos:CGPointZero];
            }else if(resultStatus==4000){
                [[DataHander sharedDataHander] showViewWithStr:@"订单支付失败" andTime:2 andPos:CGPointZero];
            }else if(resultStatus==5000){
                [[DataHander sharedDataHander] showViewWithStr:@"重复请求" andTime:2 andPos:CGPointZero];
            }else if(resultStatus==6001){
                [[DataHander sharedDataHander] showViewWithStr:@"中途取消" andTime:2 andPos:CGPointZero];
            }

            
        }];
    }
}



@end
