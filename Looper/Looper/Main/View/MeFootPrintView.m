//
//  MeFootPrintView.m
//  Looper
//
//  Created by lujiawei on 23/10/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MeFootPrintView.h"
#import "MainViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "PhotoWallCollectionViewCell.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"
#import "DataHander.h"


@implementation MeFootPrintView{
    

    UICollectionView *colloectionView;
    NSMutableArray *_arrayData;
    
    UITextField *textFieldComment;
    UIImageView *bgView;
    
    int  selectTextTag;
    
}


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        [self initView];
        
    }
    return self;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        
        [self removeFromSuperview];
        
        [_obj removeMeFootView];
    }
}

-(void)updataCollectionData:(NSArray*)arrayData{
    _arrayData = [[NSMutableArray alloc] initWithArray:arrayData];
    [colloectionView reloadData];
}

-(void)createBackGround{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
}

-(void)createHudView{
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
  textFieldComment=[self createTextField:@"" andImg:@"login_x_line.png" andRect:CGRectMake(0*DEF_Adaptation_Font*0.5, 885*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 68*DEF_Adaptation_Font*0.5) andTag:1001];
    
    
    
    
}

-(void)createColloectionView{
    
    UICollectionViewFlowLayout *viewFlowLayOut = [[UICollectionViewFlowLayout alloc] init];
    
    colloectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:viewFlowLayOut];
    
    [colloectionView registerClass:[PhotoWallCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    [colloectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID"];
    colloectionView.dataSource = self;
    colloectionView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    colloectionView.delegate = self;
    colloectionView.alwaysBounceVertical = YES;
    
    colloectionView.scrollsToTop =YES;
    colloectionView.scrollEnabled = YES;
    colloectionView.showsVerticalScrollIndicator = FALSE;
    colloectionView.showsHorizontalScrollIndicator = FALSE;
    [colloectionView setBackgroundColor:[UIColor clearColor]];
    colloectionView.tag = 200;
    [self addSubview:colloectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [_arrayData count];

}

-(void)createHeaderView:(UIView*)view{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting_up.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,282*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:bk];
    
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(38*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5)];
    [headIV sd_setImageWithURL:[NSURL URLWithString:[LocalDataMangaer sharedManager].HeadImageUrl] placeholderImage:[UIImage imageNamed:@"btn_looper.png"]options:SDWebImageRetryFailed];
    headIV.layer.cornerRadius=120*DEF_Adaptation_Font*0.5/2;
    headIV.layer.masksToBounds=YES;
    [view addSubview:headIV];
    
    UILabel *nickName=[[UILabel alloc]initWithFrame:CGRectMake(188*DEF_Adaptation_Font*0.5, 124*DEF_Adaptation_Font*0.5, 370*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5)];
    nickName.textColor=[UIColor whiteColor];
    nickName.font=[UIFont systemFontOfSize:17];
    nickName.text=[LocalDataMangaer sharedManager].NickName;
    [view addSubview:nickName];
    
    UILabel *clubCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(188*DEF_Adaptation_Font*0.5, 188*DEF_Adaptation_Font*0.5, 370*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5)];
    clubCountLabel.textColor=[UIColor whiteColor];
    clubCountLabel.font=[UIFont systemFontOfSize:17];
    clubCountLabel.text=[NSString stringWithFormat:@"蹦迪次数 : %d",2];
    [view addSubview:clubCountLabel];
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellView" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
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
    return cell;
}

-(float)getLableHeight:(NSString*)lableStr{
    
    UILabel *Text = [LooperToolClass createLableView:CGPointMake(137*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(418*DEF_Adaptation_Font_x*0.5, 180*DEF_Adaptation_Font_x*0.5) andText:lableStr andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    Text.numberOfLines=0;
    [Text sizeToFit];
    
    return Text.frame.size.height;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_SCREEN_WIDTH, 303*DEF_Adaptation_Font*0.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[_arrayData objectAtIndex:indexPath.row]];
    
    if([dic objectForKey:@"boardvideo"]!=[NSNull null]){
        
        float num_y = 0;
        for (int i=0;i<[[dic objectForKey:@"message"] count];i++){
            NSDictionary *indexDic = [[dic objectForKey:@"message"] objectAtIndex:i];
            num_y = num_y+[self getLableHeight:[indexDic objectForKey:@"messagecontent"]];
            num_y = num_y+53*DEF_Adaptation_Font*0.5;

        }
        NSLog(@"%f",num_y);
        
        return  CGSizeMake(DEF_SCREEN_WIDTH, 803*DEF_Adaptation_Font*0.5+[self getLableHeight:[dic objectForKey:@"boardtext"]]+20*DEF_Adaptation_Font*0.5+num_y);
    }else if([[dic objectForKey:@"boardimage"] count]==1){
        return  CGSizeMake(DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5+[self getLableHeight:[dic objectForKey:@"boardtext"]]+20*DEF_Adaptation_Font*0.5);
    }else if([[dic objectForKey:@"boardimage"] count]>1){
        return  CGSizeMake(DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5+[self getLableHeight:[dic objectForKey:@"boardtext"]]+20*DEF_Adaptation_Font*0.5);
    }
    return  CGSizeMake(DEF_SCREEN_WIDTH, 618*DEF_Adaptation_Font*0.5);

}


-(void)createCellView:(NSIndexPath *)indexPath andCell:(UICollectionViewCell*)cell{
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[_arrayData  objectAtIndex:indexPath.row]];
    
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
    
    
    float num_lasy_y = 0;
    
    
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
        
        UIButton *commentBtn = [LooperToolClass createBtnImageNameReal:@"btn_comment.png" andRect:CGPointMake(500*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+629*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5) andTag:[[dic objectForKey:@"boardid"] intValue] andSelectImage:@"btn_comment.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5) andTarget:self];
        [cell.contentView addSubview:commentBtn];
        
      [commentBtn addTarget:obj action:@selector(commentOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
        num_lasy_y  = (boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+629*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5+58*DEF_Adaptation_Font*0.5;
        
        
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
        
        UIButton *commentBtn = [LooperToolClass createBtnImageNameReal:@"btn_comment.png" andRect:CGPointMake(500*DEF_Adaptation_Font*0.5,(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+330*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5) andTag:[[dic objectForKey:@"boardid"] intValue] andSelectImage:@"btn_comment.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5) andTarget:self];
        
         [commentBtn addTarget:obj action:@selector(commentOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:commentBtn];
        
        num_lasy_y  =(boardText.frame.origin.y+boardText.frame.size.height)+37*DEF_Adaptation_Font*0.5+330*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5+58*DEF_Adaptation_Font*0.5;
        
    }
    
    for (int i=0;i<[[dic objectForKey:@"message"] count];i++){
        NSDictionary *indexDic = [[dic objectForKey:@"message"] objectAtIndex:i];
        float num_y =[self getLableHeight:[indexDic objectForKey:@"messagecontent"]];
        
        UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(119*DEF_Adaptation_Font*0.5,num_lasy_y,501*DEF_Adaptation_Font*0.5,num_y+50*DEF_Adaptation_Font*0.5)];
         [cell.contentView addSubview:view];
        [view setBackgroundColor:[UIColor colorWithRed:38/255.0 green:35/255.0 blue:68/255.0 alpha:1.0 ]];
        
        num_lasy_y=num_lasy_y+num_y+50*DEF_Adaptation_Font*0.5+3*DEF_Adaptation_Font*0.5;
        
        
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(12*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5)];
        [headView sd_setImageWithURL:[[NSURL alloc] initWithString:[indexDic objectForKey:@"userimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        headView.layer.cornerRadius = 52*DEF_Adaptation_Font_x*0.5/2;
        headView.layer.masksToBounds = YES;
        [view addSubview:headView];
        
        UILabel *nickName = [LooperToolClass createLableView:CGPointMake(75*DEF_Adaptation_Font*0.5,12*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(216*DEF_Adaptation_Font_x*0.5, 19*DEF_Adaptation_Font_x*0.5) andText:[indexDic objectForKey:@"username"] andFontSize:10 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:0.7] andType:NSTextAlignmentLeft];

        [view addSubview:nickName];
        
        UILabel *commentText = [LooperToolClass createLableView:CGPointMake(75*DEF_Adaptation_Font*0.5,48*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(418*DEF_Adaptation_Font_x*0.5, num_y*DEF_Adaptation_Font_x*0.5) andText:[indexDic objectForKey:@"messagecontent"] andFontSize:10 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
         commentText.numberOfLines=0;
        [commentText sizeToFit];

        [view addSubview:commentText];
       
    }
}


-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.userInteractionEnabled = YES;
    bgView.tag=num;
    
    [bgView setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:59/255.0 alpha:1.0]];

    
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(32*DEF_Adaptation_Font*0.5,8*DEF_Adaptation_Font*0.5,  576*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5)];
    [textField setPlaceholder:string];
    textField.layer.borderColor= [UIColor grayColor].CGColor;
    
    textField.layer.borderWidth= 1.0f;
    
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor whiteColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.layer.cornerRadius = 5 *DEF_Adaptation_Font_x*0.5;
    textField.layer.masksToBounds = YES;
    
    
    
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    [bgView setHidden:true];
    
    return textField;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    [bgView setHidden:false];

    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    bgView.frame = CGRectMake(bgView.frame.origin.x, DEF_SCREEN_HEIGHT -frame.size.height-bgView.frame.size.height, bgView.frame.size.width, bgView.frame.size.height);
    
}


-(void)keyboardWillHide:(NSNotification *)notification
{
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [bgView setHidden:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.text.length!=0){
    
        [_obj sendImageBoardMessage:[NSString stringWithFormat:@"%d",selectTextTag] andMessageText:textFieldComment.text];

        textFieldComment.text = @"";
        [self endEditing:true];
   
    }else{
        [[DataHander sharedDataHander] showViewWithStr:@"不能发表空的言论" andTime:2 andPos:CGPointZero];
        
         [self endEditing:true];
        
    }
    return YES;
}

-(IBAction)commentOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    NSLog(@"%d",button.tag);
    
    selectTextTag = button.tag;

    [textFieldComment becomeFirstResponder];

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
    
    for (int i=0;i<[_arrayData count];i++){
        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[_arrayData objectAtIndex:i]];
        if([[dic objectForKey:@"boardid"] intValue]==button.tag){
 
            [_obj playNetWorkVideo:[dic objectForKey:@"boardvideo"]];
            break;
        }
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

-(void)initView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self createBackGround];
    
    [self createColloectionView];
    [self createHudView];
    
}


@end
