//
//  FamilyHeaderView.m
//  Looper
//
//  Created by 工作 on 2017/9/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyHeaderView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"
@interface FamilyHeaderView()
{
    UIImageView *SQCodeIV;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation FamilyHeaderView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataDic=dataDic;
        [self initView];
    }
    return self;
}
-(void)initView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    [self setBackgroundColor:[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0]];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-130*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5)];
    imageView.layer.cornerRadius=130*DEF_Adaptation_Font*0.5;
    imageView.layer.masksToBounds=YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"images"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self addSubview:imageView];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 350*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40, 40*DEF_Adaptation_Font*0.5)];
    nameLB.textAlignment=NSTextAlignmentCenter;
    nameLB.textColor=[UIColor whiteColor];
    nameLB.font=[UIFont boldSystemFontOfSize:18];
    nameLB.text=[NSString stringWithFormat:@"%@家族",[self.dataDic objectForKey:@"ravername"]];
    [self addSubview:nameLB];
    
    UILabel *declarationLB=[[UILabel alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    declarationLB.textColor=[UIColor lightGrayColor];
    declarationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16.f];
    declarationLB.textAlignment=NSTextAlignmentCenter;
    declarationLB.numberOfLines=2;
    declarationLB.text=@"每一个残暴的君主都能懂得怜悯；每一个失落的灵魂中都有创造奇迹的傲骨";
    [self addSubview:declarationLB];
    
    UILabel *levelLB=[[UILabel alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, 500*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    levelLB.textColor=[UIColor whiteColor];
    levelLB.font=[UIFont systemFontOfSize:16];
    levelLB.text=@"等级";
    [self addSubview:levelLB];
     [self initProgressVWithRate:[_dataDic objectForKey:@"raverexp"] andSum:@"16000"];
    UILabel *levelNumLB=[[UILabel alloc]initWithFrame:CGRectMake(110*DEF_Adaptation_Font*0.5, 495*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    levelNumLB.textColor=[UIColor whiteColor];
    levelNumLB.layer.cornerRadius=20*DEF_Adaptation_Font*0.5;
    levelNumLB.layer.masksToBounds=YES;
    levelNumLB.text=[self.dataDic objectForKey:@"raverlevel"];
    levelNumLB.textAlignment=NSTextAlignmentCenter;
    levelNumLB.backgroundColor=ColorRGB(193, 158, 252, 1.0);
    [self addSubview:levelNumLB];
   
    SQCodeIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-130*DEF_Adaptation_Font*0.5, 600*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5)];
    if ([self.dataDic objectForKey:@"raverqrcodeurl"]==[NSNull null]) {
        SQCodeIV.image=[UIImage imageNamed:@"familydetail_code.png"];
    }else{
        [SQCodeIV sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"raverqrcodeurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    [self addSubview:SQCodeIV];
    
    UILabel *codeLB=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-150*DEF_Adaptation_Font*0.5, 880*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    codeLB.textColor=[UIColor whiteColor];
    codeLB.font=[UIFont systemFontOfSize:14];
    codeLB.text=@"扫一扫二维码,加入家族";
    codeLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:codeLB];
    
    UIButton *saveBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(60*DEF_Adaptation_Font*0.5, 960*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(220*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    [saveBtn setTitle:@"保存到手机" forState:(UIControlStateNormal)];
    saveBtn.titleLabel.font =  [UIFont boldSystemFontOfSize:14];
    saveBtn.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    saveBtn.layer.borderWidth=1.0;
    saveBtn.layer.borderColor=[[UIColor whiteColor]CGColor];;
    saveBtn.layer.masksToBounds=YES;
    [saveBtn setTintColor:[UIColor whiteColor]];
    [self addSubview:saveBtn];
    
    UIButton *shareCodeBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(360*DEF_Adaptation_Font*0.5, 960*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(220*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    shareCodeBtn.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    shareCodeBtn.layer.masksToBounds=YES;
    shareCodeBtn.backgroundColor=ColorRGB(193, 158, 252, 1.0);
    shareCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [shareCodeBtn setTitle:@"分享二维码" forState:(UIControlStateNormal)];
    [shareCodeBtn setTintColor:[UIColor whiteColor]];
    [self addSubview:shareCodeBtn];
    
}
-(void)initProgressVWithRate:(NSString*)rate andSum:(NSString*)sum{
    UIView *progressV=[[UIView alloc]initWithFrame:CGRectMake(148*DEF_Adaptation_Font*0.5, 505*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-200*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5)];
    progressV.backgroundColor=[UIColor grayColor];
    progressV.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    progressV.layer.masksToBounds=YES;
    [self addSubview:progressV];
    UIView *progressV1=[[UIView alloc]initWithFrame:CGRectMake(148*DEF_Adaptation_Font*0.5, 505*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-200*DEF_Adaptation_Font*0.5)*[rate intValue]/[sum intValue], 18*DEF_Adaptation_Font*0.5)];
    if (rate==sum) {
        progressV1.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
        progressV1.layer.masksToBounds=YES;
    }
    progressV1.backgroundColor=ColorRGB(193, 159, 252, 1.0);
    [self addSubview:progressV1];
    UILabel *numberLB=[[UILabel alloc]initWithFrame:CGRectMake(160*DEF_Adaptation_Font*0.5, 540*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-210*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    numberLB.textAlignment=NSTextAlignmentRight;
    numberLB.textColor=[UIColor lightGrayColor];
    numberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    numberLB.text=[NSString stringWithFormat:@"%d/%d",[rate intValue],[sum intValue]];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:numberLB.text];
    [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(193, 158, 252, 1.0)range:NSMakeRange(0, rate.length)];
    numberLB.attributedText= aString;
    [self addSubview:numberLB];
   
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag==99) {
        [self removeFromSuperview];
    }
    if (tag==100) {
        [self snapshotScreenInView:self];
//保存到手机
    }if(tag==101){
//分享二维码
    }
}
//手机截图效果
- (void)snapshotScreenInView:(UIView *)contentView {
    CGSize size = contentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = contentView.frame;
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"已存入手机相册"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"保存失败"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}
@end
