//
//  ActivityLayer.h
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ActivityLayer : UIView
{
    id obj;


}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)initViewWithData:(NSDictionary*)data;


@end
