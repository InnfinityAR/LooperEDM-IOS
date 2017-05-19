//
//  LooperScorllLayer.h
//  Looper
//
//  Created by lujiawei on 2/9/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LooperScorllLayer : UIView{

    id obj;

}

@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)initView:(CGRect)frame andStr:(NSArray*)strArray andType:(int)type;


@end
