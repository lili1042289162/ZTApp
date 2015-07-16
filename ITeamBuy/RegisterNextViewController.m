//
//  RegisterNextViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/6/25.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "NearController.h"
#import "ZTInputBox.h"
#import "HomeTabBarController.h"
#import "ZTRoundButton.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "User.h"
#import "MeController.h"

@interface RegisterNextViewController()<NetResultProtocol>{
    UIView *_topLayout;
    ZTInputBox *_phoneInput;
    ZTInputBox *_paswInput;
    ZTInputBox *_repaswInput;
    ZTInputBox *_yzm;
    UIButton *_getYzmBtn;
    ZTRoundButton *_registerBtn;
    
}

@end

@implementation RegisterNextViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNavigationBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidLayoutSubviews{
   
    
        [[[[[_paswInput fitSize]
        setScreenWidth]
        setRectHeight:40.0]
        setRectBelowOfView:_topLayout]
        addRectY:1.5];
    
        [[[[[_repaswInput fitSize]
        setScreenWidth]
        setRectHeight:40.0]
        setRectBelowOfView:_paswInput]
        addRectY:1.5];
    
    
    [[[[[_registerBtn fitSize]
        setRectMarginLeft:15.0]
       widthToEndWithPadding:15.0]
      setRectBelowOfView:_repaswInput]
     addRectY:15.0];
}

#pragma mark - build Views

-(void)initNavigationBar{
    // TODO:learn about titleTextAttributes and move to global setting
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"注册"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    self.view.backgroundColor = [UIColor whiteColor];
    _topLayout = (UIView*)self.topLayoutGuide;
    // TODO: 去掉空格调整,实现两端对齐.
    // TODO: 套用 scrollview
    // TODO: 点击空域收起键盘
    
    /// password input box
    _paswInput = [ZTInputBox new];
    _paswInput.leftPadding = @15;
    _paswInput.rightPadding = @15;
    _paswInput.borderWidth = 0.5;
    _paswInput.bottomBorder = YES;
    _paswInput.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    _paswInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _paswInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_paswInput setTextLabel:@"密       码" withSeparator:@":"];
    
    /// repeat password input box
    _repaswInput = [ZTInputBox new];
    _repaswInput.leftPadding = @15;
    _repaswInput.rightPadding = @15;
    _repaswInput.borderWidth = 0.5;
    _repaswInput.bottomBorder = YES;
    _repaswInput.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    _repaswInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _repaswInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_repaswInput setTextLabel:@"重复密码" withSeparator:@":"];
    
    
    
    _registerBtn = [[ZTRoundButton alloc] initWithTitle:@"注册" textcolor:[UIColor whiteColor]
                                        backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_registerBtn addTarget:self action:@selector(didTapRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubViews:@[_paswInput,_repaswInput,_registerBtn]];
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - OnClick Events

-(void)didTapRegisterBtn:(UIButton*)btn{
NSLog(@"zhuce");
    [self resignInput];
    if ([_paswInput validate] && [_repaswInput validate]) {
//        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CHECKUSER] delegate:self cancelIfExist:YES];

 [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_REGISTER] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

#pragma mark - net result delegate
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    
        
     if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        [params addEntriesFromDictionary:@{
                                           NET_ARG_LOGIN_PHONE:self.username,
                                           NET_ARG_LOGIN_PASW:[self getPassword],
                                           NET_ARG_LOGIN_YZM:self.mobyzm,
                                           }];
    }
    }

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        NSDictionary *dataDic = (NSDictionary*)result;
        User *loginUser = [dataDic jsonParseWithType:[User class]];
        ZTDataCenter *dataCenter = [ZTDataCenter sharedInstance];
        [dataCenter loginUser:loginUser];
    }
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    alertShow(errmsg);
    [ZTCoverView dissmiss];
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
   
    
        
     if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        [ZTCoverView dissmiss];
        NSLog(@"zucecehnggong");
        if ([self.taggg isEqualToString:@"me"]) {
            //            [self.navigationController presentViewController:[MeController new] animated:YES completion:^{
            //                [self.navigationController popViewControllerAnimated:NO];
            //            }];
            
            
            [self .navigationController popToRootViewControllerAnimated:YES];
            //[self.navigationController pushViewController:[[MeController alloc]init] animated:YES];
        }
        if ([self.taggg isEqualToString:@"sale"]) {
            [self .navigationController popToRootViewControllerAnimated:YES];
        }
        
        alertShow(@"注册成功，请继续下一步操作");
    }
    
}

#pragma mark - helpers

-(NSString*)getPhone{
    NSString *phoneNumber = _phoneInput.textField.text;
    return [phoneNumber reverseString];
}

-(NSString*)getPassword{
    NSString *password = _paswInput.textField.text;
    return [password md5];
}

-(NSString*)getYzm{
    return _yzm.textField.text;
}

-(void)resignInput{
    NSArray *inputs = @[_paswInput,_repaswInput];
    for (ZTInputBox *input in inputs) {
        [input resignFirstResponder];
    }
}

@end
