//
//  ExtractPriceViewController.m
//  Looper
//
//  Created by 工作 on 2017/8/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ExtractPriceViewController.h"
#import "ExtractPriceViewModel.h"
@interface ExtractPriceViewController ()
@property(nonatomic,strong)ExtractPriceViewModel *extractVM;
@end

@implementation ExtractPriceViewController
-(ExtractPriceViewModel *)extractVM{
    if (!_extractVM) {
        _extractVM=[[ExtractPriceViewModel alloc]initWithController:self];
    }
    return _extractVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.extractVM updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    
    if (! [ [ self.navigationController viewControllers] containsObject:self]) {
        [_extractVM removeActivityAction];
    }
    [super viewWillDisappear:animated];
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
