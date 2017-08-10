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
-(void)initView{
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    webView.suppressesIncrementalRendering=YES;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    webView.delegate=self;
    [self addSubview: webView];
    [webView loadRequest:request];
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
    [self.obj getRouletteProductForproductId:2];
}

@end
