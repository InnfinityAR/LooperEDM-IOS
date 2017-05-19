//
//  activityModel.h
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class activityDataModel;
@interface activityModel : BaseModel
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSArray *data;

@end
@interface activityDataModel : BaseModel
//@property(nonatomic,strong)NSString *mainPhotoUrl;
//@property(nonatomic,strong)NSString *numberWithPerson;
//@property(nonatomic,strong)NSString *theme;
//@property(nonatomic,strong)NSString *headPhotoUrl;
//@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *activityimage;
@property(nonatomic,strong)NSString *startdate;
@property(nonatomic,strong)NSString *enddate;
@property(nonatomic,strong)NSString *userimage;
@property(nonatomic,strong)NSString *username;
@end
