//
//  integrateDetailView.h
//  Looper
//
//  Created by lujiawei on 13/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integrateDetailView : UIView
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;


-(void)updateDataView:(NSArray*)arrayData;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

@end
