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
#import "LooperToolClass.h"
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





-(void)createHudView{

    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,32*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];




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
    
//    if(webView.scrollView.contentSize.height==DEF_SCREEN_HEIGHT){
//    
//        bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,1461*DEF_Adaptation_Font*0.5+700*DEF_Adaptation_Font*0.5);
//        
//        [webView setFrame:CGRectMake(0, 1461*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,0)];
//
//    }else{
//       
//    }
    
    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height+1461*DEF_Adaptation_Font*0.5+700*DEF_Adaptation_Font*0.5);
    
    [webView setFrame:CGRectMake(0, 1461*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,webView.scrollView.contentSize.height)];
    
    
  }

-(void)createImage:(CGRect)rect andImageStr:(NSString*)ImageStr{
    UIImageView *line = [[UIImageView alloc] initWithFrame:rect];
    line.image=[UIImage imageNamed:ImageStr];
    [bkScroll addSubview:line];
}



-(void)createBkView{

    UIImageView *bkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    
    [bkView sd_setImageWithURL:[[NSURL alloc] initWithString:[[activityDic objectForKey:@"data"]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [bkScroll addSubview:bkView];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0,684*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-684*DEF_Adaptation_Font*0.5)];
    [colorView setBackgroundColor:[UIColor colorWithRed:18/255.0 green:19/255.0 blue:78/255.0 alpha:1.0]];
    [bkScroll addSubview:colorView];
    
    
    UILabel *activityName = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 723*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 90*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"activityname"] andFontSize:17 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [activityName sizeToFit];
    [bkScroll addSubview:activityName];
    
    UILabel *lableTime = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1078*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"活动时间" andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [lableTime sizeToFit];
    [bkScroll addSubview:lableTime];

    UILabel *lableLocation = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1164*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"活动地点" andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [lableLocation sizeToFit];
    [bkScroll addSubview:lableLocation];

    UILabel *lableSpace = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1254*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"场地名称" andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [lableSpace sizeToFit];
    [bkScroll addSubview:lableSpace];

    UILabel *lableTicket = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1343*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"售票链接" andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [lableTicket sizeToFit];
    [bkScroll addSubview:lableTicket];
    
    UILabel *TimeStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1078*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"endtime"] andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentRight];
    [bkScroll addSubview:TimeStr];
    
    UILabel *locationStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1164*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"location"] andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentRight];

    [bkScroll addSubview:locationStr];
    
    UILabel *SpaceStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1256*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"location"] andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentRight];
    [bkScroll addSubview:SpaceStr];
    
    UILabel *ticketStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1343*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:@"去购票" andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentRight];
    [bkScroll addSubview:ticketStr];

 
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1077*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"time.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1163*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"locaton.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1253*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"home.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1342*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"ticket.png"];
    
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1043*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1135*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1224*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1313*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1401*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];

}



-(void)initView{
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    [bkScroll setBackgroundColor:[UIColor colorWithRed:18/255.0 green:19/255.0 blue:78/255.0 alpha:1.0]];
    [self addSubview:bkScroll];




    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
    
    [self createWebView];
    
    [self createBkView];
    
    [self createHudView];

    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        [_obj removeDetailView];
    }else if(button.tag==102){
        [_obj shareh5View:activityDic];
    }
}

@end
