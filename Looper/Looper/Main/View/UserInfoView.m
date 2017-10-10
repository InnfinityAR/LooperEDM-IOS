//
//  UserInfoView.m
//  Looper
//
//  Created by lujiawei on 3/25/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "UserInfoView.h"
#import "MainViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"
#import "nMainView.h"
#import "MainViewModel.h"
@interface UserInfoView()
@property(nonatomic,strong)id viewModel;
@property(nonatomic,strong)NSDictionary *expDic;
@end
@implementation UserInfoView{
    
    
    UILabel *titleName;
    UIView *headView;
    UIImageView *headFrame;
    UIImageView *manFrame;
    UILabel *followNum;
    UILabel *fanNum;


}

@synthesize obj = _obj;
@synthesize myData = _myData;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSDictionary*)myDataSource
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (nMainView*)idObject;
        self.viewModel=[self.obj obj];
        self.expDic=[self.viewModel expDic];
        self.myData = myDataSource;
        [self initView];
        
        
    }
    return self;
}


-(void)updataView:(NSDictionary*)data{
    
    _myData = data;
    [headView removeFromSuperview];
    [headFrame removeFromSuperview];
    [manFrame removeFromSuperview];

    [titleName setText:[LocalDataMangaer sharedManager].NickName];
    
    
    
    [followNum setText:[NSString stringWithFormat:@"%@",[_myData objectForKey:@"followcount"]]];
    [fanNum setText:[NSString stringWithFormat:@"%@",[_myData objectForKey:@"fanscount"]]];
    

    headView = [LooperToolClass createViewAndRect:CGPointMake(215, 105) andTag:100 andSize:CGSizeMake(198*0.5*DEF_Adaptation_Font, 198*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:[LocalDataMangaer sharedManager].HeadImageUrl];
    [self addSubview:headView];
    
    headFrame=[LooperToolClass createImageViewReal:@"bg_headFrame.png" andRect:CGPointMake(215*DEF_Adaptation_Font_x*0.5,105*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(198*DEF_Adaptation_Font_x*0.5, 198*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:headFrame];
    
    
    if([[[LocalDataMangaer sharedManager] sex] intValue]==1){
        manFrame=[LooperToolClass createImageViewReal:@"bg_manFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 200*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:manFrame];
    }else{
        manFrame=[LooperToolClass createImageViewReal:@"bg_womanFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 200*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:manFrame];
    }

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    [_obj MainChatEvent:button.tag];
}


-(void)initView{
    [self initBk];
    [self initUI];
}


-(void)initProgressVWithRate:(NSString*)rate andSum:(NSString*)sum{
    UIView *progressV=[[UIView alloc]initWithFrame:CGRectMake(115*DEF_Adaptation_Font_x*0.5,400*DEF_Adaptation_Font_x*0.5, 452*DEF_Adaptation_Font_x*0.5, 40*DEF_Adaptation_Font*0.5)];
    progressV.backgroundColor=ColorRGB(39, 41, 83, 0.8);
//    progressV.layer.borderWidth=1.0;
//    progressV.layer.borderColor=[ColorRGB(107, 104, 221, 1.0)CGColor];
    progressV.layer.cornerRadius=20*DEF_Adaptation_Font*0.5;
    progressV.layer.masksToBounds=YES;
    [self addSubview:progressV];
    UIView *progressV1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (452*DEF_Adaptation_Font_x*0.5)*[rate intValue]/[sum intValue], 40*DEF_Adaptation_Font*0.5)];
    progressV1.backgroundColor=ColorRGB(107, 104, 221, 1.0);
    [progressV addSubview:progressV1];
    UILabel *levelNumLB=[[UILabel alloc]initWithFrame:CGRectMake(60*DEF_Adaptation_Font*0.5, 390*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    levelNumLB.textColor=ColorRGB(107, 104, 221, 1.0);
    levelNumLB.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    levelNumLB.layer.masksToBounds=YES;
    levelNumLB.text=[NSString stringWithFormat:@"Lv%@",[self.expDic objectForKey:@"level"]];
    levelNumLB.font=[UIFont boldSystemFontOfSize:20];
    levelNumLB.textAlignment=NSTextAlignmentCenter;
    levelNumLB.backgroundColor=ColorRGB(19, 22, 39, 1.0);
    [self addSubview:levelNumLB];

}

-(void)initUI{
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:mainAccountBackTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];

    UIButton *setting =[LooperToolClass createBtnImageName:@"btn_infoSetting.png" andRect:CGPointMake(464, 33) andTag:103 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: setting];

    UIButton *message =[LooperToolClass createBtnImageName:@"btn_InfoMessage.png" andRect:CGPointMake(548, 33) andTag:104 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: message];
//经验值
    UIImageView *FrameName=[LooperToolClass createImageViewReal:@"image_NameFrame.png" andRect:CGPointMake(115*DEF_Adaptation_Font_x*0.5,400*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(452*DEF_Adaptation_Font_x*0.5, 40*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:FrameName];
    [self initProgressVWithRate:[self.expDic objectForKey:@"exp"] andSum:[self.expDic objectForKey:@"nextlevel"]];
    
    titleName = [LooperToolClass createLableView:CGPointMake(95*DEF_Adaptation_Font_x*0.5, 377*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(452*DEF_Adaptation_Font_x*0.5, 42*DEF_Adaptation_Font_x*0.5) andText:[LocalDataMangaer sharedManager].NickName andFontSize:25 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:titleName];
    
    
    UIButton *myLoop =[LooperToolClass createBtnImageName:@"btn_myLoop.png" andRect:CGPointMake(180, 671) andTag:8004 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    //[self addSubview: myLoop];
    
    UIButton *myCollection =[LooperToolClass createBtnImageName:@"btn_myCollection.png" andRect:CGPointMake(180, 671) andTag:8003 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    //[self addSubview: myCollection];
    
    UIButton *liveShowBtn =[LooperToolClass createBtnImageName:@"btn_liveShow.png" andRect:CGPointMake(180, 671) andTag:8007 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: liveShowBtn];
    
    UIButton *footprintBtn =[LooperToolClass createBtnImageName:@"btn_myFoot.png" andRect:CGPointMake(180, 811) andTag:8009 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:footprintBtn];
    
    UIButton *ticketDetailBtn =[LooperToolClass createBtnImageName:@"btn_MyList.png" andRect:CGPointMake(180, 950) andTag:8008 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: ticketDetailBtn];
    
    
    UIButton *btnFans =[LooperToolClass createBtnImageName:@"btn_fans.png" andRect:CGPointMake(320, 477) andTag:8002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: btnFans];
    
    UIButton *btnFollow =[LooperToolClass createBtnImageName:@"btn_follow1.png" andRect:CGPointMake(68, 477) andTag:8001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: btnFollow];

    
    headView = [LooperToolClass createViewAndRect:CGPointMake(215, 105) andTag:100 andSize:CGSizeMake(198*0.5*DEF_Adaptation_Font, 198*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:[LocalDataMangaer sharedManager].HeadImageUrl];
    [self addSubview:headView];
    
    headFrame=[LooperToolClass createImageViewReal:@"bg_headFrame.png" andRect:CGPointMake(215*DEF_Adaptation_Font_x*0.5,105*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(198*DEF_Adaptation_Font_x*0.5, 198*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:headFrame];
    
    if([[[LocalDataMangaer sharedManager] sex] intValue]==1){
    
    manFrame=[LooperToolClass createImageViewReal:@"bg_manFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 200*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:manFrame];

    }else{
     manFrame=[LooperToolClass createImageViewReal:@"bg_womanFrame.png" andRect:CGPointMake(214*DEF_Adaptation_Font_x*0.5,104*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 200*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:manFrame];
    }

    followNum = [[UILabel alloc] initWithFrame:CGRectMake(204*0.5*DEF_Adaptation_Font, 503*0.5*DEF_Adaptation_Font, 70*0.5*DEF_Adaptation_Font, 24*0.5*DEF_Adaptation_Font)];
    [followNum setText: [NSString stringWithFormat:@"%@",[_myData objectForKey:@"followcount"]]];
    
   
    [followNum setTextAlignment:NSTextAlignmentLeft];
    [followNum setTextColor:[UIColor whiteColor]];
    [self addSubview:followNum];
    
    fanNum = [[UILabel alloc] initWithFrame:CGRectMake(448*0.5*DEF_Adaptation_Font, 503*0.5*DEF_Adaptation_Font, 70*0.5*DEF_Adaptation_Font, 24*0.5*DEF_Adaptation_Font)];
    [fanNum setText:[NSString stringWithFormat:@"%@",[_myData objectForKey:@"fanscount"]]];
    [fanNum setTextAlignment:NSTextAlignmentLeft];
    [fanNum setTextColor:[UIColor whiteColor]];
    [self addSubview:fanNum];
    
}


-(void)initBk{
    UIImage *bk = [UIImage imageNamed:@"bk_InfoBgFrame.png"];
    UIImageView *imageBkV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    imageBkV.image = bk;
    [self addSubview:imageBkV];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [super touchesBegan:touches withEvent:event];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [super touchesMoved:touches withEvent:event];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
   [super touchesEnded:touches withEvent:event];
    
}



@end






