//
//  DJDetailView.m
//  Looper
//
//  Created by lujiawei on 27/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "DJDetailView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "nActivityViewModel.h"
#import "UIImageView+WebCache.h"



@implementation DJDetailView{
    
    UIScrollView *scrollV;
    
    
    UIImageView *headImageView;
    
    NSDictionary *_djData;
    
    UIView *selectView;
    
    UIButton *activeBtn;
    
    UIButton *detailBtn;

    UIScrollView *HorizontalScroll;
    
    
    float ScrollNum_y;
    
    
    UIButton *followBtn;
    
    UIView *ShowselectView;
    
    UIImageView *lineImage;
    
    
    UIButton *activeBtn1;
    UIButton *detailBtn1;
    UIImageView *shadowV;
    
    
    float scrollOffNum_y;
    
     NSString *_localId;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)djData{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        
        [self initView:djData];
        
    }
    return self;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==101){
        [self removeFromSuperview];
        if (_isFromSearchView) {
            [self.obj popController];
        }
    }else if(button.tag==102){
        [_obj shareh5View:nil];
    }else if(button.tag==104){
        [detailBtn setSelected:false];
        [activeBtn setSelected:true];
        
        [detailBtn1 setSelected:false];
        [activeBtn1 setSelected:true];
        
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(0, HorizontalScroll.contentOffset.y) animated:true];
            [lineImage setFrame:CGRectMake(206*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
        }];
    }else if(button.tag==105){
        [activeBtn setSelected:false];
        [detailBtn setSelected:true];
        [activeBtn1 setSelected:false];
        [detailBtn1 setSelected:true];

        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(DEF_SCREEN_WIDTH, HorizontalScroll.contentOffset.y) animated:true];
            [lineImage setFrame:CGRectMake(399*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            
        }];
    }else if(button.tag==107){
        if([followBtn isSelected]==true){
            
            [followBtn setSelected:false];
            [_obj followBrand:_localId andisLike:0 andType:1];
        }else{
            [followBtn setSelected:true];
            [_obj followBrand:_localId andisLike:1 andType:1];
            
        }

    }
}


-(void)createHudView{
    
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
//    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
//    [self addSubview:shareBtn];

}

-(void)initView:(NSDictionary*)data{
    _djData = data;
    _localId = [[data objectForKey:@"data"] objectForKey:@"djid"];
    [self setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [self createImageViewHud];
    [self createScrollView];
    [self createHudView];
    
    [self createSelectLableView];
}

-(void)createSelectLableView{

    
    ShowselectView= [[UIView alloc] initWithFrame:CGRectMake(0, 115*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 41*DEF_Adaptation_Font*0.5)];
    
    [ShowselectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    activeBtn1 = [LooperToolClass createBtnImageNameReal:@"btn_unActive1.png" andRect:CGPointMake(188*DEF_Adaptation_Font*0.5,0*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"btn_Active1.png" andClickImage:@"btn_Active1.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTarget:self];
    [ShowselectView addSubview:activeBtn1];
    
    [activeBtn1 setSelected:true];
    
    detailBtn1 = [LooperToolClass createBtnImageNameReal:@"btn_unDetail.png" andRect:CGPointMake(380*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"btn_Detail.png" andClickImage:@"btn_Detail.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [ShowselectView addSubview:detailBtn1];
    
    [self addSubview:ShowselectView];
    
    [ShowselectView setHidden:true];
}


-(void)createImageViewHud{
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [headImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[[[_djData objectForKey:@"data"]objectForKey:@"avatar"] objectAtIndex:0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            if (image.size.height>image.size.width) {//图片的高要大于与宽
                CGRect rect = CGRectMake(0, image.size.height/2-image.size.width/2, image.size.width, image.size.width);//创建矩形框
                CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                headImageView.image=[UIImage imageWithCGImage:cgimg];
                CGImageRelease(cgimg);
            }else{
                CGRect rect = CGRectMake(image.size.width/2-image.size.height/2, 0, image.size.height, image.size.height);//创建矩形框
                CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                headImageView.image=[UIImage imageWithCGImage:cgimg];
                CGImageRelease(cgimg);
            }
        }
    }];
    
    [self addSubview:headImageView];
    
    shadowV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [shadowV setImage:[UIImage imageNamed:@"shadowTopDown.png"]];
    [self addSubview:shadowV];
    
    UILabel *songer = [[UILabel alloc] initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 512*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5)];
    songer.text=[[_djData objectForKey:@"data"]objectForKey:@"djname"];
    [songer setTextColor:[UIColor whiteColor]];
    [songer setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:24]];
    [songer setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:songer];
    
    UIImageView *icon_songer = [[UIImageView alloc] initWithFrame:CGRectMake(239*DEF_Adaptation_Font*0.5, 278*DEF_Adaptation_Font*0.5, 103*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5)];
    [icon_songer setImage:[UIImage imageNamed:@"icon_songer.png"]];
    [self addSubview:icon_songer];
    
    
//    followBtn = [LooperToolClass createBtnImageNameReal:@"btn_activity_unfollow.png" andRect:CGPointMake(245*DEF_Adaptation_Font*0.5,404*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"btn_activity_follow.png" andClickImage:@"btn_activity_follow.png" andTextStr:nil andSize:CGSizeMake(151*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
//    [self addSubview:followBtn];
    
}

-(void)createScrollView{
    
    scrollV  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 120*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-113*DEF_Adaptation_Font*0.5)];
    scrollV.showsVerticalScrollIndicator = true;
    scrollV.delegate=self;
    scrollV.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, [[_djData objectForKey:@"information"] count]*410*DEF_Adaptation_Font*0.5+490*DEF_Adaptation_Font*0.5);
    
    [self addSubview:scrollV];
    scrollV.tag=100;
    
    
    followBtn = [LooperToolClass createBtnImageNameReal:@"btn_activity_unfollow.png" andRect:CGPointMake(245*DEF_Adaptation_Font*0.5,284*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"btn_activity_follow.png" andClickImage:@"btn_activity_follow.png" andTextStr:nil andSize:CGSizeMake(151*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [scrollV addSubview:followBtn];
    
    
    if([[_djData objectForKey:@"islike"]intValue]==1){
        [followBtn setSelected:true];
    }
    
    [self createHorizontalScroll];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //做一些滑动完成后的操作
    
    if(scrollView.tag==101){
        
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if(page==1){
            
            [detailBtn setSelected:true];
            [activeBtn setSelected:false];
            [detailBtn1 setSelected:true];
            [activeBtn1 setSelected:false];
            [UIView animateWithDuration:0.3 animations:^{
                [lineImage setFrame:CGRectMake(399*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            }];
        }else if(page==0){
            [detailBtn setSelected:false];
            [activeBtn setSelected:true];
            [detailBtn1 setSelected:false];
            [activeBtn1 setSelected:true];
            [UIView animateWithDuration:0.3 animations:^{
                [lineImage setFrame:CGRectMake(206*DEF_Adaptation_Font*0.5, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height)];
            }];
        }
        
    }else {
        
    }
    
}



//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if(scrollView.contentOffset.y==0){
//    
//        followBtn.frame=CGRectMake(followBtn.frame.origin.x, 284*DEF_Adaptation_Font*0.5, followBtn.frame.size.width, followBtn.frame.size.height);
//    }
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset  = scrollView.contentOffset.y;
    if(scrollView.tag==100){
        
        if(scrollView.contentOffset.y>224){
            ShowselectView.hidden=false;
        }else{
            ShowselectView.hidden=true;
        }
        
       // if(scrollView.contentOffset.y>0 &&scrollView.contentOffset.y<60){
            followBtn.frame=CGRectMake(followBtn.frame.origin.x, followBtn.frame.origin.y+(yOffset-ScrollNum_y), followBtn.frame.size.width, followBtn.frame.size.height);
       // }
        
        CGPoint offset = scrollView.contentOffset;
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

-(void)createHorizontalScroll{
    

    
    selectView= [[UIView alloc] initWithFrame:CGRectMake(0, 490*DEF_Adaptation_Font*0.5-113*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 113*DEF_Adaptation_Font*0.5)];
    
    [selectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,65*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH*2, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:63/255.0 alpha:0.8]];
    [selectView addSubview:line];

    
    lineImage  =[[UIImageView alloc] initWithFrame:CGRectMake(206*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    lineImage.image = [UIImage imageNamed:@"bg_line_label.png"];
    [selectView addSubview:lineImage];
    
    
    activeBtn = [LooperToolClass createBtnImageNameReal:@"btn_unActive1.png" andRect:CGPointMake(188*DEF_Adaptation_Font*0.5,14*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"btn_Active1.png" andClickImage:@"btn_Active1.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:activeBtn];
    
    [activeBtn setSelected:true];
    
    detailBtn = [LooperToolClass createBtnImageNameReal:@"btn_unDetail.png" andRect:CGPointMake(380*DEF_Adaptation_Font*0.5, 14*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"btn_Detail.png" andClickImage:@"btn_Detail.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:detailBtn];
    
    [scrollV addSubview:selectView];

    
    HorizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,490*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, [[_djData objectForKey:@"information"] count]*410*DEF_Adaptation_Font*0.5)];
    HorizontalScroll.showsHorizontalScrollIndicator = true;
    [HorizontalScroll setPagingEnabled:true];
    HorizontalScroll.delegate=self;
    HorizontalScroll.tag=101;
    
    [HorizontalScroll setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    HorizontalScroll.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*2, [[_djData objectForKey:@"information"] count]*410*DEF_Adaptation_Font*0.5);
    
    [scrollV addSubview:HorizontalScroll];

    [self createScrollDataView];
}


-(void)createActiveView:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);

    for (int i=0;i<[[_djData objectForKey:@"information"] count] ;i++){
        if([[[[_djData objectForKey:@"information"] objectAtIndex:i] objectForKey:@"activityid"] intValue] ==tap.view.tag){
            [_obj addActivityDetailView:[[_djData objectForKey:@"information"] objectAtIndex:i] andPhotoWall:0];

            break;
        }
    }
}


-(void)createActiveCellView:(NSDictionary*)data andBgView:(UIView*)view{
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5,44*DEF_Adaptation_Font*0.5, 210*DEF_Adaptation_Font*0.5, 308*DEF_Adaptation_Font*0.5)];
    [imageV sd_setImageWithURL:[[NSURL alloc] initWithString: [data objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    imageV.tag = [[data objectForKey:@"activityid"] intValue];
    imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createActiveView:)];
    [imageV addGestureRecognizer:singleTap];
    
    imageV.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    imageV.layer.masksToBounds = YES;
    [view addSubview:imageV];

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(276*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 78*DEF_Adaptation_Font*0.5)];
    titleLable.numberOfLines = 0;
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:20]];
    titleLable.text = [data objectForKey:@"activityname"];
    [view addSubview:titleLable];
    UILabel *tagLable=nil;
    if ([data objectForKey:@"tag"]==[NSNull null]) {
        tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
    }else{
    tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,[self getContentLength:[data objectForKey:@"tag"]]+15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
        tagLable.text = [data objectForKey:@"tag"];
    }
    [tagLable setTextColor:[UIColor whiteColor]];
    [tagLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
    [tagLable setBackgroundColor:[UIColor colorWithRed:25/255.0 green:196/255.0 blue:193/255.0 alpha:1.0]];
    [view addSubview:tagLable];
    [tagLable setTextAlignment:NSTextAlignmentCenter];
    tagLable.layer.cornerRadius = 13*DEF_Adaptation_Font*0.5;
    tagLable.layer.masksToBounds = YES;
    
    UIImageView *icon_time=[LooperToolClass createImageView:@"time.png" andRect:CGPointMake(276, 200) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_time];
    
     icon_time.frame = CGRectMake(icon_time.frame.origin.x, icon_time.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);
    
    UIImageView *icon_location=[LooperToolClass createImageView:@"locaton.png" andRect:CGPointMake(276, 242) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_location];
    
    icon_location.frame = CGRectMake(icon_location.frame.origin.x, icon_location.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);

    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    [timeLable setTextColor:[UIColor whiteColor]];
    [timeLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    timeLable.text = [data objectForKey:@"starttime"];
    [view addSubview:timeLable];
   
    
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)];
    [locationLable setTextColor:[UIColor whiteColor]];
    locationLable.numberOfLines=0;
    [locationLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    locationLable.text = [data objectForKey:@"location"];
    [locationLable sizeToFit];
    [view addSubview:locationLable];

    CGSize maximumSize = CGSizeMake(294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5);
    NSString *dateString = [data objectForKey:@"location"];
    UIFont *dateFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    CGSize dateStringSize = [dateString sizeWithFont:dateFont
                                   constrainedToSize:maximumSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    CGRect dateFrame = CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, dateStringSize.height);
    locationLable.frame = dateFrame;
    
    if([data[@"ticketurl"] isEqualToString:@""]==true){
     
        UIImageView *icon_price=[LooperToolClass createImageView:@"icon_price.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_price];
    }else{
        UIImageView *icon_ticket=[LooperToolClass createImageView:@"icon_ticket.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_ticket];
    }
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(368*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 235*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5)];
    [priceLable setTextColor:[UIColor colorWithRed:191/255.0 green:252/255.0 blue:255/255.0 alpha:1.0]];
    [priceLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    priceLable.text = [data objectForKey:@"price"];
    [view addSubview:priceLable];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, view.frame.size.height, 568*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:160/255.0 green:138/255.0 blue:197/255.0 alpha:0.1f]];
    [view addSubview:line];

}


-(int)getContentLength:(NSString*)contentStr{
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +19*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    return num_x;
}




-(void)createScrollDataView{
    
 
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH+41*DEF_Adaptation_Font*0.5,25*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5)];
    [titleView setBackgroundColor:[UIColor colorWithRed:208/255.0 green:255/255.0 blue:107/255.0 alpha:1.0]];
    titleView.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    titleView.layer.masksToBounds = YES;
    [HorizontalScroll addSubview:titleView];
    
    UILabel *djName =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH+64*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 536*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    djName.text =   [NSString stringWithFormat:@"%@ 简介",[[_djData objectForKey:@"data"]objectForKey:@"djname"]];
    [djName setFont:[UIFont fontWithName:@"PingFangSC" size:24]];
    [HorizontalScroll addSubview:djName];
    [djName setTextColor:[UIColor colorWithRed:208/255.0 green:255/255.0 blue:107/255.0 alpha:1.0]];
    
    UILabel *djDetail =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH+40*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 560*DEF_Adaptation_Font*0.5, 700*DEF_Adaptation_Font*0.5)];
    djDetail.numberOfLines=0;
    [djDetail setTextColor:[UIColor whiteColor]];
    djDetail.text = [[_djData objectForKey:@"data"]objectForKey:@"djdes"];
    [HorizontalScroll addSubview:djDetail];
    [djDetail setFont:[UIFont fontWithName:@"PingFangSC-Thin" size:16]];
    [djDetail sizeToFit];
    
    for (int i=0;i<[[_djData objectForKey:@"information"] count] ;i++){
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20*DEF_Adaptation_Font*0.5+(i*410*DEF_Adaptation_Font*0.5), DEF_SCREEN_WIDTH, 410*DEF_Adaptation_Font*0.5)];

        [HorizontalScroll addSubview:bgView];
        
        
        bgView.tag = [[[[_djData objectForKey:@"information"] objectAtIndex:i] objectForKey:@"activityid"] intValue];
        bgView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createActiveView:)];
        [bgView addGestureRecognizer:singleTap];

        
        [self createActiveCellView:[[_djData objectForKey:@"information"] objectAtIndex:i] andBgView:bgView];

    }

}




@end
