//
//  sendPhotoWall.h
//  Looper
//
//  Created by lujiawei on 12/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHImageViewer.h"

@interface sendPhotoWall : UIView <UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,XHImageViewerDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)videoFileSave:(NSString*)videoFile;

-(void)setLocationStr:(NSString*)str;

-(void)ImageFileSave:(UIImage*)imageFile;

@end
