//
//  LooperToolClass.m
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "LooperToolClass.h"
#import <UIKit/UIKit.h>
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "KKClickEffectImageView.h"

@implementation LooperToolClass



+(UILabel*)createLableView:(CGPoint)point andSize:(CGSize)FrameSize andText:(NSString*)lableStr andFontSize:(int)FontSize andColor:(UIColor*)color andType:(NSTextAlignment)type{
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(point.x,point.y,FrameSize.width, FrameSize.height)];
    if(lableStr!=[NSNull null]){
        lable.text  = lableStr;
    }
    [lable setFont:[UIFont fontWithName:looperFont size:FontSize*DEF_Adaptation_Font]];
    [lable setTextColor:color];
    
    lable.textAlignment = type;
    
    
    
    return  lable;
}

+(UIView*)createFrameView:(CGPoint)point andSize:(CGSize)FrameSize andFrameWide:(int)wide andRadius:(int)Radius{

    UIView *frame = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, FrameSize.width,FrameSize.height)];
    [frame setBackgroundColor:[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0]];
    frame.layer.cornerRadius = Radius;
    frame.layer.masksToBounds = YES;
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(wide,wide, FrameSize.width-wide*2,FrameSize.height-wide*2)];
    [bottomV setBackgroundColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:28/255.0 alpha:1.0]];
    [frame addSubview:bottomV];
    

    return frame;
}



+(UIView*)createViewAndRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius andImageName:(NSString*)imagePath{
    

    UIView *viewV = [[UIView alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font, FrameSize.width, FrameSize.height)];

    viewV.tag = tag;
    
    viewV.userInteractionEnabled=false;
    
    if(isRadius==true){
        viewV.layer.cornerRadius = FrameSize.width/2;
        viewV.layer.masksToBounds = YES;
    }
    if(imagePath!=nil){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, FrameSize.width,FrameSize.height)];
        [imageV sd_setImageWithURL:[[NSURL alloc] initWithString:imagePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
         [viewV addSubview:imageV];
        imageV.tag = 200;
        imageV.layer.cornerRadius = FrameSize.width/2;
        imageV.layer.masksToBounds = YES;
        
    }
    
    
    return viewV;
    
}

+(UIImageView*)createImageViewReal:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius{
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImageView *imageV;
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y,  FrameSize.width, FrameSize.height)];

    imageV.image = image;
    imageV.tag = tag;
    
    if(isRadius==true){
        imageV.layer.cornerRadius = FrameSize.width/2;
        if(FrameSize.width==0){
            imageV.layer.cornerRadius = imageV.frame.size.width/2;
        }
        imageV.layer.masksToBounds = YES;
    }
    return imageV;
    
}




+(UIImageView*)createImageView:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSize:(CGSize)FrameSize andIsRadius:(BOOL)isRadius{
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImageView *imageV;
    
    if(FrameSize.width==300*0.5*DEF_Adaptation_Font){
         imageV = [[UIImageView alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font,  FrameSize.width, FrameSize.height)];
    }else{
         imageV = [[UIImageView alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font,  image.size.width*DEF_Adaptation_Font*0.3, image.size.height*DEF_Adaptation_Font*0.3)];
    }
    imageV.image = image;
    imageV.tag = tag;
    
    if(isRadius==true){
         imageV.layer.cornerRadius = FrameSize.width/2;
        if(FrameSize.width==0){
             imageV.layer.cornerRadius = imageV.frame.size.width/2;
        }
        imageV.layer.masksToBounds = YES;
    }
    return imageV;
    
}



+(UIImageView*)createBtnImage:(NSString*)imagePath andRect:(CGPoint)point andTag:(int)Tag andSize:(CGSize)FrameSize andTarget:(id)obj{
    
    
    KKClickEffectImageView *imageV = [[KKClickEffectImageView alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font, FrameSize.width*0.5*DEF_Adaptation_Font,FrameSize.height*0.5*DEF_Adaptation_Font)];
    imageV.tag=Tag;

    [imageV sd_setImageWithURL:[[NSURL alloc] initWithString:imagePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    
    imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:obj action:@selector(onClickImage:)];
    [imageV addGestureRecognizer:singleTap];

    
   return imageV;
}

+(UIButton*)createBtnImageNameReal:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr andSize:(CGSize)FrameSize andTarget:(id)obj{
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selImage;
    if(SelimageN!=nil){
        selImage = [UIImage imageNamed:SelimageN];
    }
    UIImage *clickImage;
    if(clickImageN!=nil){
        clickImage = [UIImage imageNamed:clickImageN];
    }
    UIButton *btn;
    

    btn = [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y, FrameSize.width,FrameSize.height)];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setImage:clickImage forState:UIControlStateHighlighted];
    
    
    btn.tag = tag;
    
    [btn addTarget:obj action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
     return btn;
}



+(UIButton*)createBtnImageName:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr andSize:(CGSize)FrameSize andTarget:(id)obj{
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selImage;
    if(SelimageN!=nil){
        selImage = [UIImage imageNamed:SelimageN];
    }
    UIImage *clickImage;
    if(clickImageN!=nil){
        clickImage = [UIImage imageNamed:clickImageN];
    }
    UIButton *btn;
    if(FrameSize.width>0){
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font, FrameSize.width,FrameSize.height)];
        
        btn.layer.cornerRadius = FrameSize.width/2;
        btn.layer.masksToBounds = YES;
        
    }else{
        btn = [[UIButton alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font, image.size.width*DEF_Adaptation_Font*0.3,image.size.height*DEF_Adaptation_Font*0.3)];
    }
    
    if(TStr!=nil){
        UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(0,0,image.size.width*0.3*DEF_Adaptation_Font,image.size.height*0.3*DEF_Adaptation_Font)];
        lable.text = TStr;
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setTextColor:[UIColor whiteColor]];
        lable.font = [UIFont fontWithName:looperFont size:9*DEF_Adaptation_Font];
        lable.tag = 1000;
        [btn addSubview:lable];
        
    }
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setImage:clickImage forState:UIControlStateHighlighted];

    
    btn.tag = tag;
    
    [btn addTarget:obj action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIImage*)set_imageWithImage:(UIImage*)myImage
                  scaledToSize:(CGSize)newSize

{

    UIGraphicsBeginImageContext(newSize);

    [myImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

+(NSData*)set_ImageData_UIImageJPEGRepresentationWithImage:(UIImage*)image
                                 CGFloat_compressionQuality:(CGFloat)image_float
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateString = [formatter stringFromDate:[NSDate date]];
    dateString = [NSString stringWithFormat:@"%@.png",dateString];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    return imageData;
}


+(NSString*)ImageStrWithNum:(int)num{
    if(num<10){
        return [NSString stringWithFormat:@"0000%d",num];
    }else{
        return [NSString stringWithFormat:@"000%d",num];
    }
}

+(NSArray *)initialImageArray:(NSString*)ImageName andImageCount:(int)imageCount{
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:50];
    for (int num=0;num<imageCount;num++) {
            NSString *imageName = [NSString stringWithFormat:@"%@_%@.png",ImageName,[self ImageStrWithNum:num]];
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:imageName ofType:nil];

        
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [imageArray addObject:image];
    }
    return imageArray;
}



+(UIImageView*)LoadingImageName:(NSString*)imageName andCount:(int)count andDuration:(float)Duraction andloadScroll:(BOOL)isScroll andPoint:(CGPoint)point{
    UIImageView *imageObj;
    if(isScroll==true){
        imageObj=[[UIImageView alloc] initWithFrame:CGRectMake(point.x,point.y, 60, 60)];
    }else{
        imageObj=[[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-60, DEF_SCREEN_HEIGHT/2-60, 120, 120)];
    }
    imageObj.animationImages = [LooperToolClass initialImageArray:imageName andImageCount:count];
    imageObj.animationDuration = Duraction;
    imageObj.animationRepeatCount = 0;
    [imageObj startAnimating];//开始动画
    return imageObj;
}



+(void)didTapView:(UIView*)view andView:(UIView*)addView
{
    
    CAShapeLayer *circleShape = nil;
    CGFloat scale = 1.0f;
    
    CGFloat width = view.bounds.size.width, height = view.bounds.size.height;
    
    
    
    CGFloat biggerEdge = width > height ? width : height;
    CGFloat smallerEdge = width > height ? height : width;
    CGFloat radius = smallerEdge / 2 > 20 ? 20 : smallerEdge / 2;
    
    scale = biggerEdge / radius + 0.5;
    circleShape = [LooperToolClass createCircleShapeWithPosition:CGPointMake(view.frame.origin.x+view.frame.size.width/2, view.frame.origin.y+view.frame.size.height/2)
                                             pathRect:CGRectMake(0, 0, radius * 2, radius * 2)
                                               radius:radius];
    
    [addView.layer addSublayer:circleShape];
    
    
    
    [circleShape addAnimation:[LooperToolClass createFlashAnimationWithScale:scale duration:0.5f] forKey:nil];
    
}

+(CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius
{
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = [LooperToolClass createCirclePathWithRadius:rect radius:radius];
    circleShape.position = position;
    
    
    circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.strokeColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:0.7].CGColor;
    
    circleShape.opacity = 0;
    circleShape.lineWidth = 1;
    
    return circleShape;
}

+(CAAnimationGroup *)createFlashAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}

+(CGPathRef)createCirclePathWithRadius:(CGRect)frame radius:(CGFloat)radius
{
    return [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
}






@end
