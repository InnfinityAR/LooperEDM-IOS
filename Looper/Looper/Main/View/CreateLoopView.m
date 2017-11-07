//
//  CreateLoopView.m
//  Looper
//
//  Created by lujiawei on 1/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateLoopView.h"
#import "MainViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "SelectToolView.h"
#import "SelectTitleView.h"
#import "UIImage+RTTint.h"
#import "DataHander.h"

#define defalutContentStr @"写几句loop的介绍吧"

#define defalutNameStr @" loop的名字"





@implementation CreateLoopView{

    
    SelectToolView *select;
    NSMutableArray *listTypes;
    SelectTitleView *selectTitleV;
    
    UITextView *textview;
    UITextField *loopName;
    UIButton *head;
    UIImageView *content;
    UIButton *backBtn;
    UIButton *createLoopBtn;
    UIImageView *detialText;
    UIButton *titleBtn;
    
    NSString *headUrl;
    UIImageView *bk;
    
    int selectTypeNum;
    double colorNum;
    NSTimer *timeColor;

    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)data
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        listTypes=data;
        headUrl = nil;
        [self initView];
        
        
    }
    return self;
}


-(void)createBackGround{
    colorNum = 0.01f;
    
    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,0*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    bk=[LooperToolClass createImageView:@"createLoopBk.png" andRect:CGPointMake(7, 248) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 548*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    
    
    UIImageView *line=[LooperToolClass createImageView:@"bg_createloop_line.png" andRect:CGPointMake(18, 259) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 525*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:line];
    
     timeColor = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(updateColor) userInfo:nil repeats:YES];
    
    
}

-(void)updateColor{
    
    UIImage *tinted = [bk.image rt_tintedImageWithColor: [UIColor colorWithHue:colorNum+0.003f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    colorNum = colorNum +0.003f;
    bk.image = tinted;
    if(colorNum>1.0){
        colorNum = 0.001f;
    }
}




-(void)removeLayer:(int)tag{
    
    [selectTitleV removeFromSuperview];
    
    if(tag!=backTag){
        selectTypeNum = tag;
        [titleBtn removeFromSuperview];
        NSString *imagePath;
        for (NSDictionary*dic in listTypes ){
            int tagNum=[[dic objectForKey:@"TypeID"] intValue];
            if(tagNum ==selectTypeNum){
                
                imagePath = [dic objectForKey:@"TypeImage"];
                break;
            }
        }

        titleBtn =[LooperToolClass createBtnImage:imagePath andRect:CGPointMake(447, 484) andTag:titleTag andSize:CGSizeMake(109, 45) andTarget:self];
        [self addSubview:titleBtn];

    }
}

-(void)selectViewType:(int)type andSelectNum:(int)selNum andSelectStr:(NSString*)Selstr{
    
    [select removeFromSuperview];
    if(type==jumpCamera){
        if(selNum==0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_obj takePhoto];
            });
        }else if(selNum==1){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_obj LocalPhoto];
            });
        }
    }
}

-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    
    if(tap.view.tag==titleTag){
        selectTitleV = [[SelectTitleView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:listTypes];
        [self addSubview:selectTitleV];
    }
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==jumpCamera){
    
        select =[[SelectToolView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        select.multipleTouchEnabled=true;
        [self addSubview:select];
        NSMutableArray *array =[[NSMutableArray alloc] initWithCapacity:50];
        [array addObject:@"拍照"];
        [array addObject:@"从相册中选择"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:array forKey:@"dataArray"];
        [select initView:dic andViewType:2 andTypeTag:jumpCamera];
    }else if(button.tag==titleTag){
        selectTitleV = [[SelectTitleView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:listTypes];
        [self addSubview:selectTitleV];
    
    }else if(button.tag==createLoopTag){
        
        if(headUrl!=nil && textview.text!=nil &&loopName.text!=nil){
            NSMutableDictionary *loopData = [[NSMutableDictionary alloc] initWithCapacity:50];
            [loopData setObject:headUrl forKey:@"head"];
            [loopData setObject:textview.text forKey:@"content"];
            [loopData setObject:loopName.text forKey:@"loopName"];
            [loopData setObject:[[NSNumber alloc] initWithInt:selectTypeNum] forKey:@"selectType"];
            [_obj requestCreateLoop:loopData];
        }else{
             [[DataHander sharedDataHander] showViewWithStr:@"输入的数据错误" andTime:2 andPos:CGPointZero];
        
        
        }
    }else if(button.tag==createLoopBackTag){
        
        [timeColor invalidate];
    }
    [self.obj hudOnClick:button.tag];
    
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

   
    if([textView.text isEqualToString:defalutContentStr]){
    
         textView.text = @"";
    }
    self.frame=CGRectMake(0, -70*DEF_Adaptation_Font, self.frame.size.width, self.frame.size.height);
    
    return true;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

   
    if( textView.text.length==0){
    
        textView.text =defalutContentStr;
    }
    
      self.frame=CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    
    return true;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    

}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{



}

-(void)updataHeadView:(NSString*)imageStr{
    
    [head removeFromSuperview];
    headUrl= imageStr;
    
    head = [LooperToolClass createBtnImageName:imageStr andRect:CGPointMake(498, 362) andTag:jumpCamera andSelectImage:imageStr andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font_x*0.5, 58*DEF_Adaptation_Font_x*0.5)  andTarget:self];
    [self addSubview:head];

}

-(void)createUIAction{

    content=[LooperToolClass createImageView:@"bg_createloop_content.png" andRect:CGPointMake(84, 375) andTag:100 andSize:CGSizeMake(126*DEF_Adaptation_Font_x*0.5, 216*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:content];
    
    backBtn = [LooperToolClass createBtnImageName:@"btn_createLoop_back.png" andRect:CGPointMake(48, 286) andTag:createLoopBackTag andSelectImage:@"btn_createLoop_back.png" andClickImage:@"btn_createLoop_back.png" andTextStr:nil andSize:CGSizeZero andTarget:self] ;
    
    [self addSubview:backBtn];
    
    createLoopBtn = [LooperToolClass createBtnImageName:@"btn_createLoop_create.png" andRect:CGPointMake(452, 291) andTag:createLoopTag andSelectImage:@"btn_createLoop_create.png" andClickImage:@"btn_createLoop_create.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    
    [self addSubview:createLoopBtn];
    
    detialText=[LooperToolClass createImageView:@"bg_createloop_text.png" andRect:CGPointMake(75, 606) andTag:100 andSize:CGSizeMake(488*DEF_Adaptation_Font_x*0.5, 146*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:detialText];
    
    
    titleBtn = [LooperToolClass createBtnImageName:@"btn_default_title.png" andRect:CGPointMake(447, 484) andTag:titleTag andSelectImage:@"btn_default_title.png" andClickImage:@"btn_default_title.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    titleBtn.frame = CGRectMake(447*DEF_Adaptation_Font_x*0.5, 484*DEF_Adaptation_Font_x*0.5, 109*DEF_Adaptation_Font_x*0.5, 45*DEF_Adaptation_Font_x*0.5);
    [self addSubview:titleBtn];

    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(75*DEF_Adaptation_Font_x*0.5, 606*DEF_Adaptation_Font_x*0.5, 488*DEF_Adaptation_Font_x*0.5, 146*DEF_Adaptation_Font*0.5)];
    textview.backgroundColor=[UIColor clearColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:looperFont size:10*DEF_Adaptation_Font]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    textview.text = defalutContentStr;//设置显示的文本内容
    [self addSubview:textview];
    
    
    head = [LooperToolClass createBtnImageName:@"icon_headPic.png" andRect:CGPointMake(498, 362) andTag:jumpCamera andSelectImage:@"icon_headPic.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    head.frame = CGRectMake(498*DEF_Adaptation_Font_x*0.5, 362*DEF_Adaptation_Font_x*0.5, 58*DEF_Adaptation_Font_x*0.5, 58*DEF_Adaptation_Font_x*0.5);
    head.layer.cornerRadius = 58*DEF_Adaptation_Font_x*0.5/2;
    head.layer.masksToBounds = YES;
    [self addSubview:head];
    
    loopName = [self createTextField:defalutNameStr andRect:CGRectMake(276, 436, 281, 29) andTag:100];
    [self addSubview:loopName];

}

-(UITextField*)createTextField:(NSString*)string andRect:(CGRect)rect andTag:(int)num{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(rect.origin.x*DEF_Adaptation_Font*0.5,rect.origin.y*DEF_Adaptation_Font*0.5,  rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    textField.font =[UIFont fontWithName:looperFont size:14*DEF_Adaptation_Font];
    textField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    textField.delegate = self;
    textField.textAlignment = UITextAlignmentRight;
    return textField;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self endEditing:YES];
        return YES;
}




-(void)initView{
    
    [self createBackGround];
    [self createUIAction];
    
    
    
    
    
}

@end

