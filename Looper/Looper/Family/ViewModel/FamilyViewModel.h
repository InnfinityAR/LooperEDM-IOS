//
//  FamilyViewModel.h
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyRankView.h"
#import "FamilyView.h"
#import "FamilySearchView.h"
#import "FramilyModel.h"
@interface FamilyViewModel : NSObject

{
    id obj;
    
}

@property (nonatomic )id obj;

-(id)initWithController:(id)controller;
-(void)popController;

@property(nonatomic,strong)FamilyView *familyView;
@property(nonatomic,strong)FamilyRankView *rankView;
@property(nonatomic,strong)FamilySearchView *searchView;
@property(nonatomic,strong)FramilyModel *familyModel;





-(void)getFamilyRankDataForOrderType:(NSString*)orderType andRaverId:(NSString *)raverId;
-(void)getRaverData;
-(void)searchRaverFamilyDataForSearchText:(NSString*)searchText;
-(void)getFamilyDetailDataForRfId:(NSString*)rfId andRank:(NSString *)rankNumber;


@end
