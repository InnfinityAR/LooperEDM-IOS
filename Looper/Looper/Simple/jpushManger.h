//
//  jpushManger.h
//  Looper
//
//  Created by lujiawei on 07/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JPUSHService.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
    #import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>


@interface jpushManger : NSObject <JPUSHRegisterDelegate>
{



}

+(jpushManger *)sharedManager;

@end
