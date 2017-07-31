//
//  LocalDataMangaer.m
//  Looper
//
//  Created by lujiawei on 12/21/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//


    

#import "LocalDataMangaer.h"

static LocalDataMangaer *localDataManagerM=nil;

@implementation LocalDataMangaer
@synthesize uid = _uid;
@synthesize thirdId = _thirdId;
@synthesize userData = _userData;
@synthesize tokenStr = _tokenStr;
@synthesize HeadImageUrl = _HeadImageUrl;
@synthesize sex = _sex;
@synthesize age = _age;
@synthesize NickName = _NickName;
@synthesize localUserData = _localUserData;
@synthesize loginType = _loginType;


+(LocalDataMangaer *)sharedManager{
    if(localDataManagerM==nil){
        localDataManagerM=[[LocalDataMangaer alloc]init];
    }
    return localDataManagerM;
}



-(void)setData{

    [[NSUserDefaults standardUserDefaults] setObject:_uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] setObject:_thirdId forKey:@"thirdId"];
    [[NSUserDefaults standardUserDefaults] setObject:_tokenStr forKey:@"tokenStr"];
    [[NSUserDefaults standardUserDefaults] setObject:_HeadImageUrl forKey:@"HeadImageUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:_sex forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setObject:_age forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] setObject:_NickName forKey:@"NickName"];

}

-(void)getData{
    
    _uid=[[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    _thirdId=[[NSUserDefaults standardUserDefaults] objectForKey: @"thirdId"];
    _tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey: @"tokenStr"];
    _HeadImageUrl=[[NSUserDefaults standardUserDefaults] objectForKey: @"HeadImageUrl"];
    _sex=[[NSUserDefaults standardUserDefaults] objectForKey: @"sex"];
    _NickName=[[NSUserDefaults standardUserDefaults] objectForKey: @"NickName"];
    _age=[[NSUserDefaults standardUserDefaults] objectForKey: @"_age"];
    
}

-(BOOL)isHasUserData{
    if([[NSUserDefaults standardUserDefaults] objectForKey: @"uid"]!=nil){
        [self getData];
        return true;
    }else{
        return false;
        
    }
    return false;
}





@end
