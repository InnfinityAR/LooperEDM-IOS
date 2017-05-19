//
//  SimpleChatCollectionViewCell.m
//  Looper
//
//  Created by lujiawei on 2/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SimpleChatCollectionViewCell.h"
#import "SimpleCellView.h"

@implementation SimpleChatCollectionViewCell
@synthesize simpleCellV = _simpleCellV;


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}



-(void)initCellWithData:(NSDictionary*)cellData and:(id)obj and:(BOOL)hasTime{
    [_simpleCellV removeFromSuperview];
    _simpleCellV =[[SimpleCellView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height) and:self];
    [_simpleCellV createWithData:cellData and:obj and:hasTime];
    [self addSubview:_simpleCellV];
}



@end
