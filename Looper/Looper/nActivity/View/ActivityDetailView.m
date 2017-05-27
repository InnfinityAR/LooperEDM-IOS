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
#import "UIImageView+WebCache.h"

@implementation ActivityDetailView{
    UIScrollView *bkScroll;


    NSDictionary *activityDic;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        activityDic = detailDic;
        [self initView];
        
        
    }
    return self;
}



-(void)createWebView{
    
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[[activityDic objectForKey:@"data"]objectForKey:@"htmlurl"]]];
    webV.delegate=self;
    
    [webV loadRequest:request];
    
    [bkScroll addSubview:webV];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height+1405*DEF_Adaptation_Font*0.5+700*DEF_Adaptation_Font*0.5);
    
    [webView setFrame:CGRectMake(0, 1405*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height)];
}

-(void)createBkView{

    UIImageView *bkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 684*DEF_Adaptation_Font*0.5)];
    
    [bkView sd_setImageWithURL:[[NSURL alloc] initWithString:[[activityDic objectForKey:@"data"]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    [bkScroll addSubview:bkView];


}



-(void)initView{
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    [bkScroll setBackgroundColor:[UIColor colorWithRed:18/255.0 green:19/255.0 blue:78/255.0 alpha:1.0]];
    [self addSubview:bkScroll];

    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
    
    [self createWebView];
    
    [self createBkView];

    
}
@end
