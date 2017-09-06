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
@synthesize familyDetailData = _familyDetailData;
@synthesize familyMember = _familyMember;
@synthesize applyArray = _applyArray;
@synthesize messageArray =_messageArray;

-(instancetype)init{

    if(self = [super init]){
    
        return self;
    }
    return nil;
}

-(void)initWithData:(NSDictionary*)data{
    _sourceDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [self updataData];
}


-(void)updataData{
    if([_sourceDic objectForKey:@"recommendation"]!=nil){
        [self updateRecommendData:[_sourceDic objectForKey:@"recommendation"]];
    }
    if([_sourceDic objectForKey:@"data"]!=nil){
        [self updateRankData:[_sourceDic objectForKey:@"data"]];
    }
    if([_sourceDic objectForKey:@"invite"]!=nil){
        [self updateInviteData:[_sourceDic objectForKey:@"invite"]];
    }
    if([_sourceDic objectForKey:@"member"]!=nil){
        [self updateWithMemberData:[_sourceDic objectForKey:@"member"]];
    }
    if([_sourceDic objectForKey:@"raver"]!=nil){
        [self updataWithDetail:[_sourceDic objectForKey:@"raver"]];
    }
    if([_sourceDic objectForKey:@"apply"]!=nil){
        [self updataWithDetail:[_sourceDic objectForKey:@"apply"]];
    }
    if([_sourceDic objectForKey:@"message"]!=nil){
        [self updateWithMessageData:[_sourceDic objectForKey:@"message"]];
    }
    
}


-(void)updateWithMessageData:(NSArray*)messageData{
    [_messageArray removeAllObjects];
    _messageArray = [[NSMutableArray alloc] initWithArray:messageData];
}

-(void)updateWithApplyData:(NSArray*)applyData{
    [_applyArray removeAllObjects];
    _applyArray = [[NSMutableArray alloc] initWithArray:applyData];
}

-(void)updateWithMemberData:(NSArray*)memberArray{
    [_familyMember removeAllObjects];
    _familyMember = [[NSMutableArray alloc] initWithArray:memberArray];
}

-(void)updataWithDetail:(NSDictionary*)data{
    [_familyDetailData removeAllObjects];
    _familyDetailData = [[NSMutableDictionary alloc] initWithDictionary:data];
}

-(void)updataWithData:(NSDictionary*)data{
    [_sourceDic removeAllObjects];
    _sourceDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [self updataData];
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
