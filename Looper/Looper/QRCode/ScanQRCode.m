//
//  ScanQRCode.m
//  Looper
//
//  Created by 工作 on 2017/8/24.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ScanQRCode.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanQRCodeView.h"
#import "LooperConfig.h"
#import "GenerateQRCodeView.h"
@implementation ScanQRCode
+(NSString *)urlFromImage:(UIImage *)image{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count == 0) {
            NSLog(@"暂未识别出扫描的二维码 - - %@", features);
         [[DataHander sharedDataHander] showViewWithStr:@"暂未识别出扫描的二维码" andTime:1 andPos:CGPointZero];
        return nil;
        
    } else {
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            NSString *resultStr = feature.messageString;
            return resultStr;
        }
    }
        return nil;
}
+ (NSArray *)readQRCodeFromImage:(UIImage *)image{
    // 创建一个CIImage对象
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:image.CGImage options:nil];
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}]; // 软件渲染
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];// 二维码识别
    // 注意这里的CIDetectorTypeQRCode
    NSArray *features = [detector featuresInImage:ciImage];
    NSLog(@"features = %@",features); // 识别后的结果集
    for (CIQRCodeFeature *feature in features) {
        NSLog(@"msg = %@",feature.messageString); // 打印二维码中的信息
    }
    return features;
}
+(void)initScanQRWithCurrentView:(UIView*)currentV{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ScanQRCodeView *scanView=[[ScanQRCodeView alloc]initWithFrame:[UIScreen mainScreen].bounds andObject:self];
                        [currentV addSubview:scanView];
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            ScanQRCodeView *scanView=[[ScanQRCodeView alloc]initWithFrame:[UIScreen mainScreen].bounds andObject:self];
            [currentV addSubview:scanView];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            [[DataHander sharedDataHander] showViewWithStr:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" andTime:1 andPos:CGPointZero];
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        [[DataHander sharedDataHander] showViewWithStr:@"未检测到您的摄像头" andTime:1 andPos:CGPointZero];
    }

}
+(void)initGenerateWithCurrentView:(UIView *)currentV andUrl:(NSString *)url andImage:(NSString *)imageUrl{
    GenerateQRCodeView *view=[[GenerateQRCodeView alloc]initWithFrame:[UIScreen mainScreen].bounds andObject:self andUrl:url andImage:imageUrl];
    [currentV addSubview:view];
}
+(UIImageView *)initWithFrame:(CGRect)frame andUrl:(NSString *)url andImage:(NSString *)imageUrl{
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = frame.size.width;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = frame.origin.x;
    CGFloat imageViewY =frame.origin.y;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    if (url==nil) {
        url=@"https://www.looper.pro";
    }
    if (imageUrl==nil) {
        imageUrl=@"640-2.png";
    }
    imageView.image = [SGQRCodeGenerateManager SG_generateWithLogoQRCodeData:url logoImageName:imageUrl logoScaleToSuperView:scale];
    return imageView;
}
@end
