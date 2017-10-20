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
@interface FamilyOfficialView()<UIScrollViewDelegate>
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
}
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSArray *footprint;
@property(nonatomic,strong)NSArray *albumn;
@property(nonatomic,strong)XHImageViewer *XHViewer;
@property(nonatomic,strong)NSMutableArray *imageViews;
@end
@implementation FamilyOfficialView
-(NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews=[[NSMutableArray alloc]init];
    }
    return _imageViews;
}
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic andFootprint:(NSArray *)footprint andAlbumn:(NSArray *)albumn andRole:(NSString *)role{
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel *)obj;
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
//            [_obj followBrand:_localId andisLike:0 andType:2];
        }else{
            [followBtn setSelected:true];
//            [_obj followBrand:_localId andisLike:1 andType:2];
            
        }
    }
    
}

-(void)createImageViewHud{
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"images"]]placeholderImage:nil options:SDWebImageRetryFailed];
    [self addSubview:headImageView];
    
    shadowV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [shadowV setImage:[UIImage imageNamed:@"shadowTopDown.png"]];
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
    scrollV.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, [self.footprint count]*410*DEF_Adaptation_Font*0.5+490*DEF_Adaptation_Font*0.5);
    
    [self addSubview:scrollV];
    scrollV.tag=100;
    
    followBtn = [LooperToolClass createBtnImageNameReal:@"btn_activity_unfollow.png" andRect:CGPointMake(245*DEF_Adaptation_Font*0.5,284*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"btn_activity_follow.png" andClickImage:@"btn_activity_follow.png" andTextStr:nil andSize:CGSizeMake(151*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [scrollV addSubview:followBtn];
//关注按钮
//    if([[_clubData objectForKey:@"islike"]intValue]==1){
//        [followBtn setSelected:true];
//    }
    
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
    HorizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,490*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,[self.footprint count]*410*DEF_Adaptation_Font*0.5)];
    HorizontalScroll.showsHorizontalScrollIndicator = true;
    [HorizontalScroll setPagingEnabled:true];
    HorizontalScroll.delegate=self;
    HorizontalScroll.tag=101;
    
    [HorizontalScroll setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    HorizontalScroll.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*3, [self.footprint count]*410*DEF_Adaptation_Font*0.5);
    
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
        
    }
    
    
  
    
}


#pragma -HXImageDelegate
-(void)createActiveView:(UITapGestureRecognizer *)tap{
//liveshow 跳转
    NSLog(@"%ld",tap.view.tag);
    
//    for (int i=0;i<[[_clubData objectForKey:@"information"] count] ;i++){
//
//
//        if([[[[_clubData objectForKey:@"information"] objectAtIndex:i] objectForKey:@"activityid"] intValue] ==tap.view.tag){
//            [_obj addActivityDetailView:[[_clubData objectForKey:@"information"] objectAtIndex:i] andPhotoWall:0];
//
//            break;
//        }
    
        
//    }
}
-(void)onClickView:(UITapGestureRecognizer *)tap{
//相册跳转
    [_imageViews removeAllObjects];
    
    int tag = tap.view.tag;
    _XHViewer = [[XHImageViewer alloc] init];
    _XHViewer.delegate = self;
    [self addSubview:_XHViewer];
    
//    for (int i=0;i<[[[_clubData objectForKey:@"data"] objectForKey:@"avatar"] count];i++){
        UIImageView *tempImageView = [[UIImageView alloc] init];
        tempImageView.frame = CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width, 0);
        
//        [tempImageView loadWithURL:[NSURL URLWithString:[[[_clubData objectForKey:@"data"] objectForKey:@"avatar"] objectAtIndex:i]] placeholer:nil showActivityIndicatorView:YES];
    
        //tempImageView.image = (UIImage*)[[commodity_images_arr objectAtIndex:i] image];
        [tempImageView setBackgroundColor:[UIColor whiteColor]];
        [_imageViews addObject:tempImageView];
//    }
    
//    if([[[_clubData objectForKey:@"data"] objectForKey:@"avatar"] count]==1){
//        [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:0] andType:0];
//    }else{
//        [imageViewer showWithImageViews:_imageViews selectedView:(UIImageView*)[_imageViews objectAtIndex:tag] andType:0];
//    }
    
}


- (void)imageViewer:(XHImageViewer *)imageViewer finishWithSelectedView:(NSArray*)ImageArray{
    
    
}

- (void)imageViewer:(XHImageViewer *)imageViewer willDismissWithSelectedView:(UIImageView *)selectedView {
    
}


#pragma -UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
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
@end
