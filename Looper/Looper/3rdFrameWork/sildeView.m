//
//  sildeView.m
//  Looper
//
//  Created by lujiawei on 10/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "sildeView.h"

@implementation sildeView{
    
    NSMutableArray *dataArray;
    

}

@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = idObject;
    }
    return self;
}


-(void)initView:(NSArray*)dataSource{
    [self createArray:dataSource];
    [self createSrollView];
    
    

}

-(void)createSrollView{
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //[scrollV setBackgroundColor:[UIColor redColor]];
    [self addSubview:scrollV];
    
    [self addLableView];
    
}

-(void)addLableView{
    
    
    

    

}

-(void)createArray:(NSArray*)dataArray{
    
   dataArray = [[NSMutableArray alloc]initWithCapacity:50];
    
}



@end
