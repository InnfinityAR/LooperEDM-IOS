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
    if([_sourceDic objectForKey:@"member"]==nil||[_sourceDic objectForKey:@"member"]==[NSNull null]){
    }else{
        [self updateWithMemberData:[_sourceDic objectForKey:@"member"]];
    }
    if([_sourceDic objectForKey:@"raver"]!=nil){
        [self updataWithDetail:[_sourceDic objectForKey:@"raver"]];
    }
    if([_sourceDic objectForKey:@"apply"]!=nil){
        [self updateWithApplyData:[_sourceDic objectForKey:@"apply"]];
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
//    NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"100",@"activepoints", @"2017-09-05 15:02:56",@"creationdate", @"100",@"exp",@"http://api2.innfinityar.com/web/data/m5.png", @"headimageurl",@"10", @"level", @"157****1985",@"nickname", @"3",@"role",@"1",@"sex", @"48",@"userid", nil];
//    NSDictionary *dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"300",@"activepoints", @"2017-09-05 15:02:56",@"creationdate", @"400",@"exp", @"http://api.innfinityar.com/web/data/logo.jpg",@"headimageurl",@"3", @"level", @"clarence",@"nickname", @"5",@"role",@"2", @"sex",@"17", @"userid", nil];
//    NSDictionary *dic3=[[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"activepoints",@"2017-09-05 15:02:56", @"creationdate",  @"200",@"exp",@"http://wx.qlogo.cn/mmopen/VuOYOm8nBx6s5T49ib7MYH2AF39qoOnpFvgMZMN30yIxskaM8e21K8jgubiaq1TsibEthxtibwqAJkE8blJ5yKl51wtrAEC9kJGG/0",@"headimageurl", @"8",@"level", @"clarence Lu",@"nickname",  @"2",@"role",@"1",@"sex", @"67",@"userid", nil];
//    NSDictionary *dic4=[[NSDictionary alloc]initWithObjectsAndKeys:@"400",@"activepoints", @"2017-09-05 15:02:56",@"creationdate", @"300",@"exp", @"http://api2.innfinityar.com/web/data/m4.png",@"headimageurl",@"12", @"level", @"156****7660",@"nickname", @"0",@"role",@"2", @"sex",  @"92119",@"userid",nil];
//    memberArray=@[dic1,dic2,dic3,dic4,dic1,dic2,dic3,dic4];
    _familyMember = [[NSMutableArray alloc] initWithArray:memberArray];
    [self initManageDataForMemberArr:memberArray];
 
}

-(void)initManageDataForMemberArr:(NSArray *)dataArr{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]init];
    NSMutableArray *memberDetailArr0=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr1=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr2=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr3=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr4=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr5=[[NSMutableArray alloc]init];
    NSMutableArray *memberDetailArr6=[[NSMutableArray alloc]init];
    for (int i=0; i<dataArr.count; i++) {
        NSDictionary *memberDic=dataArr[i];
        switch ([[memberDic objectForKey:@"role"]integerValue]) {
            case 0:
                [memberDetailArr0 addObject:memberDic];
                break;
            case 1:
                [memberDetailArr1 addObject:memberDic];
                break;
            case 2:
                [memberDetailArr2 addObject:memberDic];
                break;
            case 3:
                [memberDetailArr3 addObject:memberDic];
                break;
            case 4:
                [memberDetailArr4 addObject:memberDic];
                break;
            case 5:
                [memberDetailArr5 addObject:memberDic];
                break;
            case 6:
                [memberDetailArr6 addObject:memberDic];
                break;
            default:
                break;
        }
    }
    [dataDic setObject:memberDetailArr0 forKey:@"0"];
     [dataDic setObject:memberDetailArr1 forKey:@"1"];
     [dataDic setObject:memberDetailArr2 forKey:@"2"];
     [dataDic setObject:memberDetailArr3 forKey:@"3"];
     [dataDic setObject:memberDetailArr4 forKey:@"4"];
     [dataDic setObject:memberDetailArr5 forKey:@"5"];
     [dataDic setObject:memberDetailArr6 forKey:@"6"];

    [self updataWithMemberManageDic:dataDic];
}

-(void)updataWithMemberManageDic:(NSDictionary*)data{
    [_memberManageDic removeAllObjects];
    _memberManageDic = [[NSMutableDictionary alloc] initWithDictionary:data];
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
