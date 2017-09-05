//
//  FramilyModel.m
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FramilyModel.h"

@implementation FramilyModel

@synthesize sourceDic = _sourceDic;
@synthesize InviteArray = _InviteArray;
@synthesize RankingArray = _RankingArray;
@synthesize recommendArray = _recommendArray;


-(instancetype)init{

    if(self = [super init]){
    
        return self;
    }
    return nil;
}



-(void)initWithData:(NSDictionary*)data{
    _sourceDic = [[NSMutableDictionary alloc] initWithDictionary:data];
}

-(void)updataWithData:(NSDictionary*)data{
    [_sourceDic removeAllObjects];
    _sourceDic = [[NSMutableDictionary alloc] initWithDictionary:data];
}

-(void)updateRankData:(NSArray*)array{
    [_RankingArray removeAllObjects];
    _RankingArray = [[NSMutableArray alloc] initWithArray:array];
}

-(void)updateInviteData:(NSArray*)array{
    [_InviteArray removeAllObjects];
    _InviteArray = [[NSMutableArray alloc] initWithArray:array];
}

-(void)updateRecommendData:(NSArray*)array{
     [_recommendArray removeAllObjects];
      _recommendArray = [[NSMutableArray alloc] initWithArray:array];
}




@end
