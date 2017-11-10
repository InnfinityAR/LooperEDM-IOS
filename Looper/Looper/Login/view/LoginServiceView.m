//
//  LoginServiceView.m
//  Looper
//
//  Created by 工作 on 2017/11/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "LoginServiceView.h"
#import "LoginViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
@interface LoginServiceView()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end
@implementation LoginServiceView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (LoginViewModel*)idObject;
        [self initView];
        
    }
    return self;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(10*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-20*DEF_Adaptation_Font*0.5, DEF_HEIGHT(self)-20*DEF_Adaptation_Font*0.5)];
        _webView.delegate=self;
        [self addSubview:_webView];
    }
    return _webView;
}
-(void)initView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LooperService" ofType:@"rtf"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.webView loadRequest:request];
    [self initBackView];
}
-(void)initBackView{
    self.backgroundColor=ColorRGB(50, 50, 50, 1.0);
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        
    }
}
#pragma -UIWebView
-(void)webViewDidFinishLoad:(UIWebView*)webView{
//      [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#272748'"];
}
@end
