//
//  opinionView.h
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface opinionView : UIView <UITextViewDelegate,UITextFieldDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updataHeadView:(NSString*)imageStr;
@end
