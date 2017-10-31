//
//  FamilyOfficialView.m
//  Looper
//
//  Created by 工作 on 2017/10/20.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyOfficialView.h"
#import "nActivityViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "YWCarouseView.h"
@interface FamilyOfficialView()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIImageView *headImageView;
    UIImageView *shadowV;
    UIScrollView *scrollV;
    UIButton  *followBtn;
    
    UIView *selectView;
    UIButton *activeBtn;
    UIButton *detailBtn;
    UIButton *photoBtn;
    
    UIScrollView *HorizontalScroll;
    UIImageView *lineImage;
    
    UIView *ShowselectView;
    
    UIButton *activeBtn1;
    UIButton *detailBtn1;
    UIButton *phtotBtn1;
       float ScrollNum_y;
    
    UIView *selectV;
    
    UIImageView *updateIV;
     XHImageViewer *imageViewer;
    
    BOOL isJudgeFamilyAlbumn;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSArray *footprint;
@property(nonatomic,strong)NSArray *albumn;
@property(nonatomic,strong)UICollectionView *albumnCollectView;
@property(nonatomic,strong)NSMutableArray *updateAlbumnArr;
@property(nonatomic,strong)NSMutableArray *imageViews;
@end
@implementation FamilyOfficialView
-(NSMutableArray *)updateAlbumnArr{
    if (!_updateAlbumnArr) {
        _updateAlbumnArr=[[NSMutableArray alloc]init];
    }
    return _updateAlbumnArr;
}
-(NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews=[[NSMutableArray alloc]init];
    }
    return _imageViews;
}
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic andFootprint:(NSArray *)footprint andAlbumn:(NSArray *)albumn andRole:(NSString *)role{
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel *)obj;
        [self.obj setOfficialView:self];
        self.dataDic=dataDic;
        self.role=role;

        self.footprint=footprint;
        self.albumn=albumn;
        [self initView];
    }
    return self;
}
-(void)initView{
     [self setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [self createImageViewHud];
    [self createScrollView];
    [self createHudView];
    [self createSelectLableView];
}
-(void)updateCollectViewData:(NSArray *)dataArr{
    self.albumn=dataArr;
    [self.albumnCollectView reloadData];
    [self.updateAlbumnArr removeAllObjects];
}
-(void)ImageFileSave:(UIImage*)imageFile{
#warning-在这里加入展示要上传的图片进行多张上传
    
    [self.updateAlbumnArr addObject:imageFile];
    [self.obj uploadFamilyAlbumnWithImages:self.updateAlbumnArr andRaverId:[self.dataDic objectForKey:@"raverid"]];
}
-(void)changeHeaderViewWIthImage:(UIImage *)image{
    headImageView.image=image;
    [self.obj updateRaverImageWithRaverId:[self.dataDic objectForKey:@"raverid"] andImage:image];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==101){
        [self removeFromSuperview];
        
    }else if(button.tag==102){
        [_obj shareh5View:nil];
    }else if(button.tag==104){
        [detailBtn setSelected:false];
        [activeBtn setSelected:true];
        [photoBtn setSelected:false];
        [detailBtn1 setSelected:false];
        [activeBtn1 setSelected:true];
        [phtotBtn1 setSelected:false];
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(0, HorizontalScroll.contentOffset.y) animated:true];
            [lineImage setFrame:CGRectMake(198*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
        }];
    }else if(button.tag==105){
        [activeBtn setSelected:false];
        [detailBtn setSelected:true];
        [photoBtn setSelected:false];
        
        [activeBtn1 setSelected:false];
        [detailBtn1 setSelected:true];
        [phtotBtn1 setSelected:false];
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(DEF_SCREEN_WIDTH*2, HorizontalScroll.contentOffset.y) animated:true];
            [lineImage setFrame:CGRectMake(406*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
        }];
    }else if(button.tag==106){
        [photoBtn setSelected:true];
        [activeBtn setSelected:false];
        [detailBtn setSelected:false];
        
        [phtotBtn1 setSelected:true];
        [activeBtn1 setSelected:false];
        [detailBtn1 setSelected:false];
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(DEF_SCREEN_WIDTH, HorizontalScroll.contentOffset.y) animated:true];
            [lineImage setFrame:CGRectMake(302*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
        }];
    }else if(button.tag==107){
//关注家族
        if([followBtn isSelected]==true){
            [followBtn setSelected:false];
            [_obj followFamliyWithisLike:0 andRaverId:[self.dataDic objectForKey:@"raverid"]];
        }else{
            [followBtn setSelected:true];
            [_obj followFamliyWithisLike:1 andRaverId:[self.dataDic objectForKey:@"raverid"]];
        }
    }
}
-(void)createSelectLableView{
    
    
    ShowselectView= [[UIView alloc] initWithFrame:CGRectMake(0, 115*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 41*DEF_Adaptation_Font*0.5)];
    
    [ShowselectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    activeBtn1 = [LooperToolClass createBtnImageNameReal:@"btn_unActive1.png" andRect:CGPointMake(180*DEF_Adaptation_Font*0.5,0*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"btn_Active1.png" andClickImage:@"btn_Active1.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTarget:self];
    [ShowselectView addSubview:activeBtn1];
    [activeBtn1 setSelected:true];
    
    detailBtn1 = [LooperToolClass createBtnImageNameReal:@"btn_unDetail.png" andRect:CGPointMake(389*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"btn_Detail.png" andClickImage:@"btn_Detail.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [ShowselectView addSubview:detailBtn1];
    
    phtotBtn1 = [LooperToolClass createBtnImageNameReal:@"btn_unPhoto.png" andRect:CGPointMake(285*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5) andTag:106 andSelectImage:@"btn_Photo.png" andClickImage:@"btn_Photo.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [ShowselectView addSubview:phtotBtn1];
    
    
    [self addSubview:ShowselectView];
    
    [ShowselectView setHidden:true];
    
}
-(void)createImageViewHud{
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    headImageView.contentMode=UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds=YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"images"]]placeholderImage:nil options:SDWebImageRetryFailed];
    [self addSubview:headImageView];
    
    shadowV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [shadowV setImage:[UIImage imageNamed:@"shadowTopDown.png"]];
    shadowV.userInteractionEnabled=YES;
    UITapGestureRecognizer *headTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderView:)];
    [shadowV addGestureRecognizer:headTap];
    [self addSubview:shadowV];
    
    UILabel *songer = [[UILabel alloc] initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 512*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5)];
    songer.text=[self.dataDic objectForKey:@"ravername"];
    [songer setTextColor:[UIColor whiteColor]];
    [songer setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:24]];
    [songer setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:songer];
    
    UIImageView *icon_songer = [[UIImageView alloc] initWithFrame:CGRectMake(220*DEF_Adaptation_Font*0.5, 271*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5)];
    [icon_songer setImage:[UIImage imageNamed:@"icon_club.png"]];
    [self addSubview:icon_songer];
}

-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    //    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    //    [self addSubview:shareBtn];
    
}
-(void)createScrollView{
    scrollV  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 120*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-113*DEF_Adaptation_Font*0.5)];
    scrollV.showsVerticalScrollIndicator = true;
    scrollV.delegate=self;
#warning-x修改
    scrollV.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, [self.footprint count]*340*DEF_Adaptation_Font*0.5+490*DEF_Adaptation_Font*0.5);
    
    [self addSubview:scrollV];
    scrollV.tag=100;
    UIView *headerV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5-113*DEF_Adaptation_Font*0.5)];
    UITapGestureRecognizer *tap10=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderView:)];
    [headerV addGestureRecognizer:tap10];
    [scrollV addSubview:headerV];
    
    followBtn = [LooperToolClass createBtnImageNameReal:@"btn_activity_unfollow.png" andRect:CGPointMake(245*DEF_Adaptation_Font*0.5,284*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"btn_activity_follow.png" andClickImage:@"btn_activity_follow.png" andTextStr:nil andSize:CGSizeMake(151*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [scrollV addSubview:followBtn];
//关注按钮
    if([[self.dataDic objectForKey:@"isfollow"]intValue]==1){
        [followBtn setSelected:true];
    }
    
    [self createHorizontalScroll];
}
-(void)createHorizontalScroll{
    
    
    selectView= [[UIView alloc] initWithFrame:CGRectMake(0, 490*DEF_Adaptation_Font*0.5-113*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 113*DEF_Adaptation_Font*0.5)];
    
    [selectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,65*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH*2, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:63/255.0 alpha:0.8]];
    [selectView addSubview:line];
    
    lineImage  =[[UIImageView alloc] initWithFrame:CGRectMake(198*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    lineImage.image = [UIImage imageNamed:@"bg_line_label.png"];
    [selectView addSubview:lineImage];
    
    activeBtn = [LooperToolClass createBtnImageNameReal:@"btn_unActive1.png" andRect:CGPointMake(180*DEF_Adaptation_Font*0.5,14*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"btn_Active1.png" andClickImage:@"btn_Active1.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:activeBtn];
    [activeBtn setSelected:true];
    detailBtn = [LooperToolClass createBtnImageNameReal:@"btn_unDetail.png" andRect:CGPointMake(389*DEF_Adaptation_Font*0.5, 14*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"btn_Detail.png" andClickImage:@"btn_Detail.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:detailBtn];
    
    photoBtn = [LooperToolClass createBtnImageNameReal:@"btn_unPhoto.png" andRect:CGPointMake(285*DEF_Adaptation_Font*0.5, 14*DEF_Adaptation_Font*0.5) andTag:106 andSelectImage:@"btn_Photo.png" andClickImage:@"btn_Photo.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:photoBtn];
    
    
    [scrollV addSubview:selectView];
#warning -修修改
    HorizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,490*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,[self.footprint count]*340*DEF_Adaptation_Font*0.5)];
    HorizontalScroll.showsHorizontalScrollIndicator = true;
    [HorizontalScroll setPagingEnabled:true];
    HorizontalScroll.delegate=self;
    HorizontalScroll.tag=101;
    
    [HorizontalScroll setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    HorizontalScroll.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*3, [self.footprint count]*340*DEF_Adaptation_Font*0.5);
    
    [scrollV addSubview:HorizontalScroll];
    [self createScrollDataView];
    
}

-(void)createScrollDataView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH*2+41*DEF_Adaptation_Font*0.5,25*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5)];
    [titleView setBackgroundColor:[UIColor colorWithRed:208/255.0 green:255/255.0 blue:107/255.0 alpha:1.0]];
    titleView.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    titleView.layer.masksToBounds = YES;
    [HorizontalScroll addSubview:titleView];
    
    UILabel *djName =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH*2+64*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 536*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    djName.text =   [NSString stringWithFormat:@"%@ 简介",[self.dataDic objectForKey:@"ravername"]];
    [djName setFont:[UIFont fontWithName:@"PingFangSC" size:24]];
    [HorizontalScroll addSubview:djName];
    [djName setTextColor:[UIColor colorWithRed:208/255.0 green:255/255.0 blue:107/255.0 alpha:1.0]];
    
    UILabel *djDetail =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH*2+40*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 560*DEF_Adaptation_Font*0.5, 700*DEF_Adaptation_Font*0.5)];
    djDetail.numberOfLines=0;
    [djDetail setTextColor:[UIColor whiteColor]];
    djDetail.text = [self.dataDic objectForKey:@"familydeclaration"];
    [HorizontalScroll addSubview:djDetail];
    [djDetail setFont:[UIFont fontWithName:@"PingFangSC-Thin" size:16]];
    [djDetail sizeToFit];
    
    for (int i=0; i<self.footprint.count; i++) {
        NSDictionary *dataDic=[[NSDictionary alloc]initWithDictionary:self.footprint[i]];
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, i*340*DEF_Adaptation_Font*0.5, DEF_WIDTH(scrollV), 340*DEF_Adaptation_Font*0.5)];
        footView.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addClickFootView:)];
        [footView addGestureRecognizer:tap];
        [HorizontalScroll addSubview:footView];
        UIImageView *bgIV=[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
        [bgIV sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"photo"]]];
        bgIV.contentMode=UIViewContentModeScaleAspectFill;
        bgIV.clipsToBounds=YES;
        bgIV.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
        bgIV.layer.masksToBounds=YES;
        [footView addSubview:bgIV];
        UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0,0, DEF_WIDTH(self)-16*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
        bkView.backgroundColor=ColorRGB(0, 0, 0, 0.2);
        [bgIV addSubview:bkView];
        UILabel  *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, DEF_WIDTH(bgIV)-40*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
        contentLB.textColor=[UIColor whiteColor];
        contentLB.textAlignment=NSTextAlignmentCenter;
        contentLB.text=[dataDic objectForKey:@"activityname"];
        contentLB.font=[UIFont boldSystemFontOfSize:24];
        //添加阴影效果
        //    contentLB.shadowColor = [UIColor blackColor];
        //    contentLB.shadowOffset = CGSizeMake(1, 1);
        NSShadow *shadow1=[[NSShadow  alloc]init];
        shadow1.shadowBlurRadius = 10.0;
        shadow1.shadowColor = [UIColor blackColor];
        contentLB.attributedText = [[NSAttributedString alloc] initWithString:contentLB.text attributes:@{NSShadowAttributeName: shadow1}];
        [bgIV addSubview:contentLB];
        
        UILabel  *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(50*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, DEF_WIDTH(bgIV)-100*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
        timeLB.textColor=[UIColor whiteColor];
        timeLB.textAlignment=NSTextAlignmentCenter;
        if ([dataDic objectForKey:@"timetag"]!=nil&&[dataDic objectForKey:@"timetag"]!=[NSNull null]) {
                timeLB.text=[dataDic objectForKey:@"timetag"];
                timeLB.font=[UIFont systemFontOfSize:18];
                //添加阴影效果
                NSShadow *shadow=[[NSShadow  alloc]init];
                shadow.shadowBlurRadius = 10.0;
                shadow.shadowColor = [UIColor blackColor];
                timeLB.attributedText = [[NSAttributedString alloc] initWithString:timeLB.text attributes:@{NSShadowAttributeName: shadow}];
                [bgIV addSubview:timeLB];
        }
        //设置自适应图片
        if ([dataDic objectForKey:@"brandlogo"]!=[NSNull null]&&![[dataDic objectForKey:@"brandlogo"]isEqualToString:@""]) {
            UIImageView *imageV=[self WidthImageViewWithString:[dataDic objectForKey:@"brandlogo"] andI:i];
            [HorizontalScroll addSubview:imageV];
        }else{
            UIImage *image=[UIImage imageNamed:@"product_logo.png"];
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(-70*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5+340*DEF_Adaptation_Font*0.5*i,image.size.width / image.size.height * 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
            imageV.image=image;
            [HorizontalScroll addSubview:imageV];
        }
    }
    [self.albumnCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
//只有副族长以上有资格
    if ([_role integerValue]>=5) {
    updateIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-110*DEF_Adaptation_Font*0.5, DEF_SCREEN_HEIGHT-200*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    updateIV.image=[UIImage imageNamed:@"btn_add.png"];
    [self addSubview:updateIV];
    updateIV.userInteractionEnabled=YES;
    updateIV.tag=2;
    [updateIV setHidden:YES];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUpdateBtn:)];
    [updateIV addGestureRecognizer:tap1];
    }
}
-(void)clickUpdateBtn:(UITapGestureRecognizer*)tap{
    [self selectPhotoView];
    selectV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    selectV.backgroundColor=ColorRGB(0, 0, 0, 0.5);
    selectV.tag=1;
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhotoLB:)];
    [selectV addGestureRecognizer:tap1];
    [self addSubview:selectV];
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0,DEF_HEIGHT(self)-164*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 164*DEF_Adaptation_Font*0.5)];
    bkView.backgroundColor=ColorRGB(49, 52, 83, 1.0);
    [selectV addSubview:bkView];
    UILabel *localLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 80*DEF_Adaptation_Font*0.5)];
    localLB.backgroundColor=ColorRGB(36, 38, 69, 1.0);
    localLB.textAlignment=NSTextAlignmentCenter;
    localLB.textColor=[UIColor whiteColor];
    localLB.text=@"手机本地相册选择";
    localLB.userInteractionEnabled=YES;
    localLB.tag=2;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhotoLB:)];
    [localLB addGestureRecognizer:tap2];
    [bkView addSubview:localLB];
    UILabel *photoLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 84*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 80*DEF_Adaptation_Font*0.5)];
    photoLB.textAlignment=NSTextAlignmentCenter;
     photoLB.backgroundColor=ColorRGB(36, 38, 69, 1.0);
    photoLB.textColor=[UIColor whiteColor];
    photoLB.text=@"拍照";
    photoLB.userInteractionEnabled=YES;
    photoLB.tag=3;
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhotoLB:)];
    [photoLB addGestureRecognizer:tap3];
    [bkView addSubview:photoLB];
}

-(void)clickPhotoLB:(UITapGestureRecognizer *)tap{
    [selectV removeFromSuperview];
    NSInteger tag=tap.view.tag;
    if (tag==2) {
        [self.obj LocalPhotoWithTag:1];
    }
    if (tag==3) {
        [self.obj takePhotoWithTag:1];
    }
}
-(void)addClickFootView:(UITapGestureRecognizer *)tap{
    //liveshow 跳转
    NSLog(@"%ld",tap.view.tag);
    NSDictionary *dataDic=self.footprint[tap.view.tag];
    NSString *activityID=[dataDic objectForKey:@"activityid"];
    [_obj createPhotoWallController:activityID];
}
-(void)selectPhotoView{
    [photoBtn setSelected:true];
    [activeBtn setSelected:false];
    [detailBtn setSelected:false];
    
    [phtotBtn1 setSelected:true];
    [activeBtn1 setSelected:false];
    [detailBtn1 setSelected:false];
    [UIView animateWithDuration:0.3 animations:^{
        [HorizontalScroll setContentOffset:CGPointMake(DEF_SCREEN_WIDTH, HorizontalScroll.contentOffset.y) animated:true];
        [lineImage setFrame:CGRectMake(302*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
    }];
}
-(UIImageView *)WidthImageViewWithString:(NSString *)url andI:(NSInteger)i{
    __block CGFloat itemW = 0;
    __block CGFloat itemH = 70*DEF_Adaptation_Font*0.5;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5+340*DEF_Adaptation_Font*0.5*i,200*DEF_Adaptation_Font*0.5, itemH)];
    NSURL * URL = [NSURL URLWithString:url];
    //加入默认本地图片
    [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"product_logo.png"]options:SDWebImageRetryFailed];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __block  UIImage * image;
    [manager diskImageExistsForURL:URL completion:^(BOOL isInCache) {
        if (isInCache) {
            image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
        }else{
            NSData *data = [NSData dataWithContentsOfURL:URL];
            image = [UIImage imageWithData:data];
        }
    }];//判断是否有缓存
    if (image==nil) {
        //加入默认本地图片
        image=[UIImage imageNamed:@"product_logo.png"];
    }
    //根据image的比例来设置高度
    itemW = image.size.width / image.size.height * itemH;
    CGRect logoFrame=imageView.frame;
    if (image!=nil) {
        logoFrame.size.width= itemW;
    }
    imageView.frame=logoFrame;
    return imageView;
}

#pragma -UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
     CGFloat xOffset=scrollView.contentOffset.x;
    xOffset=ceilf(xOffset);
    CGFloat  scollX=ceilf(DEF_WIDTH(self));
    if(scrollView.tag==100){
        CGPoint offset = scrollView.contentOffset;
        
        if(scrollView.contentOffset.y>224){
            ShowselectView.hidden=false;
        }else{
            ShowselectView.hidden=true;
            
        }
        // if(scrollView.contentOffset.y>0 &&scrollView.contentOffset.y<71){
        followBtn.frame=CGRectMake(followBtn.frame.origin.x, followBtn.frame.origin.y+(yOffset-ScrollNum_y), followBtn.frame.size.width, followBtn.frame.size.height);
        // }
        if (offset.y < 0) {
            CGRect rect = headImageView.frame;
            rect.origin.y =offset.y;
            rect.origin.x =offset.y;
            rect.size.height = 490*DEF_Adaptation_Font*0.5 - offset.y*2;
            rect.size.width = DEF_SCREEN_WIDTH - offset.y*2;
            headImageView.frame = rect;
            shadowV.frame = rect;
        }
        ScrollNum_y =yOffset;
    }
    
    if (yOffset==0) {
        if (xOffset<=scollX+20*DEF_Adaptation_Font*0.5&&xOffset>=scollX-20*DEF_Adaptation_Font*0.5) {
            [updateIV setHidden:NO];
        }
        if (xOffset>0&&xOffset<20*DEF_Adaptation_Font*0.5){
            [updateIV setHidden:YES];
        }
        if (xOffset<=ceilf(DEF_WIDTH(self)*2)&&xOffset>=ceilf(DEF_WIDTH(self)*2)-20*DEF_Adaptation_Font*0.5) {
           [updateIV setHidden:YES];
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //做一些滑动完成后的操作
    
    if(scrollView.tag==101){
        
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if(page==1){
            [photoBtn setSelected:true];
            [activeBtn setSelected:false];
            [detailBtn setSelected:false];
            
            [phtotBtn1 setSelected:true];
            [activeBtn1 setSelected:false];
            [detailBtn1 setSelected:false];
            [UIView animateWithDuration:0.3 animations:^{
                [lineImage setFrame:CGRectMake(302*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            }];
            
            
        }else if(page==0){
            [photoBtn setSelected:false];
            [detailBtn setSelected:false];
            [activeBtn setSelected:true];
            
            [phtotBtn1 setSelected:false];
            [detailBtn1 setSelected:false];
            [activeBtn1 setSelected:true];
            [UIView animateWithDuration:0.3 animations:^{
                [lineImage setFrame:CGRectMake(198*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            }];
            
        }else if(page==2){
            [detailBtn setSelected:true];
            [photoBtn setSelected:false];
            [activeBtn setSelected:false];
            [detailBtn1 setSelected:true];
            [phtotBtn1 setSelected:false];
            [activeBtn1 setSelected:false];
            [UIView animateWithDuration:0.3 animations:^{
                [lineImage setFrame:CGRectMake(406*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            }];
        }
    }else {
        
    }
    
}
#pragma-CollectionViewDelegate
-(UICollectionView *)albumnCollectView{
    if (!_albumnCollectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置每个item的大小，
        flowLayout.itemSize = CGSizeMake((DEF_WIDTH(self)-20)/3, (DEF_WIDTH(self)-20)/3);
        //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        // 设置列的最小间距
        flowLayout.minimumInteritemSpacing = 5;
        // 设置最小行间距
        flowLayout.minimumLineSpacing = 5;
        // 设置布局的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _albumnCollectView=[[UICollectionView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH, 0, DEF_WIDTH(HorizontalScroll), DEF_HEIGHT(HorizontalScroll)) collectionViewLayout:flowLayout];
        _albumnCollectView.backgroundColor=[UIColor clearColor];
        _albumnCollectView.delegate=self;
        _albumnCollectView.dataSource=self;
        [HorizontalScroll addSubview:_albumnCollectView];
    }
    return _albumnCollectView;
}
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.albumn.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 取出每个item所需要的数据
    NSDictionary *dic = [self.albumn objectAtIndex:indexPath.item];
    UIImageView *albumnIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(cell), DEF_HEIGHT(cell))];
    [albumnIV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imageurl"]] placeholderImage:nil options:SDWebImageRetryFailed];
    albumnIV.contentMode=UIViewContentModeScaleAspectFill;
    albumnIV.clipsToBounds=YES;
    [cell.contentView addSubview:albumnIV];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isJudgeFamilyAlbumn) {
     //当从相册开始选择的时候
        [self initEnsureRaverImageWithIndex:indexPath.row];
    }else{
    //相册跳转
    [_imageViews removeAllObjects];
    NSInteger tag = indexPath.row;
    imageViewer = [[XHImageViewer alloc] init];
    imageViewer.delegate = self;
    [self addSubview:imageViewer];
        for (int i=0;i<[self.albumn count];i++){
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width, 0);
            [tempImageView sd_setImageWithURL:[NSURL URLWithString:[self.albumn[i] objectForKey:@"imageurl"]] placeholderImage:nil options:SDWebImageRetryFailed];
            tempImageView.contentMode=1;
            tempImageView.clipsToBounds=YES;
    [tempImageView setBackgroundColor:[UIColor whiteColor]];
    [self.imageViews addObject:tempImageView];
        }
    if ([self.role integerValue]>=5) {
//只有副族长以上有资格
    if([self.albumn count]==1){
        [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:0] andType:2];
    }else{
        [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:tag] andType:2];
    }
    }else{
        if([self.albumn count]==1){
            [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:0] andType:0];
        }else{
            [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:tag] andType:0];
        }
    }
    }
}
#pragma -确认从家族相册选择的图片成为封面
-(void)initEnsureRaverImageWithIndex:(NSInteger )index{
    NSDictionary *dic = [self.albumn objectAtIndex:index];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imageurl"]] placeholderImage:nil options:SDWebImageRetryFailed];
    isJudgeFamilyAlbumn=NO;
     [self.obj updateRaverImageWithRaverId:[self.dataDic objectForKey:@"raverid"] andImage: [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[dic objectForKey:@"imageurl"]]];
}

#pragma HXViewer
- (void)imageViewer:(XHImageViewer *)imageViewer  willDismissWithSelectedView:(UIImageView*)selectedView{
}

- (void)imageViewer:(XHImageViewer *)imageViewer finishWithSelectedView:(NSArray*)ImageArray{
}

-(void)giveSelectedView:(NSInteger)index{
    NSDictionary *dic = [self.albumn objectAtIndex:index];
    [self.obj deleteFamilyAlbumnWithImageId:[dic objectForKey:@"imageid"] RaverId:[dic objectForKey:@"raverid"]andUserId:[dic objectForKey:@"userid"]];
}
#pragma-点击头部视图
-(void)clickHeaderView:(UITapGestureRecognizer *)tap{
    selectV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    selectV.backgroundColor=ColorRGB(0, 0, 0, 0.5);
    selectV.tag=1;
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderLB:)];
    [selectV addGestureRecognizer:tap1];
    [self addSubview:selectV];
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0,DEF_HEIGHT(self)-248*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 248*DEF_Adaptation_Font*0.5)];
    bkView.backgroundColor=ColorRGB(49, 52, 83, 1.0);
    [selectV addSubview:bkView];
    UILabel *localLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 84*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 80*DEF_Adaptation_Font*0.5)];
    localLB.backgroundColor=ColorRGB(36, 38, 69, 1.0);
    localLB.textAlignment=NSTextAlignmentCenter;
    localLB.textColor=[UIColor whiteColor];
    localLB.text=@"手机本地相册选择";
    localLB.userInteractionEnabled=YES;
    localLB.tag=2;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderLB:)];
    [localLB addGestureRecognizer:tap2];
    [bkView addSubview:localLB];
    UILabel *photoLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 168*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 80*DEF_Adaptation_Font*0.5)];
    photoLB.textAlignment=NSTextAlignmentCenter;
    photoLB.backgroundColor=ColorRGB(36, 38, 69, 1.0);
    photoLB.textColor=[UIColor whiteColor];
    photoLB.text=@"拍照";
    photoLB.userInteractionEnabled=YES;
    photoLB.tag=3;
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderLB:)];
    [photoLB addGestureRecognizer:tap3];
    [bkView addSubview:photoLB];
    UILabel *raverLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 80*DEF_Adaptation_Font*0.5)];
    raverLB.textAlignment=NSTextAlignmentCenter;
    raverLB.backgroundColor=ColorRGB(36, 38, 69, 1.0);
    raverLB.textColor=[UIColor whiteColor];
    raverLB.text=@"从家族相册选择";
    raverLB.userInteractionEnabled=YES;
    raverLB.tag=4;
    UITapGestureRecognizer *tap4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderLB:)];
    [raverLB addGestureRecognizer:tap4];
    [bkView addSubview:raverLB];
}
-(void)clickHeaderLB:(UITapGestureRecognizer *)tap{
    [selectV removeFromSuperview];
    NSInteger tag=tap.view.tag;
    if (tag==2) {
        [self.obj LocalPhotoWithTag:2];
    }
    if (tag==3) {
        [self.obj takePhotoWithTag:2];
    }
    //从家族相册选择
    if (tag==4) {
        isJudgeFamilyAlbumn=YES;
    }
    
}
@end
