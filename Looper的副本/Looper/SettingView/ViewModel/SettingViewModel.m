//
//  SettingViewModel.m
//  Looper
//
//  Created by lujiawei on 23/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "SettingView.h"
#import "myInfoView.h"
#import "AccoutView.h"
#import "opinionView.h"
#import "PhoneBindView.h"
#import "SettingViewController.h"
#import "LooperToolClass.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "Base64Class.h"
#import "DataHander.h"
#import "LoginViewController.h"

@implementation SettingViewModel{

    myInfoView *myInfoV;
    AccoutView *accoutV;
    PhoneBindView *phoneBindV;
    opinionView *opinionV;
    

}
@synthesize  settingV = _settingV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (SettingViewController*)controller;
        [self initView];
    }
    return  self;
}


-(void)initView{
    
    _settingV = [[nSettingView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:_settingV];
}

-(void)LocalPhoto
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        
       // [[_obj navigationController] pushViewController:picker animated:YES];

        
        [_obj presentViewController:picker animated:YES completion:nil];
        
    });
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* MyImage1 = [[UIImage alloc]init];
        
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        //NSData *imageData = UIImagePNGRepresentation(image);
        MyImage1=[LooperToolClass set_imageWithImage:image scaledToSize:CGSizeMake(600 * DEF_Adaptation_Font, 600 * DEF_Adaptation_Font)];
        NSData * data = [LooperToolClass set_ImageData_UIImageJPEGRepresentationWithImage:MyImage1 CGFloat_compressionQuality:0.5];
        
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"%@.png",dateString];
        NSString* filePath = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPath,dateString];
        [fileManager removeItemAtPath:filePath error:nil];
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
        
        [myInfoV updataHeadView:filePath];
        [opinionV updataHeadView:filePath];


        [picker dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

-(void)updateUserInfo:(NSString*)userName andSex:(int)sex andHeadImage:(NSString*)headUrl{
    
    
    if([userName isEqualToString:@""]){
        userName = [LocalDataMangaer sharedManager].NickName;
    }
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    if(headUrl !=nil){
        UIImage *imagePhoto = [UIImage imageNamed:headUrl];
        NSData *imageData = UIImagePNGRepresentation(imagePhoto);
        [dic setObject:[Base64Class encodeBase64Data:imageData] forKey:@"headImage"];
    }
    [dic setObject:[[NSNumber alloc] initWithInt:sex] forKey:@"gender"];
    [dic setObject:userName forKey:@"name"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"updateUserInfo" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            [LocalDataMangaer sharedManager].HeadImageUrl = responseObject[@"data"][@"headimageurl"];
            [LocalDataMangaer sharedManager].sex = responseObject[@"data"][@"sex"];
            [LocalDataMangaer sharedManager].NickName = responseObject[@"data"][@"nickname"];
       
            
             [[LocalDataMangaer sharedManager] setData];
            
            
            
        }
    }fail:^{
        
    }];
}


-(void)requestDataCode:(NSString*)mobileNum{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:mobileNum forKey:@"mobile"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendVerificationCode" parameters:dic  success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    }fail:^{
        
    }];
}


-(void)bindMobile:(NSString*)mobileNum andCode:(NSString*)code{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:code forKey:@"vCode"];
    [dic setObject:mobileNum forKey:@"mobile"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"bindMobile" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
             [[DataHander sharedDataHander] showViewWithStr:@"手机绑定成功" andTime:1 andPos:CGPointZero];
            
             [self removePhoneBindView];
            
            [accoutV updataAccess:2];
            
        }else{
            
        }
    }fail:^{
        
        
    }];
}


-(void)bugReport:(NSString*)reportString and:(NSString*)path{
    if([reportString length]!=0){
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:reportString forKey:@"bug"];
    UIImage *imagePhoto = [UIImage imageNamed:path];
    NSData *imageData = UIImagePNGRepresentation(imagePhoto);
    [dic setObject:[Base64Class encodeBase64Data:imageData] forKey:@"screenshot1"];
  
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"bugReport" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            [self removeAccoutView];
            [[DataHander sharedDataHander] showViewWithStr:@"上传成功 感谢您的支持" andTime:1 andPos:CGPointZero];
        }else{
            
            
             [self removeAccoutView];
        }
    }fail:^{
        
    }];
    }else{
         [[DataHander sharedDataHander] showViewWithStr:@"大人请留下您的建议" andTime:1 andPos:CGPointZero];
    }
}


-(void)backController{

    [[_obj navigationController] popViewControllerAnimated:YES];
    
}


-(void)removePhoneBindView{

    [phoneBindV removeFromSuperview];
    
}

-(void)addPhoneBindView{

    phoneBindV =  [[PhoneBindView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
     [[_obj view] addSubview:phoneBindV];
}


-(void)removeInfoView{
    [myInfoV removeFromSuperview];
}


-(void)addInfoView{
    
    myInfoV = [[myInfoView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:myInfoV];

}

-(void)removeAccoutView{

    [accoutV removeFromSuperview];

}

-(void)addAccoutView{
    
    accoutV = [[AccoutView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:accoutV];
    
}

-(void)addOpinionView{
    opinionV = [[opinionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:opinionV];
}

-(void)jumpLoginViewC{
    LoginViewController* login = [[LoginViewController alloc] init];
    
    [[_obj view] window].rootViewController = login;
    [[[_obj view] window] makeKeyAndVisible];
}


-(void)removeOpinionView{
    [opinionV removeFromSuperview];
}




@end
