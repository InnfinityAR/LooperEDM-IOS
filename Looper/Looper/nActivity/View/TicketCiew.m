//
//  TicketCiew.m
//  Looper
//
//  Created by 工作 on 2017/5/26.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "TicketCiew.h"
#import "nActivityViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "DataHander.h"

@implementation TicketCiew{
    UIScrollView *bkScroll;
    UIWebView *webV;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDic:(NSDictionary *)dataDic{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        self.dataDic=dataDic;
        [self initView];
        
        
    }
    return self;
}
-(void)createWebView{
    
    webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 110*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"ticketurl"]]];
    webV.delegate=self;
    
    [webV loadRequest:request];
    
    [bkScroll addSubview:webV];
    
}


- (BOOL) webView:(UIWebView *)_webView shouldStartLoadWithRequest: (NSURLRequest *) request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestUrl = [request URL].absoluteString;
    

    if ([requestUrl rangeOfString:@"open.weixin.qq.com"].location == NSNotFound) {
            NSLog(@"string 不存在 martin");
    } else {
            NSLog(@"string 包含 martin");
        
        [[DataHander sharedDataHander] showViewWithStr:@"该购票链接只能通过微信打开😂" andTime:2 andPos:CGPointZero];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:[self.dataDic objectForKey:@"ticketurl"] forKey:@"htmlurl"];
        [dic setObject:[self.dataDic objectForKey:@"activityname"] forKey:@"name"];
        
        [_obj sharetTicket:dic];
    }
        
        
    
    NSLog(@"%@",requestUrl);
    
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
}


-(void)initView{
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    [bkScroll setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bkScroll];
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_ticketBack.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_ticketBack.png" andClickImage:@"btn_ticketBack.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,24*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"订票" andFontSize:15 andColor:[UIColor blackColor] andType:NSTextAlignmentCenter];
    [self addSubview:looperName];
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
    
    [self createWebView];
    
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        [ webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        [ webV stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
        [ webV removeFromSuperview];
        [self removeFromSuperview];
    }else if(button.tag==102){
        
    }
}
-(void)removeActivityAction{
    [ webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [ webV stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
    [ webV removeFromSuperview];
}

@end
