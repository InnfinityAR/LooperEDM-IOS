//
//  ActivityDetailView.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "ActivityDetailView.h"
#include "nActivityViewModel.h"
#import "LooperConfig.h"

@implementation ActivityDetailView{
    UIScrollView *bkScroll;


}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}



-(void)createWebView{
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mp.weixin.qq.com/s?__biz=MjM5MzEwMTI2MA==&mid=2649918773&idx=5&sn=5119fb0c3ef43496cfc3666b61ff0603&chksm=be9a099689ed8080f3a807d8989f85d93611a03c921257e1b188e3bc91202d40ace3176efe75&mpshare=1&scene=1&srcid=05204qbqFvrw8cL3BpELq7qQ&key=666c08e50e29d9ead3c2481eefaf86f2d572329c8f19e42116bcaa005ae0d3081e24fdb22b5a0508913d43b896debb8a3a6a3a741f9ad5f7f32ece8e416d4170a549d3657ce99ccda056cd6f84fc91b3&ascene=0&uin=MTEzMzE2NjcyMA%3D%3D&devicetype=iMac+MacBookPro11%2C5+OSX+OSX+10.12.4+build(16E195)&version=12010310&nettype=WIFI&fontScale=100&pass_ticket=NElYRmm%2FFIlx%2BKs5bU4MCD8zlUyfVX5ZzwuEzONokreKug6zcGnlHnAGS%2BxtfnYr"]];
    webV.delegate=self;
    
    [webV loadRequest:request];
    
    [bkScroll addSubview:webV];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height+200*DEF_Adaptation_Font*0.5+700*DEF_Adaptation_Font*0.5);
    
    [webView setFrame:CGRectMake(0, 200*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height)];
}


-(void)initView{
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    [bkScroll setBackgroundColor:[UIColor grayColor]];
    [self addSubview:bkScroll];
    
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
    
    [self createWebView];

    
}
@end
