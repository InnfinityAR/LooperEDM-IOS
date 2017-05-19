//
//  CreateLoopViewModel.h
//  Looper
//
//  Created by lujiawei on 18/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nCreateLoopView.h"

@interface CreateLoopViewModel : NSObject{
    
    id obj;
    
    NSDictionary *tapData;
    
    
}
-(id)initWithController:(id)controller;
-(void)backView;
-(void)LocalPhoto;
-(void)takePhoto;
-(void)createLableView:(NSArray*)tagSelArray;
-(void)removeLableView:(NSArray*)array;
-(void)createLoopRequset:(NSString*)name andPhoto1:(NSString*)photo1Url andPhoto2:(NSString*)photo2Url andTags:(NSArray*)tags;


@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary *tapData;
@property(nonatomic,strong)nCreateLoopView  *createLoopV;

@end
