//
//  MusicListManage.m
//  Looper
//
//  Created by lujiawei on 4/15/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MusicListManage.h"
#import "looperViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"

@implementation MusicListManage{


    NSMutableArray *MusicListArray;
    NSDictionary *nowPlayMusic;
    NSMutableArray *selectSongArray;
    UIButton *addMusic;
    UIButton *removeMusic;
    UITableView *MusicTableView;
    
    NSMutableArray *cellArray;
    int selectIndex;
    
    bool isOwner;

}
@synthesize obj = _obj;
@synthesize looperData =_looperData;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andLooperData:(NSDictionary*)looperData;
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        self.looperData = looperData;
        
        [self initView];
    }
    return self;
}

-(void)updataLoad:(NSArray*)musicData{
    
    MusicListArray = musicData;
    [selectSongArray removeAllObjects];
    
    [MusicTableView reloadData];
}



-(void)createTableView{
    selectIndex = 0;
    cellArray = [[NSMutableArray alloc] initWithCapacity:50];

    if(isOwner==true){
        MusicTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 98*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 949*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
    }else{
        MusicTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 98*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 1039*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
    }
    MusicTableView.dataSource = self;
    MusicTableView.delegate = self;
    MusicTableView.separatorStyle = NO;
    [MusicTableView setBackgroundColor:[UIColor clearColor]];
    
    if(isOwner==true){
         [MusicTableView setEditing:true animated:YES];
    }
    [self addSubview:MusicTableView];
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)setAllCellDefault{
    
    for (int i=0;i<[cellArray count];i++){
        MusicViewCell *cell =[cellArray objectAtIndex:i];
        
        [cell.musicName setTextColor:[UIColor colorWithRed:189/255.0 green:188/255.0 blue:190/255.0 alpha:0.7] ];
        [cell.musicPlayer setTextColor:[UIColor colorWithRed:124/255.0 green:123/255.0 blue:125/255.0 alpha:0.66]];
        [cell setBackgroundColor:[UIColor clearColor]];
    
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(isOwner==false){
        
        NSLog(@"%ld",(long)indexPath.row);
        
        [_obj playMusicAtIndex:indexPath.row];
        [self setAllCellDefault];
        
        MusicViewCell* cell  = [tableView cellForRowAtIndexPath:indexPath];
        
        [cell.musicName setTextColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
        [cell.musicPlayer setTextColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
        
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.08]];
    }
}

-(void)addMusicArray:(NSString*)musicId{
    
     [selectSongArray addObject:musicId];
    
    if(isOwner==false){
        [_obj addToFavorite:musicId andisLike:1];
    }else{
    
        [removeMusic setHidden:false];
         [addMusic setHidden:true];
    }
}

-(void)removeMusicArray:(NSString*)musicId{
    for (int i=0;i<[selectSongArray count];i++){
        if([musicId isEqualToString:[selectSongArray objectAtIndex:i]]==true){
            [selectSongArray removeObjectAtIndex:i];
        }
    }
    if(isOwner==false){
        [_obj addToFavorite:musicId andisLike:0];
    }else{
        if([selectSongArray count]==0){
            [removeMusic setHidden:true];
            [addMusic setHidden:false];
        }
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if(indexPath.section==0){
//        
//        return  90*DEF_Adaptation_Font*0.5;
//    }else{
//    
        return  90*DEF_Adaptation_Font*0.5;
    //}
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if(section==0){
//        if([MusicListArray count]==0){
//            return 0;
//        }else{
//            return 1;
//        }
//    }else{
        return [MusicListArray count];
    
   // }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40*DEF_Adaptation_Font*0.5;
//}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH, 40*DEF_Adaptation_Font*0.5)];
//    [v setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:43/255.0 alpha:1.0]];
//    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*DEF_Adaptation_Font*0.5, 10.0*DEF_Adaptation_Font*0.5, 200.0f, 20*DEF_Adaptation_Font*0.5)];
//    [labelTitle setTextColor:[UIColor whiteColor]];
//    [labelTitle setBackgroundColor:[UIColor clearColor]];
//    labelTitle.textAlignment = NSTextAlignmentLeft;
//    [labelTitle setFont:[UIFont fontWithName:looperFont size:14]];
//    if(section==0){
//        labelTitle.text = @"当前播放";
//    }else{
//        labelTitle.text = @"待播放";
//    }
//    
//    [v addSubview:labelTitle];
//    return v;
//}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
    
    if(destinationIndexPath.section==0){
        [tableView reloadData];
    }
    if(sourceIndexPath.section==0){
        [tableView reloadData];
    }
}

-(void)selectCellIndex:(int)selIndex{
    [self setAllCellDefault];
    selectIndex = selIndex;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    
     MusicViewCell* cell = [[MusicViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    
      [cell init_cell_subViewsWithCell:selectSongArray refreshCell:[MusicListArray objectAtIndex:indexPath.row] isOwner:isOwner obj:self isFrist:false];
    
    
    if(indexPath.row ==selectIndex){

        [cell.musicName setTextColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
        [cell.musicPlayer setTextColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
    
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.08]];
    }
    
    
//    if(indexPath.section==1){
//    
//        [cell init_cell_subViewsWithCell:selectSongArray refreshCell:[MusicListArray objectAtIndex:indexPath.row] isOwner:isOwner obj:self isFrist:false];
//    }else if(indexPath.section==0){
//    
//        [cell init_cell_subViewsWithCell:selectSongArray refreshCell:[MusicListArray objectAtIndex:indexPath.row] isOwner:isOwner obj:self isFrist:true];
//    
//    }
//
    
    
    [cellArray addObject:cell];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag==100){
        [_obj removeMusicListView];

    }else if(button.tag==1000){
        [_obj jumpToAddMusicView];
    }else if(button.tag==1001){
        [_obj updataArray:selectSongArray];
    }
}



-(void)createHudView{
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:43/255.0 alpha:1.0]];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    if([[[_looperData objectForKey:@"Owner"] objectForKey:@"userid"] isEqualToString:[LocalDataMangaer sharedManager].uid]==true){
        isOwner=true;
    }else{
        isOwner =false;
    }
    
    MusicListArray = [[NSMutableArray alloc] initWithArray:[_looperData objectForKey:@"Music"]];
    
    if(isOwner==true){
        UIImageView *line=[LooperToolClass createImageView:@"music_line.png" andRect:CGPointMake(0, 1050) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:line];
        addMusic = [LooperToolClass createBtnImageNameReal:@"add_music.png" andRect:CGPointMake(194*DEF_Adaptation_Font*0.5,1063*DEF_Adaptation_Font*0.5) andTag:1000 andSelectImage:@"add_music.png" andClickImage:@"add_music.png" andTextStr:nil andSize:CGSizeMake(300*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:addMusic];
        
        removeMusic = [LooperToolClass createBtnImageNameReal:@"removeMusic.png" andRect:CGPointMake(295*DEF_Adaptation_Font*0.5,1065*DEF_Adaptation_Font*0.5) andTag:1001 andSelectImage:@"removeMusic.png" andClickImage:@"removeMusic.png" andTextStr:nil andSize:CGSizeMake(68*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:removeMusic];
        
        [removeMusic setHidden:true];
    }
}


-(void)initView{
    
    selectSongArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self createHudView];
    
    [self createTableView];
    

}

@end
