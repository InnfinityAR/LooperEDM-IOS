//
//  nActivityViewController.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nActivityViewModel.h"

@interface nActivityViewController : UIViewController
{
    
    nActivityViewModel *activityVm;
    
}
@property(nonatomic)nActivityViewModel *activityVm;
-(instancetype)initWithOrderArr:(NSArray*)orderArr;
@property(nonatomic,strong)NSArray *orderArr;
-(void)jumpToActivityId:(NSString*)activityId;

-(instancetype)initWithActivityDic:(NSDictionary *)dataDic andType:(NSInteger)type;
@end
