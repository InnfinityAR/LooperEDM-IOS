//
//  ShoppingViewModel.m
//  Looper
//
//  Created by 工作 on 2017/11/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ShoppingViewModel.h"
#import "ShoppingViewController.h"
#import "ShoppingDetailView.h"
@interface ShoppingViewModel()
{
    ShoppingDetailView *detailV;
}
@end
@implementation ShoppingViewModel
-(id)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(ShoppingViewController *)controller;
        [self creatDetailView];
    }
    return self;
}
-(void)popViewController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}
-(void)creatDetailView{
    detailV=[[ShoppingDetailView alloc]initWithFrame:[self.obj view].bounds andObject:self];
    [[self.obj view]addSubview:detailV];
}
@end
