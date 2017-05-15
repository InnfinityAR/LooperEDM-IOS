//
//  DataHander.h
//  CaCaXian
//
//  Created by Nancy on 13-4-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>	
#import "MBProgressHUD.h"




@interface DataHander : NSObject
{
    MBProgressHUD* mbProgressHud;
    UIImageView *loadImage;
    UIView *bk;
    UIImageView *showV;
    
    UIView *showViewLable;
    
    
}


+(DataHander *)sharedDataHander;

-(void)showDlg;
-(void)hideDlg;
-(void)showView:(NSString*)imagePah andTime:(int)Time andPos:(CGPoint)point;
-(void)showViewWithStr:(NSString *)labelStr andTime:(int)Time andPos:(CGPoint)point;

//取消请求
-(void)cancelRequest;
@end
