//
//  LocalDataMangaer.h
//  Looper
//
//  Created by lujiawei on 12/21/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDataMangaer : NSObject{

    NSString * uid;
    NSString * thirdId;
    NSDictionary *userData;
    NSString *tokenStr;
    NSString *HeadImageUrl;
    NSString *sex;
    NSString *NickName;
    NSString *age;
    NSArray *rouletteArr;
    NSString *raverid;
    NSString *role;
    NSString *creditNum;
    
    NSDictionary *localUserData;
    
    int loginType;
    
    
    
}
@property(nonatomic,strong)NSString * age;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * thirdId;
@property(nonatomic,strong)NSDictionary * userData;
@property(nonatomic,strong)NSString *tokenStr;
@property(nonatomic,strong)NSString *HeadImageUrl;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,strong)NSDictionary *localUserData;
@property(nonatomic,strong)NSArray *rouletteArr;
@property(nonatomic,strong)NSString *raverid;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSString *creditNum;

@property(nonatomic)int loginType;


+(LocalDataMangaer *)sharedManager;

-(void)setData;
-(void)getData;

-(BOOL)isHasUserData;

@end
