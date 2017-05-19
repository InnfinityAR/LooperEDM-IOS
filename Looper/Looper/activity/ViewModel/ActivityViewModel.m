//
//  ActivityViewModel.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewModel.h"
#import "activityModel.h"
#import "ActivityViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
@implementation ActivityViewModel
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
//陆兄style
-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (ActivityViewController*)controller;
        [self initView];
    }
    return  self;
}
-(void)initView{
    self.activityV = [[ActivityView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:self.activityV];
    
}



-(void)jumpToActivityH5:(NSDictionary *)ActivityDic{

    
    



}



-(NSInteger)rowNumber{
    
    return self.dataArr.count;
}
-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber+=1;
//    [self pustDataForSomeString:(NSString *)string];
    
}
-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber=0;
    //    [self pustDataForSomeString:(NSString *)string];
    
}
//加载数据
-(void)pustDataForSomeString:(NSString *)string{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
//    [dic setObject:string forKey:@"name"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"searchLoop" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            self.dataArr = [responseObject[@"data"] objectForKey:@"Loop"];
#warning -数据请求
//            [self.activityV reloadTableData:serachArray andUserArray:[responseObject[@"data"] objectForKey:@"User"]];
            
            if([self.dataArr count]==0){
                
                
                [[DataHander sharedDataHander] showViewWithStr:@"找不到喔，自己创建一个吧~" andTime:1 andPos:CGPointZero];
            }
        }
    }fail:^{
        
    }];
}
-(activityDataModel*)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}
-(NSURL*)mainPhotoUrlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].mainPhotoUrl];
}
-(NSString *)numberWithPersonForRow:(NSInteger)row{
    return [self modelForRow:row].numberWithPerson;
}
-(NSString *)themeForRow:(NSInteger)row{
    return [self modelForRow:row].theme;
}
-(NSURL *)headPhotoUrlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].headPhotoUrl];
}
-(NSString *)commentForRow:(NSInteger)row{
    return [self modelForRow:row].comment;
}
@end
