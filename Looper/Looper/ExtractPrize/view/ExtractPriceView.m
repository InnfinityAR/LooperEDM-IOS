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
#import "LocalDataMangaer.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ExtractPriceView()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
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
}

-(void)initView{
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    self.webView.backgroundColor=ColorRGB(34, 35, 71, 1.0);
    self.webView.suppressesIncrementalRendering=YES;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://roulette.looper.pro/index.php?userId=%@",[LocalDataMangaer sharedManager].uid]]];
    self.webView.delegate=self;
    [self addSubview: self.webView];
    [self.webView loadRequest:request];
    [self creatBKView];
    
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"toCreateOrderForID"] = ^() {
        
        NSArray *args = [JSContext currentArguments];
        NSString *product = [NSString stringWithFormat:@"%@",[args objectAtIndex:0]];
        NSString *resultId = [NSString stringWithFormat:@"%@",[args objectAtIndex:1]];
 
         [self.obj getRouletteProductForproductId:[product intValue]];
    };
    
    
    context[@"toShare"] = ^() {
        NSDictionary *webDic=@{@"htmlurl":[NSString stringWithFormat:@"http://roulette.looper.pro/index.php?userId=%@",[LocalDataMangaer sharedManager].uid],@"activityname":@"诺，你的Ultra China免费门票来了！",@"photo":@"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg"};
        [self.obj shareh5View:webDic];
        
    };

}
-(void)creatBKView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    self.backgroundColor=ColorRGB(34, 35, 71, 1.0);
}

//- (void) webViewDidFinishLoad:(UIWebView *)webView{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    webView.scrollView.bounces=NO;
//    CGRect frame = webView.frame;
//    //webView的宽度
//    frame.size = CGSizeMake(DEF_WIDTH(self), 0);
//    webView.frame = frame;
//    float content_height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
//    frame = webView.frame;
//    //webView的宽度和高度
//    frame.size = CGSizeMake(DEF_WIDTH(self), content_height);
//    webView.frame = frame;
//   
//   
//}

@end
