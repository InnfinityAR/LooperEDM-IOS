//
//  CreateLoopViewModel.m
//  Looper
//
//  Created by lujiawei on 18/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateLoopViewModel.h"
#import "CreateLoopController.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "MoveLableView.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "Base64Class.h"
#import "DataHander.h"



@implementation CreateLoopViewModel{

    MoveLableView *moveLableV;

}


@synthesize obj = _obj;
@synthesize createLoopV = _createLoopV;
@synthesize tapData = _tapData;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (CreateLoopController*)controller;
        [self requestData];
    }
    return  self;
}


-(void)initView{
    
    _createLoopV = [[nCreateLoopView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:_createLoopV];
    
    
}


-(void)requestData{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getTag" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            _tapData = responseObject;
            
            [self initView];
        }
    }fail:^{
        
    }];

    //[self initView];
}



-(void)LocalPhoto
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        //[_obj presentModalViewController:picker animated:YES];
        [_obj presentViewController:picker animated:YES completion:nil];
       // [[_obj navigationController]  pushViewController:picker animated:NO];
        
        });
}


-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [_obj presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
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
        MyImage1=[LooperToolClass set_imageWithImage:image ToPoint:CGPointMake(0, 0) scaledToSize:CGSizeMake(600 * DEF_Adaptation_Font, 600 * DEF_Adaptation_Font) ];
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
        
        
        
        UIImage* MyImage2 = [[UIImage alloc]init];
        UIImage* Originalimage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSLog(@"%f",Originalimage.size.width);
        NSLog(@"%f",Originalimage.size.height);
        
        
        if(Originalimage.size.height - Originalimage.size.width>50){
             MyImage2=[LooperToolClass set_imageWithImage:Originalimage  ToPoint:CGPointMake(0, 0)  scaledToSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
        }else{
            [picker dismissViewControllerAnimated:YES completion:^(void){}];
            [[DataHander sharedDataHander] showViewWithStr:@"请上传竖版长方形图片" andTime:1 andPos:CGPointZero];
            return;
        }
       
        NSData * Originaldata = [LooperToolClass set_ImageData_UIImageJPEGRepresentationWithImage:MyImage2 CGFloat_compressionQuality:0.5];
        
        NSString * DocumentsPathOriginal = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManagerOriginal = [NSFileManager defaultManager];
        [fileManagerOriginal createDirectoryAtPath:DocumentsPathOriginal withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSDateFormatter *formatterOriginal = [[NSDateFormatter alloc] init];
        [formatterOriginal setTimeZone:[NSTimeZone systemTimeZone]];
        [formatterOriginal setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateStringOriginal = [formatterOriginal stringFromDate:[NSDate date]];
        dateStringOriginal = [NSString stringWithFormat:@"Original%@.png",dateStringOriginal];
        NSString* filePathOriginal  = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPathOriginal,dateStringOriginal];
        [fileManagerOriginal removeItemAtPath:filePathOriginal error:nil];
        [fileManagerOriginal createFileAtPath:filePathOriginal contents:Originaldata attributes:nil];
        
        [_createLoopV updataHeadView:filePath andSecondUrl:filePathOriginal];
        
        [picker dismissViewControllerAnimated:YES completion:^(void){}];
    }
}




-(void)createLoopRequset:(NSString*)name andPhoto1:(NSString*)photo1Url andPhoto2:(NSString*)photo2Url andTags:(NSArray*)tags{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:name forKey:@"name"];
    [dic setObject:@"" forKey:@"description"];
    [dic setObject:[LocalDataMangaer sharedManager].uid  forKey:@"userId"];
    UIImage *imagePhoto1 = [UIImage imageNamed:photo1Url];
    NSData *imageDataP1 = UIImagePNGRepresentation(imagePhoto1);
    [dic setObject:[Base64Class encodeBase64Data:imageDataP1] forKey:@"photo1"];
    UIImage *imagePhoto2 = [UIImage imageNamed:photo2Url];
    NSData *imageDataP2 = UIImagePNGRepresentation(imagePhoto2);
    [dic setObject:[Base64Class encodeBase64Data:imageDataP2] forKey:@"photo2"];
    [dic setObject:tags forKey:@"tags"];

    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createLoop" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
              [[DataHander sharedDataHander] showViewWithStr:@"Loop创建成功" andTime:1 andPos:CGPointZero];
            [self performSelector:@selector(backView) withObject:nil afterDelay:1.5];
            
        }else{
            
        }
    }fail:^{
        
    }];
    

}



-(void)removeLableView:(NSArray*)array{
    
    [_createLoopV addTag:array];
    
    [moveLableV removeFromSuperview];

}

-(void)createLableView:(NSArray*)tagSelArray{

    moveLableV = [[MoveLableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andTag:tagSelArray];
    
    [[_obj view] addSubview:moveLableV];
}



-(void)backView{

      [[_obj navigationController] popViewControllerAnimated:YES];
    
    // [_obj dismissViewControllerAnimated:YES completion:nil];

}


@end
