//
//  ActivityViewModel.h
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityView.h"
typedef void(^CompletionHandle)(NSError *error);
@interface ActivityViewModel : NSObject
@property(nonatomic)NSInteger rowNumber;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic)NSInteger refreshNumber;
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
-(void)pustDataForSomeString:(NSString *)string;
-(NSString*)mainPhotoUrlForRow:(NSInteger)row;
-(NSString *)numberWithPersonForRow:(NSInteger)row;
-(NSString *)themeForRow:(NSInteger)row;
-(NSString *)headPhotoUrlForRow:(NSInteger)row;
-(NSString *)commentForRow:(NSInteger)row;

//陆兄style
-(id)initWithController:(id)controller;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong) ActivityView *activityV;
@end
