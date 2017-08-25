//
//  GenerateQRCodeView.m
//  Looper
//
//  Created by 工作 on 2017/8/24.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "GenerateQRCodeView.h"
#import "ScanQRCode.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
@interface GenerateQRCodeView()
@end
@implementation GenerateQRCodeView

-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andUrl:(NSString *)url andImage:(NSString *)imageUrl{
    if (self=[super initWithFrame:frame]) {
        [self initViewWithUrl:url andImage:imageUrl];
        [self setBackView];
    }
    return self;
}
-(void)setBackView{
    self.backgroundColor=[UIColor grayColor];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag==100) {
        [self removeFromSuperview];
    }
}
-(void)initViewWithUrl:(NSString *)url andImage:(NSString *)imageUrl{
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150*DEF_Adaptation_Font;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = ([UIScreen mainScreen].bounds.size.width - imageViewW) / 2;
    CGFloat imageViewY = 240*DEF_Adaptation_Font;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self addSubview:imageView];
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    if (url==nil) {
        url=@"https://www.looper.pro";
    }
    if (imageUrl==nil) {
        imageUrl=@"640-2.png";
    }
    imageView.image = [SGQRCodeGenerateManager SG_generateWithLogoQRCodeData:url logoImageName:imageUrl logoScaleToSuperView:scale];

}
@end
