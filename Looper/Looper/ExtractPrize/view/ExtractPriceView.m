//
//  ExtractPriceView.m
//  Looper
//
//  Created by 工作 on 2017/8/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ExtractPriceView.h"
#import "ExtractPriceViewModel.h"
#import "LooperConfig.h"
#import"LooperToolClass.h"
@interface ExtractPriceView()<UIWebViewDelegate>

@end
@implementation ExtractPriceView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    if (self=[super initWithFrame:frame]) {
        self.obj = (ExtractPriceViewModel*)idObject;
        [self initView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==99) {
        [self.obj popViewController];
    }
    if (button.tag==100) {
    [self.obj getRouletteProductForproductId:2];
    }
}
-(void)initView{
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    webView.suppressesIncrementalRendering=YES;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    webView.delegate=self;
    [self addSubview: webView];
    [webView loadRequest:request];
      [self creatBKView];
   
}
-(void)creatBKView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    self.backgroundColor=ColorRGB(34, 35, 71, 1.0);
    UIButton *goBtn = [LooperToolClass createBtnImageNameReal:@"image_pay.png" andRect:CGPointMake(DEF_WIDTH(self)-70*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"image_pay.png" andClickImage:@"image_pay.png" andTextStr:nil andSize:CGSizeMake(60*DEF_Adaptation_Font*0.5,60*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:goBtn];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    webView.scrollView.bounces=NO;
    CGRect frame = webView.frame;
    //webView的宽度
    frame.size = CGSizeMake(DEF_WIDTH(self), 0);
    webView.frame = frame;
    float content_height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    frame = webView.frame;
    //webView的宽度和高度
    frame.size = CGSizeMake(DEF_WIDTH(self), content_height);
    webView.frame = frame;
   
   
}

@end
