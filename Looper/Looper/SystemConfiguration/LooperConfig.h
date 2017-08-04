//
//  LooperConfig.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#ifndef LooperConfig_h
#define LooperConfig_h


#define DEF_Adaptation_Font_x (([UIScreen mainScreen].bounds.size.width / 320.0))

#define DEF_Adaptation_Font (([UIScreen mainScreen].bounds.size.height / 568.0))


#define DEF_WIDTH(view) view.bounds.size.width

#define DEF_HEIGHT(view) view.bounds.size.height

#define DEF_X(view) view.frame.origin.x

#define DEF_Y(view) view.frame.origin.y

#define DEF_RIGHT(view) (DEF_X(view) + DEF_WIDTH(view))

#define DEF_BOTTOM(view) (DEF_Y(view) + DEF_HEIGHT(view))

#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define DEF_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

#define DEF_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame

#define looperFont @"PingFang SC"

#define ColorRGB(x,y,z,a)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]

//#define looperFont @"Helvetica"



#define __kScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define __kScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_MAX_LENGTH (MAX(__kScreenWidth, __kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(__kScreenWidth, __kScreenHeight))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif /* LooperConfig_h */
