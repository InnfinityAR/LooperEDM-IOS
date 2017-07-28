


//
//  GALActionOnCalendar.m
//  写入日历demo
//
//  Created by guanalong on 16/6/7.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import "GALActionOnCalendar.h"
#import "DataHander.h"
#import "nActivityViewModel.h"
#import <EventKit/EventKit.h>

@implementation GALActionOnCalendar

+(void)saveEventStartDate:(NSDate *)startData endDate:(NSDate *)endDate alarm:(float)alarm eventTitle:(NSString *)eventTitle location:(NSString *)location notes:(NSString *)notes andObj:(id)obj
{
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //06.07 使用 requestAccessToEntityType:completion: 方法请求使用用户的日历数据库
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                      [[DataHander sharedDataHander] showViewWithStr:@"请允许插入日程" andTime:1 andPos:CGPointZero];
                }
                else
                {
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title  = eventTitle;
                    event.location = location;
                    event.startDate = startData;
                    event.endDate   = endDate;
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];

                    event.notes = notes;
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    
                    
                    
                    
                    [obj setCalendarData];
                    
                    [[DataHander sharedDataHander] showViewWithStr:@"已添加至日历" andTime:1 andPos:CGPointZero];
                }
            });
        }];
    }
}


@end
