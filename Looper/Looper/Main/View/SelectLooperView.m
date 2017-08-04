//
//  SelectLooperView.m
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SelectLooperView.h"
#import "AWCollectionViewDialLayout.h"
#import "LooperConfig.h"
#import "MainViewModel.h"
#import "UIImageView+WebCache.h"



static NSString *cellId = @"cellId";


@implementation SelectLooperView{

    NSMutableArray *loopArray;
    NSMutableArray *tempArray;
    
    int numCollection;
    
    bool closeLooperView;
    
    UICollectionView *loopCollectionV;
     NSMutableDictionary *thumbnailCache;
    CGFloat cell_height;
    AWCollectionViewDialLayout *dialLayout;

}
@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (UIView*)idObject;

        
    }
    return self;
}


-(UIButton*)createBtnImageName:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr andSize:(CGSize)FrameSize{
    
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
    
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setImage:clickImage forState:UIControlStateHighlighted];
    
    
    btn.tag = tag;
    
    [btn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchDown];
        return btn;
}


-(void)initViewWithArray:(NSMutableArray*)array{
    
    loopArray = array;
    numCollection = 0;
    NSLog(@"%@",loopArray);
    closeLooperView =false;
    [self createCollocationView];
    [self createBtn];

}


-(void)colloectionReload{
    
    [loopCollectionV setContentOffset:CGPointMake(0,-350*DEF_Adaptation_Font) animated:NO];
}

-(void)colloectionReloadUp{
    
    [loopCollectionV setContentOffset:CGPointMake(0,0) animated:YES];
    
}


-(void)createBtn{

    UIButton *looperBtn = [self createBtnImageName:@"btn_unlooper.png" andRect:CGPointMake(28, 1044) andTag:LopperBtnTag andSelectImage:nil andClickImage:@"btn_looper.png" andTextStr:nil andSize:CGSizeZero];
    
    [self addSubview:looperBtn];

}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(LopperBtnTag ==button.tag){

                [loopCollectionV setContentOffset:CGPointMake(0,-400*DEF_Adaptation_Font) animated:YES];
    }

}


-(void)removeCollocationV{


    [loopCollectionV removeFromSuperview];

}


- (void)scrollTap:(id)sender {
 
    
    [loopCollectionV setContentOffset:CGPointMake(0,-400*DEF_Adaptation_Font) animated:YES];
    
}

-(void)createCollocationView{
    
    CGFloat radius =240*DEF_Adaptation_Font;
    CGFloat angularSpacing =22*DEF_Adaptation_Font;
    CGFloat xOffset = 170*DEF_Adaptation_Font_x;
    CGFloat cell_width = 240;
    cell_height = 100;
    
    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
    [dialLayout setShouldSnap:YES];

    dialLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    loopCollectionV=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:dialLayout];
    
    [self addSubview:loopCollectionV];
    [loopCollectionV registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
  
    loopCollectionV.dataSource = self;
    loopCollectionV.delegate = self;
    loopCollectionV.scrollEnabled = YES;
    loopCollectionV.showsVerticalScrollIndicator = FALSE;
    loopCollectionV.showsHorizontalScrollIndicator = FALSE;
    
    [loopCollectionV setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [loopCollectionV addGestureRecognizer:myTap];
    myTap.cancelsTouchesInView =NO;
    
    [self performSelector:@selector(colloectionReloadUp) withObject:nil afterDelay:0.06];
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    int num_y = (int)scrollView.contentOffset.y;
        if(num_y<-390*DEF_Adaptation_Font){
            [loopCollectionV removeFromSuperview];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_obj removeSelectLoopV];
            });
        }

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return loopArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath");
    
    numCollection = numCollection+1;
    
    if(IS_IPHONE_6P_7P){
        if(numCollection ==3){
 
            [cv setContentOffset:CGPointMake(0,-350) animated:NO];
        }
    }else{
        if(numCollection ==4){
            [cv setContentOffset:CGPointMake(0,-350) animated:NO];
        }
    }
    
    
    UICollectionViewCell *cell;

    cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    [cell setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *item = [loopArray objectAtIndex:indexPath.item];
    
    NSString *playerName = [item valueForKey:@"LoopName"];
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:101];
    [nameLabel setText:playerName];
    
    NSString *messageCount = [item valueForKey:@"MessageCount"];
    UILabel *message = (UILabel*)[cell viewWithTag:107];
    [message setText:messageCount];

    if([messageCount intValue]==0){
    
        message.hidden = YES;
    }
    
    
    NSString *hexColor = @"#aa8d6b";
    NSString *imgURL = [item valueForKey:@"LoopTagImage"];
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:100];
    [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView setImage:nil];
        __block UIImage *imageProduct = [thumbnailCache objectForKey:imgURL];
        if(imageProduct){
            imgView.image = imageProduct;
        }
        else{
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                
                UIImageView *imageV= [[UIImageView alloc]init];
                [imageV setBackgroundColor:[UIColor clearColor]];
                 [imageV sd_setImageWithURL:imgURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    imgView.image = imageV.image;
                      [imgView setBackgroundColor:[UIColor clearColor]];
                    [thumbnailCache setValue:image forKey:imgURL];
                });
                
                 }];
            });
        }
        
   
    return cell;
}


-(UIColor*)colorFromHex:(NSString*)hexString{
    unsigned int hexint = [self intFromHexString:hexString];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1];
    
    return color;
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    return hexInt;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = [loopArray objectAtIndex:indexPath.item];
    CGPoint point = CGPointMake([[item objectForKey:@"CoordinateX"] floatValue], [[item objectForKey:@"CoordinateY"] floatValue]);
    [_obj mapToPostition:point];
    
}





@end
