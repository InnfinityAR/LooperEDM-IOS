//
//  PhotoWallView.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallView.h"
#import "PhotoWallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "PhotoWallCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation PhotoWallView{


    UICollectionView *photoWallCollectionV;

    NSMutableDictionary *_dataSource;
    
    UIButton* punchCardBtn;
      
    UIButton *sendPhoto;
    


}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)dataSource{


    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView:dataSource];
    }
    return self;
    

}

-(void)reloadData:(NSDictionary*)dataSource{

    _dataSource = [[NSMutableDictionary alloc] initWithDictionary:dataSource];
    
    
    [photoWallCollectionV reloadData];

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    if(scrollView.tag==200){
    
        NSLog(@"%f",yOffset);
        
        if(yOffset>370){
            sendPhoto.hidden=false;
        }else{
            sendPhoto.hidden=true;
        }
    }
}


-(void)createColloectionView{
    
    UICollectionViewFlowLayout *viewFlowLayOut = [[UICollectionViewFlowLayout alloc] init];
    
    photoWallCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:viewFlowLayOut];
    
    [photoWallCollectionV registerClass:[PhotoWallCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    [photoWallCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID"];
    photoWallCollectionV.dataSource = self;
    photoWallCollectionV.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    photoWallCollectionV.delegate = self;
    photoWallCollectionV.alwaysBounceVertical = YES;
    
    photoWallCollectionV.scrollsToTop =YES;
    photoWallCollectionV.scrollEnabled = YES;
    photoWallCollectionV.showsVerticalScrollIndicator = FALSE;
    photoWallCollectionV.showsHorizontalScrollIndicator = FALSE;
    [photoWallCollectionV setBackgroundColor:[UIColor clearColor]];
    photoWallCollectionV.tag = 200;
    [self addSubview:photoWallCollectionV];
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    

    if(button.tag==106){
    
        [_obj createActivityView];
        
    }else if (button.tag==101){
    
    
        [_obj popController];
    }else if (button.tag==107){
        
        
        [_obj createSendPhotoWall];
        
        
    }else if (button.tag==125){
        
        
        [_obj createSendPhotoWall];
        
        
    }else if (button.tag==109){
        
        if([punchCardBtn isSelected]==true){
            
        }else{
           // activityid
            [_obj punchTheClock:[[_dataSource objectForKey:@"activity"] objectForKey:@"activityid"] ];
            //[_obj punchTheClock:@"218"];
            
        }
    }

}


-(void)updatePunch:(int)num{
    if(num==1){
        [punchCardBtn setSelected:true];
        
    }else{
        [punchCardBtn setSelected:false];
        
    }
}



-(void)createHeaderView:(UIView*)view{
    
    
    UIImageView *headBk = [[UIImageView alloc] initWithFrame:CGRectMake(38*DEF_Adaptation_Font*0.5, 126*DEF_Adaptation_Font*0.5, 153*DEF_Adaptation_Font*0.5, 153*DEF_Adaptation_Font*0.5)];
    headBk.image=[UIImage imageNamed:@"head_circle.png"];
    [view addSubview:headBk];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(47*DEF_Adaptation_Font*0.5, 135*DEF_Adaptation_Font*0.5, 136*DEF_Adaptation_Font*0.5, 136*DEF_Adaptation_Font*0.5)];
    [headView sd_setImageWithURL:[[NSURL alloc] initWithString:[[_dataSource objectForKey:@"activity"]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    headView.layer.cornerRadius = 136*DEF_Adaptation_Font_x*0.5/2;
    headView.layer.masksToBounds = YES;
    [view addSubview:headView];

    UILabel *activityName = [LooperToolClass createLableView:CGPointMake(212*DEF_Adaptation_Font_x*0.5, 100*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(386*DEF_Adaptation_Font_x*0.5, 139*DEF_Adaptation_Font_x*0.5) andText:[[_dataSource objectForKey:@"activity"]objectForKey:@"activityname"] andFontSize:16 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    activityName.numberOfLines=0;
    [view addSubview:activityName];
    
    
    UILabel *spaceName = [LooperToolClass createLableView:CGPointMake(240*DEF_Adaptation_Font_x*0.5, 225*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(240*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:[[_dataSource objectForKey:@"activity"]objectForKey:@"place"] andFontSize:11 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [view addSubview:spaceName];
    
    
    UIImageView *timeFrame = [[UIImageView alloc] initWithFrame:CGRectMake(8*DEF_Adaptation_Font*0.5, 526*DEF_Adaptation_Font*0.5, 94*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
    timeFrame.image=[UIImage imageNamed:@"timeFrame.png"];
    [view addSubview:timeFrame];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    
    // 毫秒值转化为秒
    
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:nowDate];
    NSString* dateString = [formatter stringFromDate:date];
    
    UILabel *nowTimeLable = [LooperToolClass createLableView:CGPointMake(18*DEF_Adaptation_Font_x*0.5, 542*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(76*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andText:dateString andFontSize:8 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [view addSubview:nowTimeLable];
    
    [nowTimeLable setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:9]];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 325*DEF_Adaptation_Font*0.5, 554*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    line.image=[UIImage imageNamed:@"bg_now.png"];
    [view addSubview:line];
    
    
    UIImageView *location = [[UIImageView alloc] initWithFrame:CGRectMake(214*DEF_Adaptation_Font*0.5, 227*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5, 19*DEF_Adaptation_Font*0.5)];
    location.image=[UIImage imageNamed:@"locaton1.png"];
    [view addSubview:location];
    
    UIButton* activityBtn = [LooperToolClass createBtnImageNameReal:@"moveDetail.png" andRect:CGPointMake(490*DEF_Adaptation_Font*0.5,222*DEF_Adaptation_Font*0.5) andTag:106 andSelectImage:@"moveDetail.png" andClickImage:@"moveDetail.png" andTextStr:nil andSize:CGSizeMake(108*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:activityBtn];

    UIButton* sendActivityBtn = [LooperToolClass createBtnImageNameReal:@"sendActive.png" andRect:CGPointMake(128*DEF_Adaptation_Font*0.5,526*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"sendActive.png" andClickImage:@"sendActive.png" andTextStr:nil andSize:CGSizeMake(476*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:sendActivityBtn];
    
    UIScrollView *userScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 374*DEF_Adaptation_Font*0.5, 554*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    userScrollV.showsVerticalScrollIndicator = NO;
    userScrollV.showsHorizontalScrollIndicator = NO;
    [view addSubview:userScrollV];
    
    for (int i=0;i<[[_dataSource objectForKey:@"user"] count];i++){
        
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(0+(i*96*DEF_Adaptation_Font*0.5),0, 76*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
        [userImage sd_setImageWithURL:[[NSURL alloc] initWithString:[[[_dataSource objectForKey:@"user"]objectAtIndex:i] objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        userImage.tag= [[[[_dataSource objectForKey:@"user"]objectAtIndex:i] objectForKey:@"userid"] intValue];
        
        userImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserBtn:)];
        [userImage addGestureRecognizer:singleTap];

        
        userImage.layer.cornerRadius = 76*DEF_Adaptation_Font_x*0.5/2;
        userImage.layer.masksToBounds = YES;
        
        
        
        [userScrollV addSubview:userImage];
    }
    [userScrollV setContentSize:CGSizeMake([[_dataSource objectForKey:@"user"] count]*96*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    
    
    punchCardBtn = [LooperToolClass createBtnImageNameReal:@"punchCard.png" andRect:CGPointMake(267*DEF_Adaptation_Font*0.5,275*DEF_Adaptation_Font*0.5) andTag:109 andSelectImage:@"enpunchCard.png" andClickImage:@"punchCard.png" andTextStr:nil andSize:CGSizeMake(140*DEF_Adaptation_Font*0.5,35*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:punchCardBtn];
    
    if([[_dataSource objectForKey:@"ispunch"] intValue]==1){
        
        [punchCardBtn setSelected:true];
        
    }

}

-(void)clickUserBtn:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    [_obj createPlayerView:tap.view.tag];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
        //添加头视图的内容
        
        for (UIView *view in [header subviews]){
            
            [view removeFromSuperview];
        }
        
        
        [self createHeaderView:header];
        
        
        return header;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_SCREEN_WIDTH, 612*DEF_Adaptation_Font*0.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[[_dataSource objectForKey:@"data"] objectAtIndex:indexPath.row]];
    
    
    if([dic objectForKey:@"boardvideo"]!=[NSNull null]){
        
        UILabel *boardText = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"boardtext"] andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
        boardText.numberOfLines=0;
        [boardText sizeToFit];

         return  CGSizeMake(DEF_SCREEN_WIDTH, 803*DEF_Adaptation_Font*0.5+boardText.frame.size.height);
    }else if([[dic objectForKey:@"boardimage"] count]==1){
        UILabel *boardText = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"boardtext"] andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
        boardText.numberOfLines=0;
        [boardText sizeToFit];
        return  CGSizeMake(DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5+boardText.frame.size.height);
    }else if([[dic objectForKey:@"boardimage"] count]>1){
        UILabel *boardText = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"boardtext"] andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
        boardText.numberOfLines=0;
        [boardText sizeToFit];
        return  CGSizeMake(DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5+boardText.frame.size.height);
    }
    return  CGSizeMake(DEF_SCREEN_WIDTH, 618*DEF_Adaptation_Font*0.5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    
    
    
    
}


//设置每个item与上左下右四个方向的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0,0, 2, 2);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_dataSource objectForKey:@"data"] count];
}

-(void)createCellView:(NSIndexPath *)indexPath andCell:(UICollectionViewCell*)cell{

    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[[_dataSource objectForKey:@"data"] objectAtIndex:indexPath.row]];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(25*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    [headView sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"userimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    headView.tag= [[dic objectForKey:@"userid"] intValue];
    
    headView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserBtn:)];
    [headView addGestureRecognizer:singleTap];
    
    headView.layer.cornerRadius = 68*DEF_Adaptation_Font_x*0.5/2;
    headView.layer.masksToBounds = YES;
    [cell.contentView addSubview:headView];
    
    UILabel *userName = [LooperToolClass createLableView:CGPointMake(119*DEF_Adaptation_Font_x*0.5, 10*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 30*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"username"] andFontSize:14 andColor:[UIColor colorWithRed:35/255.0 green:208/255.0 blue:215/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell.contentView addSubview:userName];
    
    UILabel *boardText = [LooperToolClass createLableView:CGPointMake(119*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"boardtext"] andFontSize:16 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    
     [boardText setFont:[UIFont fontWithName:@"PingFangSC-Light" size:16]];
    
    boardText.numberOfLines=0;
    [boardText sizeToFit];
    [cell.contentView addSubview:boardText];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"creationdate"] doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    UILabel *timeText = [LooperToolClass createLableView:CGPointMake(34*DEF_Adaptation_Font_x*0.5, 100*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(58*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:dateString andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];

    [cell.contentView addSubview:timeText];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"MM-dd"];
    // 毫秒值转化为秒
    NSDate* date1 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"creationdate"] doubleValue]];
    NSString* dateString1 = [formatter1 stringFromDate:date1];
    
    UILabel *dayText = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font_x*0.5, 135*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(50*DEF_Adaptation_Font_x*0.5, 14*DEF_Adaptation_Font_x*0.5) andText:dateString1 andFontSize:8 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:0.7] andType:NSTextAlignmentCenter];
    
    [cell.contentView addSubview:dayText];
    
    if([dic objectForKey:@"boardvideo"]!=[NSNull null]){

        UIImageView *videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(119*DEF_Adaptation_Font*0.5, (boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5, 415*DEF_Adaptation_Font*0.5,629*DEF_Adaptation_Font*0.5)];
        if([dic objectForKey:@"videothumb"]!=[NSNull null]){
        
            [videoImg sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"videothumb"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
        }];
        }
        videoImg.layer.cornerRadius = 10 *DEF_Adaptation_Font_x*0.5;
        videoImg.layer.masksToBounds = YES;

        [cell.contentView addSubview:videoImg];
        videoImg.userInteractionEnabled=YES;
        
        UIButton *videoPlay = [LooperToolClass createBtnImageNameReal:@"icon_play.png" andRect:CGPointMake(173*DEF_Adaptation_Font*0.5,280*DEF_Adaptation_Font*0.5) andTag:[[dic objectForKey:@"boardid"] intValue] andSelectImage:@"icon_play.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5) andTarget:self];
        [videoImg addSubview:videoPlay];
        [videoPlay removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
        [videoPlay addTarget:self action:@selector(videoOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *commend = [LooperToolClass createBtnImageNameReal:@"btn_un_commend.png" andRect:CGPointMake(119*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+629*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5) andTag:[[dic objectForKey:@"boardid"] intValue] andSelectImage:@"btn_commend.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5) andTarget:self];
        [cell.contentView addSubview:commend];
        
        [commend removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
        [commend addTarget:self action:@selector(commendOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        if([[dic objectForKey:@"islike"] intValue]==1){
            
            [commend setSelected:true];
        }
        
        UILabel *personNum = [LooperToolClass createLableView:CGPointMake(180*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+629*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5+16*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(56*DEF_Adaptation_Font_x*0.5, 17*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"%@ 人",[dic objectForKey:@"thumbcount"]] andFontSize:10 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:0.7] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:personNum];

    }else{
        
        UIScrollView *ImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(119*DEF_Adaptation_Font*0.5, (boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5, 520*DEF_Adaptation_Font*0.5, 330*DEF_Adaptation_Font*0.5)];
        ImageView.showsVerticalScrollIndicator = NO;
        ImageView.showsHorizontalScrollIndicator = NO;
        [cell.contentView addSubview:ImageView];
        
        for (int i=0;i<[[dic objectForKey:@"boardimage"] count];i++)
        {
            UIImageView *djViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5+(i*360*DEF_Adaptation_Font*0.5), 0, 330*DEF_Adaptation_Font*0.5,  330*DEF_Adaptation_Font*0.5)];
            djViewHead.layer.cornerRadius = 10 *DEF_Adaptation_Font_x*0.5;
            djViewHead.layer.masksToBounds = YES;
            [djViewHead sd_setImageWithURL:[[NSURL alloc] initWithString:[[dic objectForKey:@"boardimage"] objectAtIndex:i] ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (image != nil) {
                    if (image.size.height>image.size.width) {//图片的高要大于与宽
                        CGRect rect = CGRectMake(0, image.size.height/2-image.size.width/2, image.size.width, image.size.width);//创建矩形框
                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                        djViewHead.image=[UIImage imageWithCGImage:cgimg];
                        CGImageRelease(cgimg);
                    }else{
                        CGRect rect = CGRectMake(image.size.width/2-image.size.height/2, 0, image.size.height, image.size.height);//创建矩形框
                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                        djViewHead.image=[UIImage imageWithCGImage:cgimg];
                        CGImageRelease(cgimg);
                    }
                }
            }];
            djViewHead.tag = i;
            [ImageView addSubview:djViewHead];
            //djViewHead.userInteractionEnabled=YES;
           // UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(djViewJump:)];
           // [djViewHead addGestureRecognizer:singleTap];

        }
        ImageView.contentSize = CGSizeMake(28*DEF_Adaptation_Font*0.5 +[[dic objectForKey:@"boardimage"] count]*360*DEF_Adaptation_Font*0.5,  330*DEF_Adaptation_Font*0.5);
        UIButton *commend = [LooperToolClass createBtnImageNameReal:@"btn_un_commend.png" andRect:CGPointMake(119*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+330*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5) andTag:[[dic objectForKey:@"boardid"] intValue] andSelectImage:@"btn_commend.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5) andTarget:self];
        [cell.contentView addSubview:commend];
        
        [commend removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
        [commend addTarget:self action:@selector(commendOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        if([[dic objectForKey:@"islike"] intValue]==1){
            
            [commend setSelected:true];
        }
        
        UILabel *personNum = [LooperToolClass createLableView:CGPointMake(180*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+330*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5+16*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(56*DEF_Adaptation_Font_x*0.5, 17*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"%@ 人",[dic objectForKey:@"thumbcount"]] andFontSize:10 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:0.7] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:personNum];

    }
  

}

-(IBAction)commendOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if([button isSelected]==true){
        [button setSelected:false];
        [_obj thumbBoardMessage:[NSString stringWithFormat:@"%ld",(long)button.tag] andLike:0];
    }else{
      [button setSelected:true];
         [_obj thumbBoardMessage:[NSString stringWithFormat:@"%ld",(long)button.tag] andLike:1];
        
    }

}

-(IBAction)videoOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    NSLog(@"video");
    
    for (int i=0;i<[[_dataSource objectForKey:@"data"] count];i++){
    
        
        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[[_dataSource objectForKey:@"data"] objectAtIndex:i]];
        if([[dic objectForKey:@"boardid"] intValue]==button.tag){
            
            
            [_obj playNetWorkVideo:[dic objectForKey:@"boardvideo"]];
            

            break;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"HomeCellView";
     PhotoWallCollectionViewCell * cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[PhotoWallCollectionViewCell alloc]init];
        [self createCellView:indexPath andCell:cell];
        return cell;
    }else{
        [self createCellView:indexPath andCell:cell]
        ;
        return cell;
    }
}


-(void)createHudView{
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    sendPhoto = [LooperToolClass createBtnImageNameReal:@"btn_sendPhoto_Small.png" andRect:CGPointMake(512*DEF_Adaptation_Font*0.5,982*DEF_Adaptation_Font*0.5) andTag:125 andSelectImage:@"btn_sendPhoto_Small.png" andClickImage:@"btn_sendPhoto_Small.png" andTextStr:nil andSize:CGSizeMake(104*DEF_Adaptation_Font*0.5,104*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:sendPhoto];
    
    sendPhoto.hidden=true;
}


-(void)initView:(NSDictionary*)dic{
  
    _dataSource = [[NSDictionary alloc] initWithDictionary:dic copyItems:true];

    [self setBackgroundColor: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];

    [self createColloectionView];
    
    [self createHudView];
}


@end
