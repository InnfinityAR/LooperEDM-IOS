//
//  addMusicViewModel.m
//  Looper
//
//  Created by lujiawei on 28/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "addMusicViewModel.h"
#import "addMusicController.h"
#import "addMusicView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "AFNetworkTool.h"
#import "songSelectView.h"
#import "DataHander.h"
#import "LocalDataMangaer.h"


@implementation addMusicViewModel{


    addMusicView *addMusicV;
    songSelectView *songSelectV;
    
    NSArray* FavoriteData;
    

}
@synthesize obj = _obj;
@synthesize artistData = _artistData;
@synthesize musicList = _musicList;
@synthesize looperId = _looperId;

-(id)initWithController:(id)controller andLooperId:(NSString*)looperID{

    if(self=[super init]){
        self.obj = (addMusicController*)controller;
        self.looperId =looperID;
        [self initView];
    }
    return  self;
}


-(void)removeSongSelectV{

    [songSelectV removeFromSuperview];

}



-(void)getMusicByArtistName:(NSString*)ArtistName{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:ArtistName forKey:@"artist"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMusicByArtistName" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            
            _musicList = [[NSArray alloc] initWithArray:responseObject[@"data"]];
            
            songSelectV = [[songSelectView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andTitle:ArtistName];
            [[_obj view] addSubview:songSelectV];

            
            
        }
    }fail:^{
        
    }];
}



-(void)addMusics:(NSArray*)songArray{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:songArray forKey:@"fileIds"];
    [dic setObject:_looperId forKey:@"loopId"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addMusics" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            [[DataHander sharedDataHander] showViewWithStr:@"添加音乐成功" andTime:1 andPos:CGPointZero];
            
            [self backView];
        }
    }fail:^{
        
    }];


}



-(void)requestGetArtistData{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getArtist" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            _artistData = [[NSArray alloc] initWithArray:responseObject[@"data"]];
            
            [self requestgetMyFavorite];
        }
        
        
    }fail:^{
        
    }];
}


-(void)requestgetMyFavorite{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyFavorite" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            
            FavoriteData = [[NSArray alloc] initWithArray:responseObject[@"data"]];
            
            
            addMusicV = [[addMusicView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andFavoriteArray:FavoriteData];
            [[_obj view] addSubview:addMusicV];
            
            
            
            
        }
    }fail:^{
        
    }];
    
}




-(void)requestData{

    
    


}

-(void)backView{
      [[_obj navigationController] popViewControllerAnimated:NO];
}

-(void)initView{
    
    
    [self requestGetArtistData];
    
    

    

}



@end
