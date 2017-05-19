//
//  MainView.h
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)responeseMapData:(NSMutableArray *)mapData;
-(void)addLoopWithData:(NSDictionary*)loopData;

-(void)moveMap:(CGPoint)targetPoint;

-(void)requestMapData:(CGPoint)point;
-(void)updataView;

@end
