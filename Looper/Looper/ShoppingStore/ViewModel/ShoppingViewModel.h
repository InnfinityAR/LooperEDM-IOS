//
//  ShoppingViewModel.h
//  Looper
//
//  Created by 工作 on 2017/11/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingViewModel : NSObject
-(id)initWithController:(id)controller;
-(void)popViewController;
@property(nonatomic,strong)id obj;
@end
