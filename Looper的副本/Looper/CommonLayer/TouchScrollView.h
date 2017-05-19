//
//  TouchScrollView.h
//  Looper
//
//  Created by lujiawei on 3/31/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;


@end

@interface TouchScrollView : UIScrollView
{
@private
    id touchDelegate;
}

@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;

@end
