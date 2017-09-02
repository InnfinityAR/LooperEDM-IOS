//
//  FamilySearchView.h
//  Looper
//
//  Created by 工作 on 2017/9/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilySearchView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject ;
@property(nonatomic,strong)id obj;
-(void)initSearchData:(NSArray*)searchData;
@end
