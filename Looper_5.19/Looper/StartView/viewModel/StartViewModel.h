//
//  StartViewModel.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StartView.h"
#import "SelectView.h"

@interface StartViewModel : NSObject{


         id obj;
        StartView *StartV;
        SelectView *selectView;
    

}

@property(nonatomic,strong)id obj;
@property(nonatomic)StartView *StartV;
@property(nonatomic)SelectView *selectView;


-(id)initWithController:(id)controller;
-(void)removeSelectToStart:(int)typeNum;
-(void)toMainView:(NSArray*)resultArray;

@end
