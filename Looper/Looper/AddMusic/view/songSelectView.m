//
//  songSelectView.m
//  Looper
//
//  Created by lujiawei on 01/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "songSelectView.h"
#import "addMusicViewModel.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"



@implementation songSelectView
{
    UITableView *songTableView;
    NSString *titleName;
    
    NSMutableArray *selectSongArray;

}
@synthesize obj = _obj;
@synthesize titleName = _titleName;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andTitle:(NSString*)titleName;
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (addMusicViewModel*)idObject;
        self.titleName = titleName;
        [self initView];
        
        
    }
    return self;
    
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==200){
        
        [_obj removeSongSelectV];
    }else  if(button.tag==900){
    
        [_obj addMusics:selectSongArray];
    }else  if(button.tag<200){

//        NSDictionary *dic = [[_obj musicList] objectAtIndex:button.tag];
//        if([button isSelected]==true){
//            [button setSelected:false];
//            [self removeSongArray:[dic objectForKey:@"id"]];
//        }else{
//            [button setSelected:true];
//            [self addSongArray:[dic objectForKey:@"id"]];
//        }
        
    }
}


-(void)initView{

    
    selectSongArray = [[NSMutableArray alloc]initWithCapacity:50];
    
    [self setBackgroundColor:[UIColor colorWithRed:32/255.0 green:41/255.0 blue:64/255.0 alpha:1.0]];
    
    [self createTableView];
    
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
    UILabel *title = [LooperToolClass createLableView:CGPointMake(180*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(265*DEF_Adaptation_Font_x*0.5, 40*DEF_Adaptation_Font_x*0.5) andText:_titleName andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];

    UIButton *commitBtn =[LooperToolClass createBtnImageName:@"btn_commit_loop.png" andRect:CGPointMake(532, 57) andTag:900 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: commitBtn];
}

 -(void)createTableView{
    songTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,115*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, 1021*0.5*DEF_Adaptation_Font) style:UITableViewStylePlain];
    songTableView.dataSource = self;
    songTableView.delegate = self;
    songTableView.separatorStyle = NO;
     songTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    songTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:songTableView];
    [songTableView setBackgroundColor:[UIColor clearColor]];
}

-(void)addSongArray:(NSString*)songId{
    [selectSongArray addObject:songId];
}

-(void)removeSongArray:(NSString*)songId{
    
    for (int i=0;i<[selectSongArray count];i++){
        if([songId isEqualToString:[selectSongArray objectAtIndex:i]]==true){
            [selectSongArray removeObjectAtIndex:i];
        }
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = [[_obj musicList] objectAtIndex:indexPath.row];
    UIButton *btn = (UIButton*)[cell viewWithTag:109];
    if([btn isSelected]==true){
         [btn setSelected:false];
        [self removeSongArray:[dic objectForKey:@"id"]];
    }else{
        [btn setSelected:true];
        [self addSongArray:[dic objectForKey:@"id"]];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  118*DEF_Adaptation_Font*0.5;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_obj musicList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
    NSDictionary *dic = [[_obj musicList] objectAtIndex:indexPath.row];
    
    UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,21*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font)];
    [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    loopHead.layer.cornerRadius =66*DEF_Adaptation_Font*0.5/2;
    loopHead.layer.masksToBounds = YES;
    [cell.contentView addSubview:loopHead];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(128*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font, 400*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
    userName.text =[dic objectForKey:@"filename"];
    [userName setTextColor:[UIColor whiteColor]];
    [userName setFont:[UIFont fontWithName:looperFont size:17]];
    [cell.contentView addSubview:userName];

    
    UIButton* selected = [LooperToolClass createBtnImageName:@"music_unSelect.png" andRect:CGPointMake(545, 22) andTag:109 andSelectImage:@"music_selected.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [cell.contentView addSubview:selected];
    [selected removeTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}






@end
