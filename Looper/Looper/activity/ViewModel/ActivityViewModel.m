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
#define ActivityURL @"getActivity"
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
    [AFNetworkTool Clarnece_Post_JSONWithUrl:ActivityURL parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            self.dataArr = responseObject[@"data"];
            
#warning -数据请求
            [self.activityV reloadTableData:self.dataArr];
            
            if([self.dataArr count]==0){
                
                
                [[DataHander sharedDataHander] showViewWithStr:@"找不到喔，自己创建一个吧~" andTime:1 andPos:CGPointZero];
            }
        }
    }fail:^{
        
    }];
}


-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber+=1;
//    [self pustDataForSomeString:(NSString *)string];
    
}
-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber=0;
    //    [self pustDataForSomeString:(NSString *)string];
    
}
-(void)popController{
    
    
    //   [_obj dismissViewControllerAnimated:YES completion:nil];
    [[_obj navigationController] popViewControllerAnimated:NO];
    
    //[_obj presentViewController:serachV animated:YES completion:nil];
    
}
-(void)dataForH5:(NSDictionary *)dic{

}
//-(NSInteger)rowNumber{
//    
//    return self.dataArr.count;
//}
//-(activityDataModel*)modelForRow:(NSInteger)row{
//    return self.dataArr[row];
//}
////活动图片
//-(NSURL*)activityimageUrlForRow:(NSInteger)row{
//    return [NSURL URLWithString:[self modelForRow:row].activityimage];
//}
////头像
//-(NSURL *)userimageUrlForRow:(NSInteger)row{
//    return [NSURL URLWithString:[self modelForRow:row].userimage];
//}
////名字.id等
//-(NSString *)useridWithPersonForRow:(NSInteger)row{
//    return [self modelForRow:row].userid;
//}
//-(NSString *)usernameForRow:(NSInteger)row{
//    return [self modelForRow:row].username;
//}
//
//-(NSString *)enddateForRow:(NSInteger)row{
//    return [self modelForRow:row].enddate;
//}
//-(NSString *)startdateForRow:(NSInteger)row{
//    return [self modelForRow:row].startdate;
//}
@end
