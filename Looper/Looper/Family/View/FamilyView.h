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



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject ;
-(void)initFamilyRankWithDataArr:(NSArray *)dataArr;
-(void)initFamilyListWithDataArr:(NSArray *)dataArr;
-(void)initFamilyMessageWithDataArr:(NSArray *)dataArr;
-(void)initFamilyDetailWithDataDic:(NSDictionary *)dataDic;
-(void)initFamilyMemberWithDataArr:(NSArray *)dataArr;
@end
