//
//  UseInfoView.m
//  Looper
//
//  Created by 工作 on 2017/5/23.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "UseInfoView.h"
#import "UserInfoViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"

#define LopperBtnTag 500000
#define HomeBtnTag 500001
#define SearchBtnTag 500002
#define DJBtnTag 500003
#define ActiveBtnTag 500004
#define mainChatBackTag 500007
#define mainAccountBackTag 500008

#define createLoopBackTag 500003

#define jumpCamera 500005
#define createLoopTag 500004
#define titleTag 500006

#define ActivityBackBtnTag 100000
#define ActivityFollowBtnTag 100001
#define ActivityLikeBtnTag 100002
#define ActivityShareBtnTag 100003

@implementation UseInfoView
{
    
    
    UILabel *titleName;
    UIView *headView;
    UIImageView *headFrame;
    UIImageView *manFrame;
    
    
}

-(NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic=[NSMutableDictionary new];
    }
    return _dataDic;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    if (self=[super init]) {
        self.obj=(UserInfoViewModel *)idObject;
        [self initView];
        [self initUI];
    }
    return self;
}
-(void)initView{
    [self initBk];
    self.dataDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    [self.obj getDataForSomething:@""];
}
-(void)initBk{
    UIImage *bk = [UIImage imageNamed:@"bk_InfoBgFrame.png"];
    UIImageView *imageBkV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    imageBkV.image = bk;
    [self addSubview:imageBkV];
}

-(void)reloadTableData:(NSMutableDictionary *)DataLoop{
    self.dataDic=DataLoop;
    [self initBaseData];
    
}
-(void)initUI{
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:mainAccountBackTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
    UIButton *setting =[LooperToolClass createBtnImageName:@"btn_infoSetting.png" andRect:CGPointMake(464, 33) andTag:103 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: setting];
    [setting setHidden:YES];
    
    UIButton *message =[LooperToolClass createBtnImageName:@"btn_InfoMessage.png" andRect:CGPointMake(548, 33) andTag:104 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: message];
    
    UIImageView *FrameName=[LooperToolClass createImageViewReal:@"image_NameFrame.png" andRect:CGPointMake(95*DEF_Adaptation_Font_x*0.5,400*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(452*DEF_Adaptation_Font_x*0.5, 40*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:FrameName];
    
    
#warning-需要换图的地方
//    UIButton *myLoop =[LooperToolClass createBtnImageName:@"otherUser.png" andRect:CGPointMake(180, 671) andTag:8003 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
//    [self addSubview: myLoop];
    
    UIButton *myCollection =[LooperToolClass createBtnImageName:@"btn_myCollection.png" andRect:CGPointMake(180, 671) andTag:8004 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: myCollection];
    
    UIButton *btnFans =[LooperToolClass createBtnImageName:@"btn_fans.png" andRect:CGPointMake(320, 477) andTag:8002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: btnFans];
    
    UIButton *btnFollow =[LooperToolClass createBtnImageName:@"btn_follow1.png" andRect:CGPointMake(68, 477) andTag:8001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: btnFollow];
    
    headFrame=[LooperToolClass createImageViewReal:@"bg_headFrame.png" andRect:CGPointMake(215*DEF_Adaptation_Font_x*0.5,105*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(198*DEF_Adaptation_Font_x*0.5, 198*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:headFrame];
    
    if([[[LocalDataMangaer sharedManager] sex] intValue]==1){
        
        manFrame=[LooperToolClass createImageViewReal:@"bg_manFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(202*DEF_Adaptation_Font_x*0.5, 202*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:manFrame];
        
    }else{
        manFrame=[LooperToolClass createImageViewReal:@"bg_womanFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(202*DEF_Adaptation_Font_x*0.5, 202*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:manFrame];
    }
    
    
}
-(void)initBaseData{
    UILabel *followNum = [[UILabel alloc] initWithFrame:CGRectMake(204*0.5*DEF_Adaptation_Font, 503*0.5*DEF_Adaptation_Font, 70*0.5*DEF_Adaptation_Font, 24*0.5*DEF_Adaptation_Font)];
    [followNum setText:[self.dataDic objectForKey:@"followcount"]];
    [followNum setTextAlignment:NSTextAlignmentLeft];
    [followNum setTextColor:[UIColor whiteColor]];
    [self addSubview:followNum];
    
    UILabel *fanNum = [[UILabel alloc] initWithFrame:CGRectMake(448*0.5*DEF_Adaptation_Font, 503*0.5*DEF_Adaptation_Font, 70*0.5*DEF_Adaptation_Font, 24*0.5*DEF_Adaptation_Font)];
    [fanNum setText:[self.dataDic objectForKey:@"fanscount"]];
    [fanNum setTextAlignment:NSTextAlignmentLeft];
    [fanNum setTextColor:[UIColor whiteColor]];
    [self addSubview:fanNum];
    //名字
    titleName = [LooperToolClass createLableView:CGPointMake(95*DEF_Adaptation_Font_x*0.5, 377*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(452*DEF_Adaptation_Font_x*0.5, 42*DEF_Adaptation_Font_x*0.5) andText:[self.dataDic objectForKey:@"nickname"] andFontSize:25 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:titleName];
    //头像
    headView = [LooperToolClass createViewAndRect:CGPointMake(215, 105) andTag:100 andSize:CGSizeMake(198*0.5*DEF_Adaptation_Font, 198*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:[self.dataDic objectForKey:@"headimageurl"]];
    [self addSubview:headView];

}
-(IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger EventTag=button.tag;
    [_obj hudOnClick:EventTag];
}
@end
