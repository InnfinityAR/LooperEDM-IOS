//
//  MusicPlayView.m
//  Looper
//
//  Created by lujiawei on 4/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MusicPlayView.h"
#import "looperViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "LocalDataMangaer.h"


@implementation MusicPlayView{

    NSArray *musicArray;
    NSDictionary *looperData;
    UIButton *FollowBtn;
    UIButton *nextBtn;
    UIButton *previousBtn;
    
    UILabel *musicName;
    UILabel *musicPlayer;
    UIImageView *musicHead;
    
    int indexNum;
    UIButton *parseBtn;
    
}

@synthesize obj = _obj;
@synthesize musicArray = _musicArray;
@synthesize looperData = _looperData;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andlooperData:(NSDictionary *)looperData isPlay:(bool)isPlay
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        self.musicArray=[looperData objectForKey:@"Music"];
        self.looperData=looperData;
        
        [self initView];
        
        
    }
    return self;
    
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==200){
        [_obj removeMusicView];
    }else if(button.tag==2000){
         NSDictionary *dic = [_musicArray objectAtIndex:indexNum];
        if([button isSelected]==true){
            
            [button setSelected:false];
            [_obj addToFavorite:[dic objectForKey:@"fileid"] andisLike:0];
        }else{
            [button setSelected:true];
            [_obj addToFavorite:[dic objectForKey:@"fileid"] andisLike:1];
        }
    }else if(button.tag==204){
        if([parseBtn isSelected]==true){
            [parseBtn setSelected:false];
        }else{
            [parseBtn setSelected:true];
        }
        [_obj parseMusic];
    }else if(button.tag==205){
        [_obj frontMusic];
    }else if(button.tag==206){
        [_obj backMusic];
    }else if(button.tag==2019){
        [_obj addMusicListView];
    }
}





-(void)updataWithMusic:(NSDictionary*)musicData and:(int)indexpath{
    
    indexNum  = indexpath;
    
    
    [musicName setText:[musicData objectForKey:@"filename"]];
    
    [musicPlayer setText:[musicData objectForKey:@"artist"]];

    
    [musicHead removeFromSuperview];

    musicHead = [[UIImageView alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font,173*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font)];
    [musicHead sd_setImageWithURL:[[NSURL alloc] initWithString: [musicData objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    musicHead.layer.cornerRadius =378*DEF_Adaptation_Font*0.5/2;
    musicHead.layer.masksToBounds = YES;
    [self addSubview:musicHead];
    
    if([[musicData objectForKey:@"music_cover"] isEqualToString:@""]==true){
        [musicHead removeFromSuperview];
        musicHead = [[UIImageView alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font,173*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font)];
        musicHead.image=[UIImage imageNamed:@"default_music.png"];
        musicHead.layer.cornerRadius =378*DEF_Adaptation_Font*0.5/2;
        musicHead.layer.masksToBounds = YES;
        [self addSubview:musicHead];
        
    }
    
    if( [[musicData objectForKey:@"islike"] intValue]==1){
        [FollowBtn setSelected:true];
    }else{
         [FollowBtn setSelected:false];
    }
}

-(void)initView{
    
    [self setBackgroundColor:[UIColor colorWithRed:17/255.0 green:18/255.0 blue:34/255.0 alpha:1.0]];
    
    //[self createHudView:0];

}


-(void)createHudView:(int)index andisPlay:(BOOL)isPlay{
    
    indexNum = index;
    
    if([_musicArray count]!=0){
        
        NSDictionary *dic = [_musicArray objectAtIndex:index];
        
        if(dic!=nil){
            
            UIButton *backBtn =[LooperToolClass createBtnImageName:@"backView.png" andRect:CGPointMake(15, 34) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: backBtn];
            
            UIButton *listBtn =[LooperToolClass createBtnImageName:@"list.png" andRect:CGPointMake(546, 34) andTag:2019 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: listBtn];
            
            FollowBtn =[LooperToolClass createBtnImageName:@"unfollow.png" andRect:CGPointMake(283, 834) andTag:2000 andSelectImage:@"follow.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: FollowBtn];
            
            if( [[dic objectForKey:@"islike"] intValue]==1){
                [FollowBtn setSelected:true];
            }
            
            musicName= [LooperToolClass createLableView:CGPointMake(74*DEF_Adaptation_Font*0.5,646*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(496*DEF_Adaptation_Font*0.5,82*DEF_Adaptation_Font*0.5) andText:[dic objectForKey:@"filename"]  andFontSize:18 andColor:[UIColor colorWithRed:221/255.0 green:225/255.0 blue:238/255.0 alpha:0.70] andType:NSTextAlignmentCenter];
            [self addSubview:musicName];
            
            musicPlayer= [LooperToolClass createLableView:CGPointMake(72*DEF_Adaptation_Font*0.5,728*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(496*DEF_Adaptation_Font*0.5,52*DEF_Adaptation_Font*0.5) andText:[dic objectForKey:@"artist"] andFontSize:13 andColor:[UIColor colorWithRed:221/255.0 green:225/255.0 blue:238/255.0 alpha:0.70] andType:NSTextAlignmentCenter];
            [self addSubview:musicPlayer];
            
            parseBtn =[LooperToolClass createBtnImageName:@"parse.png" andRect:CGPointMake(277, 962) andTag:204 andSelectImage:@"play.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: parseBtn];
            
            if(isPlay==true){
                
                [parseBtn setSelected:false];
            }else{
                [parseBtn setSelected:true];
            }
            
            previousBtn =[LooperToolClass createBtnImageName:@"previous.png" andRect:CGPointMake(124, 967) andTag:205 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: previousBtn];
            
            nextBtn =[LooperToolClass createBtnImageName:@"Next.png" andRect:CGPointMake(454, 966) andTag:206 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
            [self addSubview: nextBtn];
            
        }
        
        musicHead = [[UIImageView alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font,173*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font)];
        [musicHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        musicHead.layer.cornerRadius =378*DEF_Adaptation_Font*0.5/2;
        musicHead.layer.masksToBounds = YES;
        [self addSubview:musicHead];
        
        if([[dic objectForKey:@"music_cover"] isEqualToString:@""]==true){
            [musicHead removeFromSuperview];
            musicHead = [[UIImageView alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font,173*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font, 378*0.5*DEF_Adaptation_Font)];
            musicHead.image=[UIImage imageNamed:@"default_music.png"];
            musicHead.layer.cornerRadius =378*DEF_Adaptation_Font*0.5/2;
            musicHead.layer.masksToBounds = YES;
            [self addSubview:musicHead];
            
        }
    }
    
    
    
    //[nextBtn setHidden:true];
    //[previousBtn setHidden:true];
    
    
    if([[LocalDataMangaer sharedManager].uid isEqualToString: [[_looperData objectForKey:@"Owner"] objectForKey:@"userid"]]==true){
        //FollowBtn setHidden:true];
    }else{
        
        
        
    }
    
}




@end
