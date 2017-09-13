//
//  LooperToolClass.h
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ViewControllerBDelegate // 代理传值方法
- (void)sendValue:(NSString *)value;

@end
@interface LooperToolClass : NSObject{

    UIView *delegateView;

}
@property(nonatomic, weak) id<ViewControllerBDelegate> delegate;
+(UILabel*)createLableView:(CGPoint)point andSize:(CGSize)FrameSize andText:(NSString*)lableStr andFontSize:(int)FontSize andColor:(UIColor*)color andType:(NSTextAlignment)type;

+(UIButton*)createBtnImageName:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr andSize:(CGSize)FrameSize andTarget:(id)obj;

+(UIImageView*)createImageView:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius;


+(UIView*)createViewAndRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius andImageName:(NSString*)imagePath;

+ (UIImage*)set_imageWithImage:(UIImage*)myImage
                       ToPoint:(CGPoint)newPoint
                  scaledToSize:(CGSize)newSize;

+(NSData*)set_ImageData_UIImageJPEGRepresentationWithImage:(UIImage*)image
                                CGFloat_compressionQuality:(CGFloat)image_float;

+(UIImageView*)createBtnImage:(NSString*)imagePath andRect:(CGPoint)point andTag:(int)Tag andSize:(CGSize)FrameSize andTarget:(id)obj;


+(NSArray *)initialImageArray:(NSString*)ImageName andImageCount:(int)imageCount;

+(UIImageView*)LoadingImageName:(NSString*)imageName andCount:(int)count andDuration:(float)Duraction andloadScroll:(BOOL)isScroll andPoint:(CGPoint)point;

+(void)didTapView:(UIView*)view andView:(UIView*)addView;

+(UIButton*)createBtnImageNameReal:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr andSize:(CGSize)FrameSize andTarget:(id)obj;

+(UIImageView*)createImageViewReal:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius;

+(UIView*)createFrameView:(CGPoint)point andSize:(CGSize)FrameSize andFrameWide:(int)wide andRadius:(int)Radius;




@end
