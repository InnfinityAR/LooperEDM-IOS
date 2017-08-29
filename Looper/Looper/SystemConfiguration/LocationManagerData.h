//
//  LocationManagerData.h
//  Looper
//
//  Created by lujiawei on 24/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationManagerData : CLLocationManager <CLLocationManagerDelegate>
{
    
    CGPoint LocationPoint_xy;

}

+(instancetype)sharedManager;
-(void)getLocalationPoint;

@property(nonatomic)CGPoint LocationPoint_xy;

@end
