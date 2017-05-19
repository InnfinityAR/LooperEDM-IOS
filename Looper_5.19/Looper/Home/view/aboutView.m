//
//  aboutView.m
//  Looper
//
//  Created by lujiawei on 2/8/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "aboutView.h"
#import "HomeViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation aboutView

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (HomeViewModel*)idObject;
        [self initView];
    }
    return self;
}

-(void)createbackGrond{
    UIImage *bkImage = [UIImage imageNamed:@"about_home.png"];
    UIImageView *bk  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    bk.image = bkImage;
    [self addSubview:bk];
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag == 100){
        [_obj removeAboutV];
    }else if(button.tag == 101){
        NSDictionary *H5Dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [H5Dic setValue:@"http://www.innfinityar.com/?mod=main&share" forKey:@"H5Url"];
        [H5Dic setValue:@"looper 带着电音 一目前行" forKey:@"LoopDescription"];
        [H5Dic setValue:@"我在looper,你在哪里" forKey:@"LoopName"];
        [H5Dic setValue:@"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg" forKey:@"LoopImage"];
        [_obj jumpToH5:H5Dic];
    }else if(button.tag == 102){
        NSString *str = @"https://itunes.apple.com/us/app/looperedm/id1207172273?ls=1&mt=8";
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)initView{
    [self createbackGrond];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSMutableString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(238*DEF_Adaptation_Font_x*0.5, 324*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(166*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"Looper %@",currentVersion] andFontSize:10 andColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:titleNum];
    
    
    UIButton *score =[LooperToolClass createBtnImageName:@"about_Score.png" andRect:CGPointMake(0, 377) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: score];

    UIButton *back =[LooperToolClass createBtnImageName:@"about_back.png" andRect:CGPointMake(20, 60) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
     [self addSubview: back];

    UIButton *introduction =[LooperToolClass createBtnImageName:@"about_introduction.png" andRect:CGPointMake(0, 442) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
     [self addSubview: introduction];

}


@end
