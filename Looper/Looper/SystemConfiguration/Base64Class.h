//
//  Base64Class.h
//  Looper
//
//  Created by lujiawei on 1/13/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Class : NSObject{




}

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;



@end
