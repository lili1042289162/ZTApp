//
//  CommentViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/7/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CommentViewController.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "ZTImageLoader.h"
#import "ZTCoverView.h"
#import "OrderCpmcModel.h"
#import "ZTTextContentView.h"
#import "ZTRoundButton.h"
#import "orderInfo.h"
@interface CommentViewController()<NetResultProtocol>{
ZTTitleLabel*titlelabel;
UIView*topview;
//ZTSessionView*prodetail;
UIView*prodetail;
    UIScrollView *sv;
    ZTRoundButton *submit;
orderInfo*oneorder;
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle];
    //[self initData];
    [self initView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerKeyboardNotification];
   [self getonder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unRegisterKeyboardNotification];
}

-(void)initTitle{
    titlelabel=[[ZTTitleLabel alloc]initWithTitle:@"评价"];
    [titlelabel fitSize];
    self.navigationItem.titleView=titlelabel;
}
-(void)initData{

}
-(void)initView{
    topview=(UIView*)self.topLayoutGuide;
    //prodetail=[ZTSessionView new];
    sv = [UIScrollView new];
    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *grz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollViewAreaa)];
    [sv addGestureRecognizer:grz];


prodetail=[[UIView alloc]initWithFrame:CGRectZero];
    ZTImageLoader*pic = [ZTImageLoader new];
     [pic setImageFromUrl:self.value.cppic];
    
     UILabel* title = [[UILabel alloc] init];
    [title setFont:[UIFont systemFontOfSize:12.0]];
    [title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    title.text=[NSString stringWithFormat:@"%@",self.value.cpmc];
    
    
    UILabel* dolla = [[UILabel alloc] init];
    [dolla setText:@"￥"];
    [dolla  setFont:[UIFont systemFontOfSize:13.0]];
    [dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    
    UILabel *totolprice= [[UILabel alloc] init];
    [totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    totolprice.text=[NSString stringWithFormat:@"%@",self.value.oje];
    
    UILabel* shuliang = [[UILabel alloc] init];
    [shuliang setText:@"数量: "];
    [shuliang  setFont:[UIFont systemFontOfSize:10.0]];
    [shuliang setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    UILabel* quantity = [[UILabel alloc] init];
    [quantity setFont:[UIFont systemFontOfSize:9.6]];
    [quantity setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    quantity.text=[NSString stringWithFormat:@"x%@",self.value.osl];

[prodetail addSubViews:@[pic,totolprice,dolla,shuliang,quantity,title]];

    [[[[pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:27.5] setRectMarginLeft:7.5];
    
    [[[[title fitSize] setRectOnRightSideOfView:pic] addRectX:10.0] setRectMarginTop:35.0];
    [[[[dolla fitSize] setRectOnRightSideOfView:pic] addRectX:10.0] setRectMarginTop:60.0];
    [[[totolprice fitSize] setRectOnRightSideOfView:dolla]setRectMarginTop:60.0];
    [[[[[ shuliang fitSize] setRectMarginTop:60.0]setRectOnRightSideOfView:totolprice]addRectX:80]setRectMarginTop:60.0];
    [[[quantity fitSize] setRectMarginTop:60.0] setRectOnRightSideOfView:shuliang];
    prodetail.backgroundColor=[UIColor whiteColor];

[self initcomment];
  submit = [[ZTRoundButton alloc] initWithTitle:@"提交" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
  
    [submit addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
[sv addSubViews:@[prodetail,self.comment,submit]];
[self.view addSubview:sv];
}

-(void)initcomment{
    
   self.comment = [ZTTextContentView new];
   self.comment.text =@"请留下你的宝贵意见：";
   self.comment.leftBorder = YES;
   self.comment.rightBorder = YES;
   self.comment.bottomBorder = YES;
   self.comment.topBorder = YES;
   self.comment.borderWidth = 1.0;
   self.comment.editable = YES;
   self.comment.scrollEnabled = YES;
   self.comment.font = [UIFont systemFontOfSize:10.0];
   self.comment.textColor = [UIColor colorWithHex:0x505050];
   self.comment.keyboardType = UIKeyboardTypeDefault;
self.comment.delegate=self;
    
}
//留言板键盘回收
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
   
    return YES;
}

-(void)viewWillLayoutSubviews{
    [[[sv setScreenWidth] setRectMarginTop:50] heightToEndWithPadding:0.0];
[[[prodetail setScreenWidth]setRectHeight:100]setRectMarginTop:55] ;
//[[[[self.comment fitSize] setScreenWidth]setRectBelowOfView:prodetail]addRectY:15];
    [[[[[[self.comment fitSize] setRectMarginLeft:27.0] widthToEndWithPadding:27.0] setRectBelowOfView:prodetail]
      addRectY:12.0] setRectHeight:134.0];
     [[[[[submit fitSize] setRectBelowOfView:self.comment] addRectY:23.0] setRectWidth:103.0] setRectCenterHorizentail];
        sv.contentSize = [sv fillSize];
}
-(void)didTapScrollViewAreaa{
   
    [self.comment resignFirstResponder];
}
-(void)tijiao{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ORDRECCOM] delegate:self cancelIfExist:YES];
    
    
    [ZTCoverView alertCover];

}
-(void)getonder{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
     [ZTCoverView alertCover];

}
#pragma mark - Status Events

-(void)keyBoardWillShow:(NSNotification*)notf{
    NSDictionary *info = [notf userInfo];
    CGRect keyBoardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets edge = sv.contentInset;
    edge.bottom = keyBoardRect.size.height;
    sv.contentInset = edge;
}

-(void)keyBoardWillHidde:(NSNotification*)notf{
    sv.contentInset = UIEdgeInsetsZero;
}

#pragma mark - helpers

-(void)registerKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidde:) name:UIKeyboardWillHideNotification object:self.view.window];
}

-(void)unRegisterKeyboardNotification{

[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECCOM]]){
    [self.navigationController popViewControllerAnimated:YES];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]){}
    
    
    NSLog(@"tijiao1l1a1");
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECCOM]]){
    }

[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECCOM]]){
     [params addEntriesFromDictionary:@{
     NET_ARG_ORDRECCOM_ORDNO:[NSString stringWithFormat:@"%@", self.father] ,
     NET_ARG_ORDRECCOM_SHOPID:[NSString stringWithFormat:@"%@", oneorder.shopid] ,
     NET_ARG_ORDRECCOM_CPID:[NSString stringWithFormat:@"%@", self.value.cpmid] ,
     NET_ARG_ORDRECCOM_CPMC:[NSString stringWithFormat:@"%@", self.value.cpmc] ,
     NET_ARG_ORDRECCOM_LEVEL:[NSString stringWithFormat:@"%@", @"2"] ,
     NET_ARG_ORDRECCOM_DFEN:[NSString stringWithFormat:@"%@", @"80"] ,
      NET_ARG_ORDRECCOM_MEMO:[NSString stringWithFormat:@"%@", self.comment.text] ,
       NET_ARG_ORDRECCOM_ONOX:[NSString stringWithFormat:@"%@", self.value.ordnox] ,}];
    
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
   
        [params addEntriesFromDictionary:@{NET_ARG_DETAIL_ORDNO: [NSString stringWithFormat:@"%@", self.father]}];
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECCOM]]){
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]){
        NSArray *orderes = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
//        NSMutableArray*oneorder=[NSMutableArray array];
//        [oneorder removeAllObjects];
//        [oneorder addObjectsFromArray:orderes];
    oneorder=orderes[0];
   
     NSLog(@"resule%@",result);
    }

}
@end
