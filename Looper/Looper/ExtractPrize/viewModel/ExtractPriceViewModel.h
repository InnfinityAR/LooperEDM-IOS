//
//  ExtractPriceViewModel.h
//  Looper
//
//  Created by 工作 on 2017/8/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtractPriceViewModel : NSObject
@property(nonatomic,strong)id obj;
-(instancetype)initWithController:(id)controller;
-(void)updateView;
-(void)getRouletteProductForproductId:(NSInteger)productId andResultId:(NSInteger)resultId;
-(void)popViewController;

-(void)shareh5View:(NSDictionary*)webDic;
@end
