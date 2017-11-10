//
//  ShoppingViewController.m
//  Looper
//
//  Created by 工作 on 2017/11/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingViewModel.h"
@interface ShoppingViewController ()
@property(nonatomic,strong)ShoppingViewModel *shoppingVM;
@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shoppingVM=[[ShoppingViewModel alloc]initWithController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
