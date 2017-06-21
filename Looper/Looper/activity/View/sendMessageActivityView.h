//
//  sendMessageActivityView.h
//  Looper
//
//  Created by lujiawei on 20/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewModel.h"

@interface sendMessageActivityView : UIView <UITextViewDelegate,UITextFieldDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)showSelectImage:(NSString*)selectImage;

@end
