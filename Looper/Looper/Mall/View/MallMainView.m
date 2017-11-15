//
//  MallMainView.m
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MallMainView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"

@implementation MallMainView{
    
    
    NSDictionary *MallData;
    UIScrollView *mallScrollV;
    UIScrollView *recommendScrollV;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MallViewModel*)idObject;
        [self initView];
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [_obj popViewMallController];
    }else if(button.tag==201){
        
        [_obj dailyCheckIn];
    }else if(button.tag==200){
        
        [_obj getCreditHistory];
    }
}

-(void)updateDataView:(NSDictionary*)sourceData{
    
    MallData = sourceData;
    
//    [_obj createPropDetailView:[[sourceData objectForKey:@"data"] objectAtIndex:0]];
    [self createHudView];
    
    [self addPropToScrollView];
}

-(void)createScrollView{
  
    mallScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    mallScrollV.showsVerticalScrollIndicator = NO;
    mallScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:mallScrollV];
    
    
    [self addScrollViewTitle];
    

}

-(void)addScrollViewTitle{

    UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(279*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    titleName.font=[UIFont systemFontOfSize:11];
    titleName.textColor=[UIColor whiteColor];
    titleName.text=@"礼品中心";
    [mallScrollV addSubview:titleName];
    
    UIImageView *integrate_icon = [LooperToolClass createImageView:@"icon_integrate_min.png" andRect:CGPointMake(46, 145) andTag:100 andSize:CGSizeMake(24, 27) andIsRadius:false];
    [mallScrollV addSubview:integrate_icon];
    
    
    UILabel *integrateLable=[[UILabel alloc]initWithFrame:CGRectMake(85*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5, 330*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    integrateLable.font=[UIFont systemFontOfSize:14];
    integrateLable.textColor=[UIColor colorWithRed:138/255.0 green:137/255.0 blue:247/255.0 alpha:1.0];
    integrateLable.text=@"100积分";
    [integrateLable sizeToFit];
    [mallScrollV addSubview:integrateLable];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"icon_checkDetail.png" andRect:CGPointMake(integrateLable.frame.origin.x+integrateLable.frame.size.width+10*DEF_Adaptation_Font*0.5,150*DEF_Adaptation_Font*0.5) andTag:200 andSelectImage:@"icon_checkDetail.png" andClickImage:@"icon_checkDetail.png" andTextStr:nil andSize:CGSizeMake(10*DEF_Adaptation_Font*0.5,19*DEF_Adaptation_Font*0.5) andTarget:self];
    [mallScrollV addSubview:backBtn];
    
    UIButton *checkInBtn = [LooperToolClass createBtnImageNameReal:@"btn_checkin.png" andRect:CGPointMake(457*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andTag:201 andSelectImage:@"btn_checkin.png" andClickImage:@"btn_checkin.png" andTextStr:nil andSize:CGSizeMake(137*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [mallScrollV addSubview:checkInBtn];
    
}

-(void)addPropToScrollView{

    recommendScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(25*DEF_Adaptation_Font*0.5,220*DEF_Adaptation_Font*0.5, 590*DEF_Adaptation_Font*0.5, 314*DEF_Adaptation_Font*0.5)];
    recommendScrollV.showsVerticalScrollIndicator = NO;
    recommendScrollV.showsHorizontalScrollIndicator = NO;
    [mallScrollV addSubview:recommendScrollV];
   
    
    NSArray *recommendArray =[MallData objectForKey:@"banner"];
    
    for(int i=0;i<[recommendArray count];i++){
        NSDictionary *propData = [recommendArray objectAtIndex:i];
        
        UIImageView *propImage=[[UIImageView alloc]initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5+(i*recommendScrollV.frame.size.width),0*DEF_Adaptation_Font*0.5, 590*DEF_Adaptation_Font*0.5, 314*DEF_Adaptation_Font*0.5)];
        NSArray *array = [[propData objectForKey:@"commodityimageurl"] componentsSeparatedByString:@","]; //字符串按照【分隔成数组
        NSLog(@"array=%@=",array); //结果是
        
        [propImage sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        propImage.tag = [[propData objectForKey:@"commodityid"] intValue];
        [recommendScrollV addSubview:propImage];
        
        propImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickPropImage:)];
        [propImage addGestureRecognizer:singleTap];
        
        
    }
     [recommendScrollV setContentSize:CGSizeMake(recommendScrollV.frame.size.width*[recommendArray count],  314*DEF_Adaptation_Font*0.5)];
    
   NSArray *propData  = [MallData objectForKey:@"data"];

    for(int i =0;i<[propData count];i++){
        
       int  num_x = i%2;
        
        int num_y = floorf( i/2);
        
        
        NSLog(@"%@",[propData objectAtIndex:i]);
        NSDictionary *propIndexData = [propData objectAtIndex:i];

        UIImageView *propImage=[[UIImageView alloc]initWithFrame:CGRectMake(21*DEF_Adaptation_Font*0.5+(num_x*305*DEF_Adaptation_Font*0.5),547*DEF_Adaptation_Font*0.5+num_y*370*DEF_Adaptation_Font*0.5, 284*DEF_Adaptation_Font*0.5, 284*DEF_Adaptation_Font*0.5)];
        
        NSArray *array = [[propIndexData objectForKey:@"commodityimageurl"] componentsSeparatedByString:@","]; //字符串按照【分隔成数组
        NSLog(@"array=%@=",array); //结果是
        
        [propImage sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [mallScrollV addSubview:propImage];
        
        propImage.tag = [[propIndexData objectForKey:@"commodityid"] intValue];
        
        propImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickPropImage:)];
        [propImage addGestureRecognizer:singleTap];
        
        UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(propImage.frame.origin.x , propImage.frame.origin.y+propImage.frame.size.height+5*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 31*DEF_Adaptation_Font*0.5)];
        titleName.font=[UIFont systemFontOfSize:14];
        titleName.textColor=[UIColor whiteColor];
        titleName.text=[propIndexData objectForKey:@"commodityname"];
        [mallScrollV addSubview:titleName];
        
        UIImageView *integrate_icon = [LooperToolClass createImageView:@"icon_integrate_mid.png" andRect:CGPointMake(46, 145) andTag:100 andSize:CGSizeMake(17, 17) andIsRadius:false];
        [mallScrollV addSubview:integrate_icon];
        [integrate_icon setFrame:CGRectMake(propImage.frame.origin.x, titleName.frame.origin.y+titleName.frame.size.height+5*DEF_Adaptation_Font*0.5, integrate_icon.frame.size.width, integrate_icon.frame.size.height)];
        
        UILabel *integrateNum=[[UILabel alloc]initWithFrame:CGRectMake(integrate_icon.frame.origin.x+integrate_icon.frame.size.width+10*DEF_Adaptation_Font*0.5, integrate_icon.frame.origin.y, 280*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font*0.5)];
        integrateNum.font=[UIFont systemFontOfSize:13];
        integrateNum.textColor=[UIColor colorWithRed:136/255.0 green:131/255.0 blue:250/255.0 alpha:1.0];
        integrateNum.text=[propIndexData objectForKey:@"credit"];
        [mallScrollV addSubview:integrateNum];
    }
    
    float num_y = floorf([propData count]/2.0);
    
     [mallScrollV setContentSize:CGSizeMake(DEF_SCREEN_WIDTH,534*DEF_Adaptation_Font*0.5 +(num_y+2)*305*DEF_Adaptation_Font*0.5)];
    
    
}

-(void)onClickPropImage:(UITapGestureRecognizer *)tap{

    NSLog(@"%ld",tap.view.tag);
    
   NSArray *propData  = [MallData objectForKey:@"data"];
    
    for(int i=0;i<[propData count];i++){
        NSDictionary *propIndexData = [propData objectAtIndex:i];
        if([[propIndexData objectForKey:@"commodityid"] intValue]==tap.view.tag){
               [_obj createPropDetailView:propIndexData];
            break;
        }
    }
    
    NSArray *BannerPropData  = [MallData objectForKey:@"banner"];
    
    for(int i=0;i<[BannerPropData count];i++){
        NSDictionary *propIndexData = [BannerPropData objectAtIndex:i];
        if([[propIndexData objectForKey:@"commodityid"] intValue]==tap.view.tag){
            [_obj createPropDetailView:propIndexData];
            break;
        }
    }
    
    
}


-(void)createHudView{ 
    
   
    
    
}


-(void)initView{
    
    [self createScrollView];
    
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    [self setBackgroundColor:[UIColor colorWithRed:39/255.0 green:39/255.0 blue:72/255.0 alpha:1.0]];
    
    
}



@end
