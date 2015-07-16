//
//  PayViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "PurchaseViewController.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "ZTSessionTitle.h"
#import "PaySelectedCell.h"
#import "ZTRoundButton.h"
#import "Pingpp.h"
#import "NoPayViewController.h"
#import "PayedViewController.h"
#import "PayedViewController.h"
#import "MeController.h"
#import "HomeTabBarController.h"
#import "ZTTextContentView.h"
#import "ZTCoverView.h"
#import "orderInfo.h"
@interface PurchaseViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
//    ZTSessionView* _topBanner;
    ZTTitleLabel* _titleView;
//    
//    ZTSessionTitle* _productTitleBar;
//    
//    
//    ZTSessionView* _productPriceBar;
//    UILabel* _priceTitle;
//    UILabel* _price;
//    
//    
//    ZTSessionView* _productPaymentBar;
//    UILabel* _paymentTitle;
//    UILabel* _payment;
    
    ZTSessionTitle* _paySelectedTitle;
    UITableView* _payMethodSelected;
    
    ZTSessionView* _payBar;
    ZTRoundButton* _payButton;
    
    UIView*topview;
    ZTTextContentView*view;
    // attributes
    NSArray* _payIconName;
    NSArray* _payToolName;
    NSArray* _payToolDes;
    NSArray* _ordnoInfo;
}

@end


@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payway=@"";
    [self initData];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
    
    /// test
   
    if ([self.tag isEqualToString:@"zhifu"]) {
//            _productTitleBar.text= self.info.fcpmc;
//       _price.text =[self.info.ordsl stringValue];
//      _payment.text = [self.info.ordje stringValue];

    }
    else{

//    _productTitleBar.text = self.payproduct.title;
//    _price.text = self.payproduct.dj0;
//        _payment.text = [self.paymoney stringValue];;
}
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationaction:) name:@"jumppage" object:nil];
}
-(void)notificationaction:(NSNotification*)noti
{
  NSString*where=[noti.userInfo objectForKey:@"where"];
    if (![where isEqualToString:@"success"]) {
    NSLog(@"weifukuan");
        NoPayViewController*NOPayViewController=[[NoPayViewController alloc]init];
        [self.navigationController pushViewController:NOPayViewController animated:YES];
    }
    else{
    
    NSLog(@"yifukuan");
    PayedViewController*payedviewcontroller=[[PayedViewController alloc]init];
    [self.navigationController pushViewController:payedviewcontroller animated:YES];
    
    }

}

#pragma mark build views
-(void)buildViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"支付收银台"];
    topview=(UIView*)self.topLayoutGuide;
       view=[ZTTextContentView new];
    
    if ([self.tag isEqualToString:@"zhifu"]) {
    
        //view.text=[NSString stringWithFormat:@"            共计：￥ %@\n    订单已提交，请尽快支付\n也可稍后去未完成订单中支付",[self.info.ordje stringValue]];
    }
    else{
      // view.text=[NSString stringWithFormat:@"            共计：￥ %@\n    订单已提交，请尽快支付\n也可稍后去未完成订单中支付",self.paymoney];
    }
    
    view.textContainerInset=UIEdgeInsetsMake(20, 60.0, 0, 30.0);
    view.editable=NO;
    view.scrollEnabled=NO;
    view.font=[UIFont systemFontOfSize:12.0];
    view.textColor=[UIColor colorWithHex:0x656565];
    view.topBorder=YES;
    view.bottomBorder=YES;
    view.borderWidth=0.5;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    _paySelectedTitle = [[ZTSessionTitle alloc] initWithTitle:@"选择支付方式"];
    _paySelectedTitle.topBorder = YES;
    _paySelectedTitle.bottomBorder = YES;
    _paySelectedTitle.borderWidth = 1.0;
    _paySelectedTitle.font = [UIFont systemFontOfSize:14.0];
    _paySelectedTitle.textColor = [UIColor colorWithHex:0x323232];
    _paySelectedTitle.titleInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 0);
    _paySelectedTitle.backgroundColor = [UIColor whiteColor];
    
    _payMethodSelected = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_payMethodSelected registerClass:[PaySelectedCell class] forCellReuseIdentifier:@"cell"];
    _payMethodSelected.dataSource = self;
    _payMethodSelected.delegate = self;
    _payMethodSelected.bounces = NO;
    _payMethodSelected.separatorStyle = UITableViewCellSeparatorStyleNone;
    _payMethodSelected.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    
    _payBar = [ZTSessionView new];
    _payBar.topBorder = YES;
    _payBar.backgroundColor = [UIColor whiteColor];
    
    _payButton = [[ZTRoundButton alloc] initWithTitle:@"确定支付" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_buy"]];
    [_payButton addTarget:self action:@selector(didTapConformToPay:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView fitSize];
    self.navigationItem.titleView=_titleView;
    [_payBar addSubview:_payButton];
    [self.view addSubViews:@[view,_paySelectedTitle,_payMethodSelected,_payBar]];
  }

-(void)viewDidLayoutSubviews{
    
    [[[[[view fitSize]setScreenWidth]setRectBelowOfView:topview]addRectY:7.0]setRectHeight:80.0];
    
    [[[[_paySelectedTitle setScreenWidth] setRectHeight:40.0] setRectBelowOfView:view] addRectY:10.0];
    [[[_payMethodSelected heightToEndWithPadding:0.0] setScreenWidth] setRectBelowOfView:_paySelectedTitle];
    [[[_payBar setScreenWidth] setRectHeight:50.0] setRectMarginBottom:0.0];
    //两边均分30
    [[[[_payButton fitSize] setRectMarginLeft:30.0] widthToEndWithPadding:30.0] setRectCenterVertical];
}



#pragma mark tableview methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 每个session返回cell数量
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

/**
 返回cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaySelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    cell.icon.image = [UIImage imageNamed:_payIconName[row]];
    cell.payToolName.text = _payToolName[row];
    cell.payToolDescription.text = _payToolDes[row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

/**
 cell 点击事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
         NSInteger payyway=[indexPath row];
    if (payyway==0) {
        self.payway=@"alipay";
    }
    else if(payyway==1)
    {
    self.payway=@"upmp";
    }
    else
    {self.payway=@"wx";
    }
   
    PaySelectedCell *cell = (PaySelectedCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.checkBox setSelected:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaySelectedCell *cell = (PaySelectedCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.checkBox setSelected:NO];
}

#pragma mark - on Click methods

-(void)didTapConformToPay:(UIButton*)btn{
    if ([self.payway isEqualToString:@""]) {
    //这个判断有问题
        alertShow(@"选择支付方式");
    }
     NSLog(@"%@ingdan@",self.info.ordno);
   [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_CREATEPAY] delegate:self cancelIfExist:YES ];

[ZTCoverView alertCover];

}

#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
     NSArray *shopcar = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
        NSLog(@"cacaca%@",result);
       
    orderInfo*order=shopcar[0];
    self.Purchasestbmoney=order.utbmoney;
    self.Purchasetmqje=order.tmqje;
       self.paymoney=order.ordje;
        if (![self.Purchasetmqje isEqualToString:@"0.00"]&&![self.Purchasestbmoney isEqualToString:@"0"]) {
            
             view.text=[NSString stringWithFormat:@"            共计：￥ %@\n使用优惠劵%@，使用团币%@，\n 订单已提交，请尽快支付\n也可稍后去未完成订单中支付",self.paymoney,self.Purchasetmqje,self.Purchasestbmoney];
               
            
            
        }
        else if (![self.Purchasestbmoney isEqualToString:@"0"]) {
       
             view.text=[NSString stringWithFormat:@"            共计：￥ %@\n             使用团币%@\n 订单已提交，请尽快支付\n也可稍后去未完成订单中支付",self.paymoney,self.Purchasestbmoney];
        
            
        } else if (![self.Purchasetmqje isEqualToString:@"0.00"]) {
        
            
                 view.text=[NSString stringWithFormat:@"            共计：￥ %@\n         使用优惠劵%@\n 订单已提交，请尽快支付\n也可稍后去未完成订单中支付",self.paymoney,self.Purchasetmqje];
            

            
        }else{
        
           
                view.text=[NSString stringWithFormat:@"            共计：￥ %@\n    订单已提交，请尽快支付\n也可稍后去未完成订单中支付",self.paymoney];
            

            }
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_CREATEPAY]]) {
NSDictionary*dic=[result objectForKey:@"charge"];
NSData*json=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];

 NSString* charge = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
// NSLog(@"oblc%@",charge);
PurchaseViewController * __weak weakSelf = self;

dispatch_async(dispatch_get_main_queue(), ^{
    [Pingpp createPayment:charge viewController:weakSelf appURLScheme:@"wx1872d077ceee2249" withCompletion:^(NSString *result, PingppError *error) {
        NSLog(@"completion block: %@", result);
        if ([result isEqualToString:@"success"]) {
            NSString*message=@"支付完成!继续购物";
            
            UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [deleaddress show];
          self.controller = [[HomeTabBarController alloc]init];
        }
        else{
        if (error == nil) {
            NSLog(@"PingppError is nil");
            
        } else {
            NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
        NoPayViewController *NOPayViewController=[[NoPayViewController alloc]init];
        [self.navigationController pushViewController:NOPayViewController animated:YES];
              }}

    }];
});}
[ZTCoverView dissmiss];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self.navigationController presentViewController:self.controller animated:YES completion:nil];
        break;
        default:
            NSLog(@"取消1");
            break;
    }
}

-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params
{

if ([request isEqualToString:[NSString stringURLWithAppendex:NET_CREATEPAY]])
{     if([self.tag isEqualToString:@"zhifu"])
{ [params addEntriesFromDictionary:@{NET_ARG_ORDNO:self.info.ordno,
                                     NET_ARG_PAYM: self.payway, }];
}else {
  
    [params addEntriesFromDictionary:@{NET_ARG_ORDNO:self.ordno,
                                    NET_ARG_PAYM: self.payway, }];
}
}
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]])
    {   if([self.tag isEqualToString:@"zhifu"])
        { [params addEntriesFromDictionary:@{NET_ARG_DETAIL_ORDNO:self.info.ordno,
                                        }];
        }else {
            
            [params addEntriesFromDictionary:@{NET_ARG_DETAIL_ORDNO:self.ordno,
                                               }];
        }

        
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]) {
        NSLog(@"cacaca%@",result);
    }
}

#pragma mark - helpers

-(void)initData{
    _payIconName = @[@"zhifu",@"yinlian",@"weixin"];
    _payToolName = @[@"支付宝支付",@"银联支付",@"微信支付"];
    _payToolDes = @[@"推荐有支付宝账号的用户使用",@"各大银行无卡支付,快捷支付",@"推荐安装最新版本微信客户端用户使用"];

 
}
 @end
