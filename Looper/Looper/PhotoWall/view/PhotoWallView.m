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

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)dataSource{


    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView:dataSource];
    }
    return self;
    

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
    [self addSubview:photoWallCollectionV];
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    

    if(button.tag==106){
    
    
        
    }else if (button.tag==101){
    
    
        [_obj popController];
    }else if (button.tag==107){
        
        
        [_obj createSendPhotoWall];
        
        
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

    UILabel *activityName = [LooperToolClass createLableView:CGPointMake(212*DEF_Adaptation_Font_x*0.5, 136*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(386*DEF_Adaptation_Font_x*0.5, 68*DEF_Adaptation_Font_x*0.5) andText:[[_dataSource objectForKey:@"activity"]objectForKey:@"activityname"] andFontSize:17 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    activityName.numberOfLines=0;
    [activityName sizeToFit];
    [view addSubview:activityName];
    
    
    UILabel *spaceName = [LooperToolClass createLableView:CGPointMake(240*DEF_Adaptation_Font_x*0.5, 225*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(240*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:[[_dataSource objectForKey:@"activity"]objectForKey:@"place"] andFontSize:11 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [view addSubview:spaceName];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 316*DEF_Adaptation_Font*0.5, 554*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    line.image=[UIImage imageNamed:@"bg_now.png"];
    [view addSubview:line];
    
    UIImageView *location = [[UIImageView alloc] initWithFrame:CGRectMake(214*DEF_Adaptation_Font*0.5, 227*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5, 19*DEF_Adaptation_Font*0.5)];
    location.image=[UIImage imageNamed:@"locaton1.png"];
    [view addSubview:location];
    
    UIButton* activityBtn = [LooperToolClass createBtnImageNameReal:@"moveDetail.png" andRect:CGPointMake(490*DEF_Adaptation_Font*0.5,222*DEF_Adaptation_Font*0.5) andTag:106 andSelectImage:@"moveDetail.png" andClickImage:@"moveDetail.png" andTextStr:nil andSize:CGSizeMake(108*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:activityBtn];

    UIButton* sendActivityBtn = [LooperToolClass createBtnImageNameReal:@"sendActive.png" andRect:CGPointMake(120*DEF_Adaptation_Font*0.5,526*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"sendActive.png" andClickImage:@"sendActive.png" andTextStr:nil andSize:CGSizeMake(476*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:sendActivityBtn];
    
    UIScrollView *userScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 374*DEF_Adaptation_Font*0.5, 554*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    userScrollV.showsVerticalScrollIndicator = NO;
    userScrollV.showsHorizontalScrollIndicator = NO;
    [view addSubview:userScrollV];
    
    for (int i=0;i<[[_dataSource objectForKey:@"user"] count];i++){
        
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(0+(i*96*DEF_Adaptation_Font*0.5),0, 76*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
        [userImage sd_setImageWithURL:[[NSURL alloc] initWithString:[[[_dataSource objectForKey:@"user"]objectAtIndex:i] objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        userImage.layer.cornerRadius = 76*DEF_Adaptation_Font_x*0.5/2;
        userImage.layer.masksToBounds = YES;
        [userScrollV addSubview:userImage];
    }
    [userScrollV setContentSize:CGSizeMake([[_dataSource objectForKey:@"user"] count]*96*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
        //添加头视图的内容
        
        [self createHeaderView:header];
        
        
        return header;
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_SCREEN_WIDTH, 590*DEF_Adaptation_Font*0.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[[_dataSource objectForKey:@"data"] objectAtIndex:indexPath.row]];
    
    
    if([dic objectForKey:@"boardvideo"]!=[NSNull null]){
         return  CGSizeMake(DEF_SCREEN_WIDTH, 618*DEF_Adaptation_Font*0.5);
    }else if([[dic objectForKey:@"boardimage"] count]==1){
         return  CGSizeMake(DEF_SCREEN_WIDTH, 618*DEF_Adaptation_Font*0.5);
    }else if([[dic objectForKey:@"boardimage"] count]>1){
        return  CGSizeMake(DEF_SCREEN_WIDTH, 574*DEF_Adaptation_Font*0.5);
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
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(45*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    [headView sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"userimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    headView.layer.cornerRadius = 68*DEF_Adaptation_Font_x*0.5/2;
    headView.layer.masksToBounds = YES;
    [cell.contentView addSubview:headView];
    
    
    UILabel *userName = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 10*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 30*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"username"] andFontSize:11 andColor:[UIColor colorWithRed:35/255.0 green:208/255.0 blue:215/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell.contentView addSubview:userName];
    
    UILabel *boardText = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(478*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:[dic objectForKey:@"boardtext"] andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    boardText.numberOfLines=0;
    [boardText sizeToFit];
    [cell.contentView addSubview:boardText];
    
    
    if([dic objectForKey:@"boardvideo"]!=[NSNull null]){
        
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSURL alloc ]initWithString:[dic objectForKey:@"boardvideo"]] options:nil];
//        
//        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//        
//        gen.appliesPreferredTrackTransform = YES;
//        
//        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//        
//        NSError *error = nil;
//        
//        CMTime actualTime;
//        
//        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//        
//        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
//        
//        CGImageRelease(image);
        
        UIImageView *videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(137*DEF_Adaptation_Font*0.5, 195*DEF_Adaptation_Font*0.5, 423*DEF_Adaptation_Font*0.5, 277*DEF_Adaptation_Font*0.5)];
        //videoImg.image = thumb;
        [videoImg setBackgroundColor:[UIColor redColor]];
        [cell.contentView addSubview:videoImg];
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
        [self createCellView:indexPath andCell:cell];
        return cell;
    }
}


-(void)createHudView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
}




-(void)initView:(NSDictionary*)dic{
    _dataSource = [[NSDictionary alloc] initWithDictionary:dic copyItems:true];

    [self setBackgroundColor: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];

    [self createColloectionView];
    
    [self createHudView];
}


@end
