//
//  looperChatCellViewCollectionViewCell.m
//  Looper
//
//  Created by lujiawei on 1/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperChatCellViewCollectionViewCell.h"
#import "LooperConfig.h"


@implementation looperChatCellViewCollectionViewCell
@synthesize looperCellV = _looperCellV;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    
    return self;
}



-(void)initCellWithData:(NSDictionary*)cellData and:(id)obj{
    [_looperCellV removeFromSuperview];
    _looperCellV =[[looperCellView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height) and:self];
    [_looperCellV createWithData:cellData and:obj];

    [self addSubview:_looperCellV];
}

@end
