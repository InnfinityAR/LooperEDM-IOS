//
//  ActivitySerachView.h
//  Looper
//
//  Created by lujiawei on 26/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitySerachView : UIView
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updateDataView:(NSArray*)dataArray;
@end
