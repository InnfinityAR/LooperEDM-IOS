//
//  FramilyModel.h
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FramilyModel : NSObject
{

    NSMutableDictionary *sourceDic;

    NSMutableArray *InviteArray;
    NSMutableArray *RankingArray;
    NSMutableArray *recommendArray;
    NSMutableDictionary *familyDetailData;
    NSMutableArray * familyMember;
    
}

@property(nonatomic)NSMutableArray *familyMember;
@property(nonatomic)NSMutableDictionary *sourceDic;
@property(nonatomic)NSMutableDictionary *familyDetailData;
@property(nonatomic)NSMutableArray *InviteArray;
@property(nonatomic)NSMutableArray *RankingArray;
@property(nonatomic)NSMutableArray *recommendArray;


-(void)initWithData:(NSDictionary*)data;
-(void)updataWithData:(NSDictionary*)data;
-(void)updataWithDetail:(NSDictionary*)data;



@end
