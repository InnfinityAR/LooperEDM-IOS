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
@interface FamilyViewModel : NSObject

{
    id obj;
    
}

@property (nonatomic )id obj;

-(id)initWithController:(id)controller;
-(void)popController;

@property(nonatomic,strong)FamilyView *familyView;
@property(nonatomic,strong)FamilyRankView *rankView;
-(void)getFamilyRankDataForOrderType:(NSString*)orderType;
-(void)getRaverData;

-(void)searchRaverFamilyDataForSearchText:(NSString*)searchText;
@end
