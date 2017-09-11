//
//  FamilyView.h
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyView : UIView


{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
@property(nonatomic,strong)UIScrollView *sc;



@property(nonatomic,strong)NSArray *titleArray;
-(void)updateTitleArr;
-(void)updateSC;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject ;
-(void)initFamilyRankWithDataArr:(NSArray *)dataArr;
-(void)initFamilyListWithDataArr:(NSArray *)dataArr;
-(void)initFamilyMessageWithDataArr:(NSArray *)dataArr;
-(void)initFamilyDetailWithDataDic:(NSDictionary *)dataDic
                                         andApplyArr:(NSArray *)applyArr
                                             andLogArr:(NSArray *)logArr;
-(void)initFamilyMemberWithDataArr:(NSArray *)dataArr;
@end
