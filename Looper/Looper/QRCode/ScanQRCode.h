//
//  ScanQRCode.h
//  Looper
//
//  Created by 工作 on 2017/8/24.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataHander.h"
#import "SGQRCode.h"
@interface ScanQRCode : NSObject
//扫描二维码
+(void)initScanQRWithCurrentView:(UIView*)currentV;
+ (NSArray *)readQRCodeFromImage:(UIImage *)image;
+(NSString *)urlFromImage:(UIImage *)image;
//生成二维码
+(void)initGenerateWithCurrentView:(UIView *)currentV andUrl:(NSString *)url andImage:(NSString *)imageUrl;
+(UIImageView *)initWithFrame:(CGRect)frame andUrl:(NSString *)url andImage:(NSString *)imageUrl;
@end
