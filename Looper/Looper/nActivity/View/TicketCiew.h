//
//  TicketCiew.h
//  Looper
//
//  Created by 工作 on 2017/5/26.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketCiew : UIView <UIWebViewDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
@property(nonatomic,strong)NSDictionary *dataDic;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDic:(NSDictionary *)dataDic;
-(void)removeActivityAction;
@end
