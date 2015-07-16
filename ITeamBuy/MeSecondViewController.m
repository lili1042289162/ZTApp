//
//  MeSecondViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/6/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "MeSecondViewController.h"
#import "MeCell.h"
#import "ZTIconButton.h"
#import "ZTTitleLabel.h"
#import "ZTDataCenter.h"
#import "SettingViewController.h"
#import "User.h"
#import "WaitForExpressViewController.h"
#import "NoPayViewController.h"
#import "PayedViewController.h"
#import "MyAddressViewController.h"
#import "MyCollectionViewController.h"
#import "PersonInfoViewController.h"
#import "ZTQViewController.h"
#import "LoginViewController.h"
#import "RevivceGoodViewController.h"
#import "MysuggestViewController.h"
#import "MyCommentViewController.h"
#import "User.h"
#import "ZTImageLoader.h"
#import "DisCountViewController.h"
#import "ZTCoverView.h"
#import "DisCountmodel.h"
#import "MeBtnview.h"
#import "SaleBarItem.h"
#import "ZTButtonGridView.h"
#import "ZTButtonCell.h"
#import "DisCountViewController.h"

@interface MeSecondViewController ()<NetResultProtocol,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZTButtonGridViewDelegate>{
    /// header views
    UIView*topview;
    UIView *_headerView;
    UIView*tuanbiview;
    ZTIconButton *_userInfoArea;
    MeBtnview*MeView;
    ZTIconButton *_ZTQuan;
    ZTIconButton *CollectShop;
    ZTIconButton*_ZTBi;
    ZTIconButton*_YouHuiJuan;
    ZTIconButton*_FootLog;
    UIView*nologin;
    SaleBarItem*MyorderList;
    SaleBarItem*Mytotlemoney;
    SaleBarItem*Suggest;
    /// data messageaqq
    NSArray* _iconNames;
    NSArray* _titleNames;
    NSArray* _CallBackbtn;
    User* _currentUser;
    NSNumber*coll;
    NSNumber*nopay;
    NSNumber*tmquan;
    NSNumber*tbmoney;
    UIImage*image;
    NSData*upimagedata;
    NSString*Headurl;
    User*userr;
    ZTImageLoader*pichead;
    NSMutableArray*dicountrr;
    ZTButtonGridView*catagorybtns;
}

@end

@implementation MeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
   [self initHeader];
    
    NSLog(@"one");
}
-(void)viewWillDisappear:(BOOL)animated
{  [super viewWillDisappear:animated];
[ _ZTQuan removeFromSuperview];
[CollectShop  removeFromSuperview];
[_FootLog removeFromSuperview];
[MeView removeFromSuperview];
[nologin removeFromSuperview];
[MyorderList removeFromSuperview];
[catagorybtns removeFromSuperview];
[tuanbiview removeFromSuperview];
[Suggest removeFromSuperview];
[Mytotlemoney removeFromSuperview];
    NSLog(@"xiaoshillma");
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"two");
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (token) {
        NSLog(@"token12%@",token);
        [self upDateDataIfNeed];
        MeView = [MeBtnview new];
        MeView.icon.layer.cornerRadius=5.0;
            MeView.icon.image = [UIImage imageNamed:@"btn_me_user"];
            userr=[[ZTDataCenter sharedInstance]getCurrentUser];
            NSLog(@"hahahhaha%@",userr);
            NSLog(@"picccc%@",userr.avatar);
            pichead=[ZTImageLoader new];
            [pichead fitSize];
            dispatch_async(dispatch_get_main_queue(), ^{
                [pichead setImageFromUrl:userr.avatar];
                NSLog(@"pichead%@",pichead);
                MeView.icon.image=pichead.image;
            });
        
        UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChangeImage:)];
        [MeView.icon addGestureRecognizer:tapGeture];
        MeView.labelTop.font = [UIFont systemFontOfSize:12.0];
        _currentUser = [[ZTDataCenter sharedInstance] getCurrentUser];
        NSLog(@"wwwwwwwww%@",_currentUser);
        MeView.labelTop.text = _currentUser.nickname;
        
        
        
        MeView.labelBottom.font = [UIFont systemFontOfSize:12.0];
        MeView.labelBottom.text = @"游客";
        MeView.iconTopGap = 10.0;
        MeView.backgroundColor = [UIColor clearColor];
        MeView.topBorder = YES;
        MeView.bottomBorder = YES;
        MeView.borderWidth = 0.5;
        [MeView setTarget:self trigger:@selector(didTapUserInfo:)];
        
        //// ZTQuan button
        _ZTQuan = [ZTIconButton new];
        _ZTQuan.labelTop.text = @"    10    ";
        _ZTQuan.labelBottom.text = @"收藏商品";
        _ZTQuan.labelTop.font=[UIFont systemFontOfSize:12];
        _ZTQuan.labelBottom.font=[UIFont systemFontOfSize:12];
         _ZTQuan.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        _ZTQuan.alignMode = ZTIconButtonAlignModeCenter;
        _ZTQuan.iconLeftGap = 15.0;
        _ZTQuan.iconContentGap = 25.0;
        _ZTQuan.topBorder = YES;
        _ZTQuan.borderWidth = 0.5;
        _ZTQuan.backgroundColor = [UIColor clearColor];
        [_ZTQuan setTarget:self trigger:@selector(didTapMyCollectionBtn)];
        //// wait to pay button
        CollectShop = [ZTIconButton new];
        CollectShop.labelTop.text = @"    10    ";
        CollectShop.labelBottom.text =@"收藏商家";
        CollectShop.labelTop.font=[UIFont systemFontOfSize:12];
        CollectShop.labelBottom.font=[UIFont systemFontOfSize:12];
        CollectShop.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        CollectShop.alignMode = ZTIconButtonAlignModeCenter;
        CollectShop.iconLeftGap = 15.0;
        CollectShop.iconContentGap = 15.0;
        CollectShop.topBorder = YES;
        CollectShop.borderWidth = 0.5;
        CollectShop.backgroundColor = [UIColor clearColor];
        [CollectShop setTarget:self trigger:@selector(didTapMyCollectionShopBtn)];
        
        _FootLog = [ZTIconButton new];
        _FootLog.labelTop.text = @"    64    ";
        _FootLog.labelBottom.text =@"浏览记录";
        _FootLog.labelTop.font=[UIFont systemFontOfSize:12];
        _FootLog.labelBottom.font=[UIFont systemFontOfSize:12];
        _FootLog.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        _FootLog.alignMode = ZTIconButtonAlignModeCenter;
        _FootLog.iconLeftGap = 15.0;
        _FootLog.iconContentGap = 15.0;
        _FootLog.topBorder = YES;
        _FootLog.borderWidth = 0.5;
        _FootLog.backgroundColor = [UIColor clearColor];
        [_FootLog setTarget:self trigger:@selector(didTapMyLogBtn)];
        
        /// layouts
        [[MeView setScreenWidth]
         setRectHeight:100.0];
        
        [[[_ZTQuan setRectWidth:106.6]
          setRectHeight:33.0]
         setRectBelowOfView:MeView];
        
        [[[[CollectShop setRectWidth:106.6]
           setRectHeight:33.0]
          setRectBelowOfView:MeView]
         setRectOnRightSideOfView:_ZTQuan];
        
        [[[[_FootLog setRectWidth:106.6]
           setRectHeight:33.0]
          setRectBelowOfView:MeView]
         setRectOnRightSideOfView:CollectShop];
        

        
        [_headerView addSubViews:@[MeView,_ZTQuan,CollectShop,_FootLog]];
          //[[[_headerView wrapContents] addRectHeight:0.0] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2"]]];
        [[[_headerView wrapContents] addRectHeight:0.0] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2"]]];
    }
    if (nil==token) {
        NSLog(@"twotime");
       nologin=[[UIView alloc]init];
               nologin.userInteractionEnabled=YES;
        _userInfoArea.icon.image = [UIImage imageNamed:@"btn_me_user"];
        //UIImageView*MePic=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_me_user"]];
        UILabel*tishi=[[UILabel alloc]init];
        tishi.font = [UIFont systemFontOfSize:15.0];
        tishi.textColor = [UIColor colorWithHex:0x9b9b9b];
        tishi.text=@" 亲！你还没有登录咯~~~";
        UIButton*denglu=[[UIButton alloc]init];
        denglu.backgroundColor=[UIColor redColor];
        [denglu setTitle:@"请登录" forState:UIControlStateNormal ];
        
        [denglu.layer setMasksToBounds:YES];
        [denglu.layer setCornerRadius:5.0];//设置矩形四个圆角半径
        [denglu.layer setBorderWidth:0.3];//边框宽度
        
        //// ZTQuan button
        _ZTQuan = [ZTIconButton new];
        _ZTQuan.labelTop.text = @"    10    ";
        _ZTQuan.labelBottom.text = @"收藏商品";
        _ZTQuan.labelBottom.font=[UIFont systemFontOfSize:14];
         _ZTQuan.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        _ZTQuan.alignMode = ZTIconButtonAlignModeCenter;
        _ZTQuan.iconLeftGap = 15.0;
        _ZTQuan.iconContentGap = 25.0;
        _ZTQuan.topBorder=YES;
        _ZTQuan.borderWidth = 0.5;
        _ZTQuan.backgroundColor = [UIColor clearColor];
        [_ZTQuan setTarget:self trigger:@selector(didTapMyCollectionBtn)];
        //// wait to pay button
        CollectShop = [ZTIconButton new];
        CollectShop.labelTop.text = @"    10    ";
        CollectShop.labelBottom.text =@"收藏商家";
        CollectShop.labelBottom.font=[UIFont systemFontOfSize:14];
        CollectShop.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        CollectShop.alignMode = ZTIconButtonAlignModeCenter;
        CollectShop.iconLeftGap = 15.0;
        CollectShop.iconContentGap = 15.0;
        CollectShop.topBorder=YES;
        CollectShop.borderWidth = 0.5;
        CollectShop.backgroundColor = [UIColor clearColor];
        [CollectShop setTarget:self trigger:@selector(didTapMyCollectionShopBtn)];
        
        
        _FootLog = [ZTIconButton new];
        _FootLog.labelTop.text = @"    64    ";
        _FootLog.labelBottom.text =@"浏览记录";
        _FootLog.alignMode = ZTIconButtonAlignModeCenter;
        _FootLog.labelBottom.font=[UIFont systemFontOfSize:14];
        _FootLog.labelBottom.textColor = [UIColor colorWithHex:0x333333];
        _FootLog.iconLeftGap = 15.0;
        _FootLog.iconContentGap = 15.0;
        _FootLog.topBorder=YES;
        _FootLog.borderWidth = 0.5;
        _FootLog.backgroundColor = [UIColor clearColor];
        [_FootLog setTarget:self trigger:@selector(didTapMyLogBtn)];
        
        
        [nologin addSubViews:@[tishi,denglu]];
        [[nologin setScreenWidth]
         setRectHeight:80.0];
        [[[tishi fitSize]setRectMarginTop:7.0]setRectCenterInParent];
        [[denglu fitSize]setRectBelowOfView:tishi];
        
        denglu.frame=CGRectMake(117, 55, 80, 20);
        [denglu addTarget:self action:@selector(loginin:) forControlEvents: UIControlEventTouchUpInside];
        
        [[[_ZTQuan setRectWidth:106.6]
          setRectHeight:40.0]
         setRectBelowOfView:nologin];
        [[[[CollectShop setRectWidth:106.6]
           setRectHeight:40.0]
          setRectBelowOfView:nologin]
         setRectOnRightSideOfView:_ZTQuan];
        
        [[[[_FootLog setRectWidth:106.6]
           setRectHeight:40.0]
          setRectBelowOfView:nologin]
         setRectOnRightSideOfView:CollectShop];
        

        [_headerView addSubViews:@[nologin,_ZTQuan,CollectShop,_FootLog]];
        [[[_headerView wrapContents] addRectHeight:0.0] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2"]]];
       
    }
    
   
    MyorderList = [SaleBarItem initWithIcon:[UIImage imageNamed:@"order"] title:@"我的订单" indicator:YES];
    UILabel*g=[[UILabel alloc]initWithFrame:CGRectMake(220, 6, 80, 20)];
    g.font=[UIFont systemFontOfSize:12];
    g.text=@"查看全部订单";
    [MyorderList addSubview:g];
    
    
    Mytotlemoney = [SaleBarItem initWithIcon:[UIImage imageNamed:@"Mymoney"] title:@"我的资产" indicator:YES];
    UILabel*showtotlemoney=[[UILabel alloc]initWithFrame:CGRectMake(220, 6, 80, 20)];
    showtotlemoney.font=[UIFont systemFontOfSize:12];
    showtotlemoney.text=@"查看全部资产";
    [Mytotlemoney addSubview:showtotlemoney];

    
    Suggest = [SaleBarItem initWithIcon:[UIImage imageNamed:@"suggest"] title:@"意见反馈" indicator:NO];
    
    for (SaleBarItem *item in  @[MyorderList,Mytotlemoney,Suggest]) {
        item.borderWidth = 1.0;
        item.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        item.showIndicator = YES;
        item.indicatorRightMargin = 15.0;
        item.iconLeftGap = 10.0;
        item.icon2titleGap = 8.0;
        item.titleLabel.font = [UIFont systemFontOfSize:14.0];
        item.backgroundColor = [UIColor whiteColor];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    
    MyorderList.topBorder = YES;
    MyorderList.bottomBorder = YES;
    [MyorderList addTarget:self action:@selector(showmyorder:) forControlEvents:UIControlEventTouchUpInside];
    
    
    Mytotlemoney.topBorder = YES;
    Mytotlemoney.bottomBorder = YES;
    [Mytotlemoney addTarget:self action:@selector(showtotlemoney:) forControlEvents:UIControlEventTouchUpInside];

    
    
    Suggest.topBorder = YES;
    Suggest.bottomBorder = YES;
    [Suggest addTarget:self action:@selector(didTapMysuggest:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSDictionary*sourcees=[NSDictionary dictionaryWithObjects:@[_iconNames,_titleNames] forKeys:@[@"icons",@"titles"]];
    catagorybtns=[[ZTButtonGridView alloc]initWithIcons:sourcees cell:@"ZTButtonCell" column:4 rowSpace:1.0 columnSpace:1.0 edgeSpace:1.0 version:nil];
    catagorybtns.borderWidth=1.0;
    catagorybtns.bottomBorder=YES;
    catagorybtns.borderColor=[UIColor colorWithHex:COL_LINEBREAK];
    catagorybtns.ztButtonViewDelegate=self;
    
   // ZTIconButton*_ZTBi;
    //ZTIconButton*_YouHuiJuan;
    
    _ZTBi = [ZTIconButton new];
     _ZTBi.labelBottom.font=[UIFont systemFontOfSize:12];
    _ZTBi.labelTop.text = @" 3000 ";
    _ZTBi.labelBottom.text =@"中团币";
    _ZTBi.alignMode = ZTIconButtonAlignModeCenter;
    _ZTBi.iconLeftGap = 15.0;
    _ZTBi.iconContentGap = 15.0;
    _ZTBi.topBorder=YES;
    _ZTBi.borderWidth = 0.5;
    _ZTBi.backgroundColor = [UIColor clearColor];
   // [_ZTBi setTarget:self trigger:@selector(didTapNoPayBtn:)];
    

    _YouHuiJuan = [ZTIconButton new];
    _YouHuiJuan.labelTop.text = @" 4 ";
    _YouHuiJuan.labelBottom.text =@"优惠劵";
      _YouHuiJuan.labelBottom.font=[UIFont systemFontOfSize:12];
    _YouHuiJuan.alignMode = ZTIconButtonAlignModeCenter;
    _YouHuiJuan.iconLeftGap = 15.0;
    _YouHuiJuan.iconContentGap = 15.0;
    _YouHuiJuan.topBorder=YES;
    _YouHuiJuan.borderWidth = 0.5;
    _YouHuiJuan.backgroundColor = [UIColor clearColor];

    
    
    [[[_ZTBi setRectWidth:106.6]
      setRectHeight:40.0]
     setRectBelowOfView:Mytotlemoney];
    [[[[_YouHuiJuan setRectWidth:106.6]
       setRectHeight:40.0]
      setRectBelowOfView:Mytotlemoney]
     setRectOnRightSideOfView:_ZTBi];
    tuanbiview=[[UIView alloc]init];
    tuanbiview.backgroundColor=[UIColor whiteColor];
   [ tuanbiview addSubViews:@[_ZTBi,_YouHuiJuan]];
   
    
    
    
[self.view addSubViews:@[MyorderList,catagorybtns,Mytotlemoney,tuanbiview,Suggest]];
}

-(void)initHeader{
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_headerView];
}
-(void)viewDidLayoutSubviews{
    [_headerView setRectBelowOfView:topview];
    [[[MyorderList setScreenWidth]setRectHeight:33.0]setRectBelowOfView:_headerView];
    [[[catagorybtns  setRectHeight:44] setRectBelowOfView:MyorderList]addRectY:0.0];
     [[[[Mytotlemoney setScreenWidth]setRectHeight:33.0]setRectBelowOfView:catagorybtns]addRectY:3.0];
     [[[tuanbiview setScreenWidth]setRectHeight:36]setRectBelowOfView:Mytotlemoney];
    [[[[Suggest setScreenWidth]setRectHeight:33.0]setRectBelowOfView:tuanbiview]addRectY:10];
}

#pragma mark - build views

-(void)initTitleBar{
    
    ZTTitleLabel *titleView = [[ZTTitleLabel alloc] initWithTitle:@"我的"];
    topview=(UIView*)self.topLayoutGuide;
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"btn_me_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(didTapSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *settingButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton2 setBackgroundImage:[UIImage imageNamed:@"messageaqq"] forState:UIControlStateNormal];
    [settingButton2 addTarget:self action:@selector(didTapSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView fitSize];
    [settingButton fitSize];
    [settingButton2 fitSize];

    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.topItem.title = @"返回";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton2];
    self.navigationItem.titleView = titleView;
}
/**
 初始化header
 */

#pragma mark - Button Click Event
-(void)didTapCollectionAtIndex:(NSIndexPath*)index{
    NSInteger row = [index row];
    [self performSelector:NSSelectorFromString(_CallBackbtn[row]) withObject:nil afterDelay:0];


}


-(void)loginin:(UIButton*)sender{
    
    LoginViewController*loginView=[[LoginViewController alloc]init];
    loginView.ttag=@"me";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
    //    [self presentViewController:nav animated:YES completion:NULL]
    
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}
-(void)ChangeImage:(UITapGestureRecognizer*)sender{
    UIActionSheet*pic=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开照相机" otherButtonTitles:@"从手机相册中获取", nil];
    [pic showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController*ipc=[[UIImagePickerController alloc]init];
                [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
                ipc.delegate=self;
                ipc.allowsEditing=YES;
                [self presentViewController:ipc animated:YES completion:nil];
            }else{
                NSLog(@"no xiangji");
            }
        }
            break;
        case 1:{
            UIImagePickerController*ipc=[[UIImagePickerController alloc]init];
            [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            ipc.delegate=self;
            ipc.allowsEditing=YES;
            [self presentViewController:ipc animated:YES completion:nil];
        }
        default:
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* imagee=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSString*url=[[info objectForKey:UIImagePickerControllerReferenceURL]description];
    NSData*imageData=[[NSData alloc]init];
    if ([url hasSuffix:@"JPG"]) {
        imageData=UIImageJPEGRepresentation(imagee, 1);
    }else{
        imageData=UIImagePNGRepresentation(imagee);
    }
    UIImage* imaged=[UIImage imageWithData:imageData];
    image= [self scaleToSize:imaged size:CGSizeMake(36, 36)];
    _userInfoArea.icon.image=image;
    upimagedata=UIImagePNGRepresentation(image);
    NSLog(@"nizaima%@",_userInfoArea.icon.image);
    NSDictionary * _paramss = @{@"userCode":NET_ARG_AVANAME};
    
    [self  uploadPhoto:NET_API_SETAVATAR params:_paramss serviceName:@"imgFile" NotiName:@"uploadPhoto" imageD:upimagedata];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
///////////////////////
- (void)uploadPhoto:(NSString *)method params:(NSDictionary *)_params serviceName:(NSString *)name NotiName:(NSString *)nName imageD:(NSData *)imageData

{
    //  上传接口
    NSString * url = [NSString stringWithFormat:@"%@%@",@"http://app.teambuy.com.cn/apnc/m/",method];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //	//要上传的图片
    //	UIImage *image=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData *data = UIImagePNGRepresentation(self.image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [_params allKeys];
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"pic"])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[_params objectForKey:key]];
        }
    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"head.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:imageData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //设置接受response的data
    if (conn) {
        _mResponseData = [[NSMutableData alloc] init];
        
    }}
#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_mResponseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mResponseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"121212%@ 21%@",connection,_mResponseData);
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:_mResponseData options:kNilOptions error:nil];
    Headurl=[dic objectForKey:@"data"];
    NSLog(@"headurl%@",Headurl);
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

//////////////////
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


//-(UIImage *)getImageFromImage:(UIImage*) superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect {
//    //    CGSize subImageSize = CGSizeMake(WIDTH, HEIGHT); //定义裁剪的区域相对于原图片的位置
//    //    CGRect subImageRect = CGRectMake(START_X, START_Y, WIDTH, HEIGHT);
//    CGImageRef imageRef = superImage.CGImage;
//        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
//        UIGraphicsBeginImageContext(subImageSize);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//       CGContextDrawImage(context, subImageRect, subImageRef);
//        UIImage* returnImage = [UIImage imageWithCGImage:subImageRef];
//         UIGraphicsEndImageContext(); //返回裁剪的部分图像
//        return returnImage;
//    }

-(void)showmyorder:(SaleBarItem*)btn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
           alertShow(@"查看全部订单");
       // [self.navigationController pushViewController:[DisCountViewController new] animated:YES];
       }
}
-(void)showtotlemoney:(SaleBarItem*)sender{

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[DisCountViewController new] animated:YES];}
}
-(void)didTapMysuggest:(SaleBarItem*)btn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[MysuggestViewController new] animated:YES];

    }


}

-(void)didTapSettingBtn:(UIButton*)btn{
    
    SettingViewController *controller = [SettingViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)didTapUserInfo:(ZTIconButton*)button{
    [self.navigationController pushViewController:[PersonInfoViewController new] animated:YES];
}

-(void)didTapZTQBtn:(ZTIconButton*)button{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMQUAN] delegate:self cancelIfExist:YES ];
        [ZTCoverView alertCover];
        
    }}

-(void)didTapNoPayBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    
        NoPayViewController*vc=[[NoPayViewController alloc]init];
        vc.tagger=@"first";
        [self.navigationController pushViewController:vc animated:YES];}
}

-(void)didTapPayedBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }
    
    else{
        [self.navigationController pushViewController:[PayedViewController new] animated:YES];
    }}

-(void)didTapWaitForExpress{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    NoPayViewController*vc=[[NoPayViewController alloc]init];
    vc.tagger=@"second";
        [self.navigationController pushViewController:vc animated:YES];
    }}

-(void)didTapRevivceGood{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[RevivceGoodViewController new] animated:YES];
    }}

-(void)didTapMyComment{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        NoPayViewController*vc=[[NoPayViewController alloc]init];
        vc.tagger=@"third";
        [self.navigationController pushViewController:vc animated:YES];
    }}
-(void)didTapMyLogBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        alertShow(@"查看浏览记录");
        //[self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
    }
}
-(void)didTapMyCollectionShopBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    alertShow(@"查看收藏商家");
        //[self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
    }}
-(void)didTapMyCollectionBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
    }}

-(void)didTapMyAddressBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[MyAddressViewController new] animated:YES];
    }}

-(void)didTapMysuggest{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        NoPayViewController*vc=[[NoPayViewController alloc]init];
        vc.tagger=@"four";
        [self.navigationController pushViewController:vc animated:YES];
    }}

#pragma mark - helpers

-(void)initData{
    
     _titleNames= @[@"待付款",@"待收货",@"待评价",@"退换/售后"];
    /// ToDo: when array provide index is out of range ,return the last one by default.
    _iconNames = @[@"NoPay",@"WaitForGood",@"Waitvaluat",@"return"] ;
_CallBackbtn=@[@"didTapNoPayBtn",@"didTapWaitForExpress",@"didTapMyComment",@"didTapMysuggest"];
}

-(void)upDateDataIfNeed{
    
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETMYINFO] delegate:self cancelIfExist:YES];
    
    
}
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    
    //CollectShop.labelBottom.text = [nopay stringValue] ;
    //_ZTQuan.labelBottom.text = [NSString stringWithFormat:@"%@",tmquan];
    _userInfoArea.labelBottom.text =[NSString stringWithFormat:@"账户余额：%@团币",  tbmoney];
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
        DisCountViewController*vc=[DisCountViewController new];
        vc.QuanArr=dicountrr;
        //跳转优惠劵
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    alertShow(errmsg);
    [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
    }
    
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    
    
    NSLog(@"getinfo%@",result);
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
        NSLog(@"asasas%@",result);
        NSArray *discountes = [(NSArray*)result jsonParseToArrayWithType:[DisCountmodel class]];
        dicountrr=[NSMutableArray array];
        [dicountrr removeAllObjects];
        [dicountrr addObjectsFromArray:discountes];
        NSLog(@"%@",dicountrr);
        
    }
    else{
        nopay=[result objectForKey:@"nopay"];
        tmquan=[result objectForKey:@"tmquan"];
        tbmoney=[result objectForKey:@"tbmoney"];
    }
}
@end
