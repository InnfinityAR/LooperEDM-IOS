//
//  MusicViewCell.m
//  Looper
//
//  Created by lujiawei on 4/16/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MusicViewCell.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "MusicListManage.h"


@implementation MusicViewCell{

    UIImageView *headImageV;
    UIButton *selected;
    UIButton *followed;
    UILabel *musicName;
    UILabel *musicPlayer;
    
    id _obj;
    NSDictionary *localMusicDic;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==109){
        if([selected isSelected]==true){
            [selected setSelected:false];
            [(MusicListManage*)_obj removeMusicArray:[localMusicDic objectForKey:@"fileid"]];
            
        }else{
            [selected setSelected:true];
             [(MusicListManage*)_obj addMusicArray:[localMusicDic objectForKey:@"fileid"]];
        }
    }else if(button.tag==102){
        if([followed isSelected]==true){
            [followed setSelected:false];
             [(MusicListManage*)_obj removeMusicArray:[localMusicDic objectForKey:@"fileid"]];
        }else{
            [followed setSelected:true];
            [(MusicListManage*)_obj addMusicArray:[localMusicDic objectForKey:@"fileid"]];
        }
    }
    
}


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         selected = [LooperToolClass createBtnImageName:@"music_unSelect.png" andRect:CGPointMake(51, 26) andTag:109 andSelectImage:@"music_selected.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
        [self addSubview:selected];
        
        followed =[LooperToolClass createBtnImageName:@"btn_unfollowMusic.png" andRect:CGPointMake(561, 0) andTag:102 andSelectImage:@"btn_followMusic.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
        [self addSubview:followed];
        
        headImageV = [[UIImageView alloc] init];
        [self addSubview:headImageV];
        
        musicName = [LooperToolClass createLableView:CGPointMake(149*DEF_Adaptation_Font_x*0.5, 13*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(394*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font_x*0.5) andText:@"Too Hot For Pants" andFontSize:10 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [self addSubview:musicName];

        musicPlayer = [LooperToolClass createLableView:CGPointMake(149*DEF_Adaptation_Font_x*0.5, 47*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(394*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5) andText:@"MDK" andFontSize:10 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.66] andType:NSTextAlignmentLeft];
        [self addSubview:musicPlayer];
    
    }
    return self;
}
-(void)init_cell_subViewsWithCell:(NSArray*)selectArray
                      refreshCell:(NSDictionary*)dic
                          isOwner:(BOOL)isOwner
                              obj:(id)obj
                              isFrist:(BOOL)isFrist
{
    
    _obj = obj;
    localMusicDic = dic;
    
    if(isOwner==true){
        [headImageV setHidden:true];
        [followed setHidden:true];
        [selected setSelected:false];
        for (int i=0;i<[selectArray count];i++){
            if([[dic objectForKey:@"fileid"] isEqualToString:[selectArray objectAtIndex:i]]==true){
                [selected setSelected:true];
            }
        }
        
        if(isFrist==true){
            
              [selected setHidden:true];
        }
        
    }else{
        [selected setHidden:true];
        if(dic!=nil){
        
            
            if([[dic objectForKey:@"music_cover"] isEqualToString:@""]==true){
                headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(42*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5)];
                headImageV.layer.cornerRadius =55*DEF_Adaptation_Font*0.5*0.5;
                headImageV.image=[UIImage imageNamed:@"default_music.png"];
                headImageV.layer.masksToBounds = YES;

                [self addSubview:headImageV];
                
            }else{
                
                headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(42*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5)];
                headImageV.layer.cornerRadius =55*DEF_Adaptation_Font*0.5*0.5;
                headImageV.layer.masksToBounds = YES;
                
                [headImageV sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                [self addSubview:headImageV];
                

            
            
            }
            
        [followed setSelected:false];
            
            for (int i=0;i<[selectArray count];i++){
                if([[dic objectForKey:@"fileid"] isEqualToString:[selectArray objectAtIndex:i]]==true){
                    [followed setSelected:true];
                }
            }
        }else{
            [headImageV setHidden:true];
        }
    }
    
    
    
    if(dic!=nil){
        [musicName setText:[dic objectForKey:@"filename"]];
        [musicPlayer setText:[dic objectForKey:@"artist"]];
    }
}
@end
