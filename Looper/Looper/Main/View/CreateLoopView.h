//
//  CreateLoopView.h
//  Looper
//
//  Created by lujiawei on 1/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define backTag 80080

@interface CreateLoopView : UIView <UITextViewDelegate,UITextFieldDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(void)removeLayer:(int)tag;
-(void)updataHeadView:(NSString*)imageV;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)data;

@end
