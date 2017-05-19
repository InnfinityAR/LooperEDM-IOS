//
//  CreateLoopView.h
//  Looper
//
//  Created by lujiawei on 18/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nCreateLoopView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(void)updataHeadView:(NSString*)picUrl andSecondUrl:(NSString*)SecondUrl;
-(void)addTag:(NSArray*)tagArray;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

@end
