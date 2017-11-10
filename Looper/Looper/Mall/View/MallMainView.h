//
//  MallMainView.h
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallMainView : UIView
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updateDataView:(NSDictionary*)sourceData;


@end
