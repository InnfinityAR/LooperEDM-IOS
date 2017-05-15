//
//  looperDetailView.h
//  Looper
//
//  Created by lujiawei on 1/19/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface looperDetailView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)initViewData:(NSDictionary*)looperData;

@end
