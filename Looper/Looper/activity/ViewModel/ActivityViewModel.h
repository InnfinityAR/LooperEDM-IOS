//
//  ActivityViewModel.h
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityView.h"
@class ActivityView;
typedef void(^CompletionHandle)(NSError *error);
@interface ActivityViewModel : NSObject

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic)NSInteger refreshNumber;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)ActivityView *activityV;
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
-(void)pustDataForSomeString:(NSString *)string;

//陆兄style
-(id)initWithController:(id)controller;
-(void)popController;
-(void)dataForH5:(NSDictionary *)dic;

-(void)sendActivityMessage:(NSString *)activityId and:(NSString*)message and:(NSArray*)images;
-(void)getActivityInfoById:(NSString *)activityId;

@end
