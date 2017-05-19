//
//  addMusicView.m
//  Looper
//
//  Created by lujiawei on 28/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "addMusicView.h"
#import "addMusicViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "NSArray+index.h"
#import "UIImageView+WebCache.h"

@implementation addMusicView{

    UIImageView *bk;
    UILabel *title;
    UIImageView *addMusicUp;
    
    UIButton *addMusic;
    UIButton *addFollow;
    UIButton *addLibrary;
    UIButton *addMusicBtn;
    UITableView *musicTableView;
    UIButton *commitBtn;
    NSMutableArray *selectSongArray;
    
    
    NSArray *FavoriteArray;
    int selectNum;
    UIImageView *titleBk;
    UIButton *bkBtn;
    
}
@synthesize obj = _obj;
@synthesize FavoriteArray = _FavoriteArray;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andFavoriteArray:(NSArray*)FavoriteData;
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (addMusicViewModel*)idObject;
        self.FavoriteArray =  FavoriteData;
        [self initView];
        
        
    }
    return self;
    
}

-(void)setBtnUnSelect{
    [addMusic setSelected:false];
    [addFollow setSelected:false];
    [addLibrary setSelected:false];

}

-(IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==200){
        [_obj backView];
    }else if(button.tag==2001){
        selectNum = 3;
        [self setBtnUnSelect];
         [addMusicBtn setHidden:false];
        [addMusicUp setHidden:false];
        [button setSelected:true];
         [musicTableView setHidden:true];
         [commitBtn setHidden:true];
    }else if(button.tag==2002){
        selectNum = 2;
        [self setBtnUnSelect];
        [addMusicBtn setHidden:true];
         [addMusicUp setHidden:true];
        [button setSelected:true];
        [musicTableView setHidden:false];
        [musicTableView reloadData];
        [commitBtn setHidden:false];
    }else if(button.tag==2003){
        selectNum = 1;
        [self setBtnUnSelect];
        [addMusicBtn setHidden:true];
         [button setSelected:true];
         [addMusicUp setHidden:true];
        [musicTableView setHidden:false];
        [musicTableView reloadData];
        [commitBtn setHidden:true];
    }else if(button.tag==900){
        [self createUploadPic];
    
    
    }else if(button.tag==1999){
        
        [_obj addMusics:selectSongArray];
    }

}


-(void)btnOnClick{
    [bkBtn removeFromSuperview];
    [titleBk removeFromSuperview];


}


-(void)createUploadPic{

    bkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bkBtn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bkBtn];
    
    titleBk=[LooperToolClass createImageView:@"upload_pic.png" andRect:CGPointMake(124, 348) andTag:100 andSize:CGSizeMake(626, 1028) andIsRadius:false];
    [self addSubview:titleBk];
}


-(void)createHudView{
    [self setBackgroundColor:[UIColor colorWithRed:32/255.0 green:41/255.0 blue:64/255.0 alpha:1.0]];
    
    selectNum = 1;
    
    addMusicUp=[LooperToolClass createImageView:@"bk_addMusic.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 1045*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:addMusicUp];
    
     [addMusicUp setHidden:true];
    
    title = [LooperToolClass createLableView:CGPointMake(277*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"歌曲" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];
    
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    

    addMusicBtn =[LooperToolClass createBtnImageName:@"addMusic_up.png" andRect:CGPointMake(172, 260) andTag:900 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: addMusicBtn];
    [addMusicBtn setHidden:true];
    
    bk=[LooperToolClass createImageView:@"bk_backGround.png" andRect:CGPointMake(0, 1013) andTag:100 andSize:CGSizeMake(626, 1028) andIsRadius:false];
    [self addSubview:bk];

    addMusic =[LooperToolClass createBtnImageName:@"upSelectMusic.png" andRect:CGPointMake(443, 1057) andTag:2001 andSelectImage:@"SelectedMusic.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: addMusic];
    
    addFollow =[LooperToolClass createBtnImageName:@"follow_un.png" andRect:CGPointMake(230, 1057) andTag:2002 andSelectImage:@"follow_ed.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: addFollow];
    
    addLibrary =[LooperToolClass createBtnImageName:@"un_musiclibrary.png" andRect:CGPointMake(15,1057) andTag:2003 andSelectImage:@"select_musiclibrary.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: addLibrary];
    
    
    commitBtn =[LooperToolClass createBtnImageName:@"btn_commit_loop.png" andRect:CGPointMake(532, 57) andTag:1999 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: commitBtn];
    [commitBtn setHidden:true];
    

}

-(void)createTableView{
    musicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,113*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, 940*0.5*DEF_Adaptation_Font) style:UITableViewStylePlain];
    musicTableView.dataSource = self;
    musicTableView.delegate = self;
    [self addSubview:musicTableView];
    [musicTableView setBackgroundColor:[UIColor clearColor]];
    musicTableView.separatorStyle = NO;
    
    musicTableView.sectionIndexColor = [[UIColor alloc] initWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    musicTableView.sectionIndexBackgroundColor =[UIColor clearColor];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(selectNum==1){
        if ([self.dataArr[section][@"data"] count] > 0) {
            return 20*DEF_Adaptation_Font*0.5;
        }else {
            return 0;
        }
    }else  if(selectNum==2){
        return 0;
    }
     return 0;
}



- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    if(selectNum==1){
        if ([self.dataArr[section][@"data"] count] > 0) {
            
            UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 20*DEF_Adaptation_Font*0.5)];
            [sectionView setBackgroundColor:[UIColor clearColor]];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5, 200.0f, 20*DEF_Adaptation_Font*0.5)];
            [labelTitle setTextColor:[UIColor whiteColor]];
            [labelTitle setBackgroundColor:[UIColor clearColor]];
            labelTitle.textAlignment = NSTextAlignmentLeft;
            labelTitle.text = self.dataArr[section][@"indexTitle"];
            [sectionView addSubview:labelTitle];
            return sectionView;
        }

    }else  if(selectNum==2){
        return nil;
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return  90*DEF_Adaptation_Font*0.5;
}



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArr) {
        [temp addObject:dict[@"indexTitle"]];
    }
    
    return index;
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
    
     if(selectNum==1){
         [_obj getMusicByArtistName:self.dataArr[indexPath.section][@"data"][indexPath.row][@"artist"]];
     }else  if(selectNum==2){
       //todo
         UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
         NSDictionary *dic = [_FavoriteArray objectAtIndex:indexPath.row];
         UIButton *btn = (UIButton*)[cell viewWithTag:109];
         if([btn isSelected]==true){
             [btn setSelected:false];
             [self removeSongArray:[dic objectForKey:@"id"]];
         }else{
             [btn setSelected:true];
             [self addSongArray:[dic objectForKey:@"id"]];
         }
     }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(selectNum==1){
         return self.dataArr.count;
    }else  if(selectNum==2){
         return [_FavoriteArray count];
    }
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(selectNum==1){
        return  [self.dataArr[section][@"data"] count];
    }else  if(selectNum==2){
        return [_FavoriteArray count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
     if(selectNum==1){

    UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(23*0.5*DEF_Adaptation_Font,19*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font)];
    [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString:self.dataArr[indexPath.section][@"data"][indexPath.row][@"artistheaderimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    loopHead.layer.cornerRadius =54*DEF_Adaptation_Font*0.5/2;
    loopHead.layer.masksToBounds = YES;
    [cell.contentView addSubview:loopHead];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font, 400*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
    label.text =self.dataArr[indexPath.section][@"data"][indexPath.row][@"artist"];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:looperFont size:12]];
    [cell.contentView addSubview:label];

    }else if(selectNum==2){
        NSDictionary *dic = [_FavoriteArray objectAtIndex:indexPath.row];
        
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,21*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =66*DEF_Adaptation_Font*0.5/2;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        
        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(128*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
        userName.text =[dic objectForKey:@"filename"];
        [userName setTextColor:[UIColor whiteColor]];
        [userName setFont:[UIFont fontWithName:looperFont size:12]];
        [cell.contentView addSubview:userName];
        
        
        UIButton* selected = [LooperToolClass createBtnImageName:@"music_unSelect.png" andRect:CGPointMake(565, 22) andTag:109 andSelectImage:@"music_selected.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
        [cell.contentView addSubview:selected];
         
     }
    
    return cell;
}

//索引的代理方法
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArr) {
        [temp addObject:dict[@"indexTitle"]];
    }
    return temp.copy;
}



-(void)initView{
    selectSongArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self createHudView];
    self.dataArr = [NSArray suoyin:[_obj artistData]];
    [self createTableView];
}


@end
