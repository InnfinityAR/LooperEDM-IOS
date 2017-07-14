//
//  sendPhotoWall.h
//  Looper
//
//  Created by lujiawei on 12/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendPhotoWall : UIView <UITextViewDelegate,UITextFieldDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)videoFileSave:(NSString*)videoFile;

@end
