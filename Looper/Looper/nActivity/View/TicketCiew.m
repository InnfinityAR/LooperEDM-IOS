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
@implementation TicketCiew{
    UIScrollView *bkScroll;
    
    
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
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 110*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"ticketurl"]]];
    webV.delegate=self;
    
    [webV loadRequest:request];
    
    [bkScroll addSubview:webV];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
}


-(void)initView{
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    [bkScroll setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bkScroll];
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkScroll addSubview:backBtn];
    UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,24*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"订票" andFontSize:15 andColor:[UIColor blackColor] andType:NSTextAlignmentCenter];
    [self addSubview:looperName];
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
    
    [self createWebView];
    
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        [self removeFromSuperview];
    }else if(button.tag==102){
        
    }
}

@end
