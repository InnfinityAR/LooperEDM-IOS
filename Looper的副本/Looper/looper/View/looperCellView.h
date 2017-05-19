//
//  looperCellView.h
//  Looper
//
//  Created by lujiawei on 1/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface looperCellView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


-(void)createWithData:(NSDictionary*)cellData and:(id)obj;

@end





