//
//  CartDetailViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/6/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CartDetailViewController.h"
#import "ZTCoverView.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "orderInfo.h"
#import "CartdetailTableViewCell.h"
#import "OrderCpmcModel.h"
#import "ZTRoundButton.h"
#import "PurchaseViewController.h"
#import "Logistics.h"
#import "WlWebViewController.h"
#import "NoPayViewController.h"
#import "CommentViewController.h"
@interface CartDetailViewController ()<NetResultProtocol,UITableViewDelegate,UITableViewDataSource>{
ZTTitleLabel*_titleView;
UIView*topview;
ZTSessionView*topareaview;
ZTSessionView*underview;
UIView*totleview;
UITableView*CartTableView;
//view
UILabel*name;
UILabel*phonenum;
UILabel*address;
UILabel *  zhifuInfo;
UILabel * zhifuMenthod;
UILabel * zhifulx;
UILabel *  numberorder;
UILabel * TruePay;
UILabel * ordertime;
//data
NSMutableArray*Cartorderarr;
orderInfo*orderinfo;
NSMutableArray*_cpmxes;
NSString*city;
NSString*prvince;
NSMutableArray*wuliuarr;//物流单号
NSInteger selectwuliu;

NSString*son;
}

@end

@implementation CartDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initView];
    
}
-(void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden=YES;
[self initdata];
}

-(void)initdata{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
    
    [ZTCoverView alertCover];
}
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"订单详情"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}
-(void)initView{
topview=(UIView*)self.topLayoutGuide;
topareaview=[ZTSessionView new];
underview=[ZTSessionView new];
[self initTopAreaView];
[self initUnderView];
[self initFootView];
[self initCartTableView];
[self.view addSubViews:@[CartTableView,underview]];
self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
}
-(void)initTopAreaView{
name=[UILabel new];
[name setText:@"不吐槽不舒服斯基"];
[name  setFont:[UIFont systemFontOfSize:13.0]];
[name setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
phonenum=[UILabel new];
    [phonenum setText:@"15622785198"];
    [phonenum  setFont:[UIFont systemFontOfSize:13.0]];
    [phonenum setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
address=[UILabel new];
    [address setText:@"广东省广州市天河区广东省广州市天河区黄埔大道西39号瑞达大厦17A"];
    [address  setFont:[UIFont systemFontOfSize:13.0]];
    [address setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
[topareaview addSubViews:@[name,phonenum,address]];
[[[name fitSize]setRectMarginLeft:15.0]setRectMarginTop:7.5];
    [[[[[phonenum fitSize]setRectMarginLeft:15.0]setRectOnRightSideOfView:name]addRectX:3]setRectMarginTop:7.5];
[[[[address fitSize]setRectMarginLeft:15.0]setRectBelowOfView:name]addRectY:7.0];

  [[[topareaview wrapContents] addRectHeight:20.0] setBackgroundColor:[UIColor clearColor]];
}
-(void)initUnderView{
ZTRoundButton*delte=[ZTRoundButton new];
    [delte addTarget:self action:@selector(didTapDelteButnn:) forControlEvents:UIControlEventTouchUpInside];
    delte.layer.cornerRadius=5.0;
    
ZTRoundButton*GoToPay=[ZTRoundButton new];
       [GoToPay addTarget:self action:@selector(didTapPayButnn:) forControlEvents:UIControlEventTouchUpInside];
    GoToPay.layer.cornerRadius=5.0;
  
    if ([self.ttager isEqualToString:@"first"]) {
         [delte setImage:[UIImage imageNamed:@"qxorder"] forState:UIControlStateNormal];
         [GoToPay setImage:[UIImage imageNamed:@"ggotopay"] forState:UIControlStateNormal];
    }else{
        //[delte setImage:[UIImage imageNamed:@"qxorder"] forState:UIControlStateNormal];
        //[GoToPay setImage:[UIImage imageNamed:@"ggotopay"] forState:UIControlStateNormal];

    }

    [underview addSubViews:@[delte,GoToPay]];
    [[[[delte setRectWidth:40]setRectHeight:22]setRectMarginTop:3.0]setRectMarginLeft:200.0];
   [[[[[GoToPay setRectWidth:40]setRectHeight:22]setRectOnRightSideOfView:delte]addRectX:20]  setRectMarginTop:3.0];
   
  // [underview.subviews[0] setBackgroundColor:[UIColor grayColor]];

}
-(void)initCartTableView{
CartTableView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
CartTableView.showsHorizontalScrollIndicator=NO;
CartTableView.showsVerticalScrollIndicator=NO;
CartTableView.delegate=self;
CartTableView.dataSource=self;
CartTableView.backgroundColor=[UIColor clearColor];
CartTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
[CartTableView registerClass:[CartdetailTableViewCell class] forCellReuseIdentifier:@"cell"];
CartTableView.tableHeaderView = topareaview;
CartTableView.tableFooterView=totleview;
}
-(void)initFootView{

    ZTSessionView*PayInfo=[[ZTSessionView alloc]init];
    PayInfo.borderWidth=10.0;
    PayInfo.bottomBorder=YES;
    PayInfo.backgroundColor=[UIColor whiteColor];
    zhifuInfo=[UILabel new];
    zhifuMenthod=[UILabel new];
    zhifulx=[UILabel new];
    [PayInfo addSubViews:@[zhifuInfo,zhifuMenthod,zhifulx]];
    
    NSArray*arr=@[zhifuInfo,zhifuMenthod,zhifulx];
    for (UILabel*label in arr) {
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
    }
    zhifuInfo.text=@"支付信息";
    zhifuInfo.textColor=[UIColor redColor];
    zhifuMenthod.text=[NSString stringWithFormat:@"支付方式：%@",@"在线支付"];
    zhifulx.text=[NSString stringWithFormat:@"支付类型：%@",@"支付宝支付"];
    
    [[[zhifuInfo fitSize]setRectMarginTop:10.0]setRectMarginLeft:15];
    [[[[zhifuMenthod fitSize]setRectMarginLeft:15]setRectBelowOfView:zhifuInfo]addRectY:6.0];
    [[[[zhifulx fitSize]setRectBelowOfView:zhifuMenthod]setRectMarginLeft:15]addRectY:6.0];
    [[PayInfo setRectHeight:80]setScreenWidth];
    
    
    ZTSessionView *view=[[ZTSessionView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    numberorder=[UILabel new];
    TruePay=[UILabel new];
    ordertime=[UILabel new];
    [view addSubViews:@[numberorder,TruePay,ordertime]];
    
    NSArray*arry=@[numberorder,TruePay,ordertime];
    for (UILabel*label in arry) {
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
    }
    
    numberorder.text=[NSString stringWithFormat:@"订单编号：%@",@"8888888888888"];
    TruePay.text=[NSString stringWithFormat:@"实际付款金额：%@",@"8888888888888"];
    ordertime.text=[NSString stringWithFormat:@"下单日期：%@",@"8888888888888888888888"];
    
    [[[numberorder fitSize]setRectMarginTop:10.0] setRectMarginLeft:15];
    [[[[TruePay fitSize]setRectMarginLeft:15]setRectBelowOfView:numberorder]addRectY:6.0];
    [[[[ordertime fitSize]setRectBelowOfView:TruePay]setRectMarginLeft:15]addRectY:6.0];
    
    [[[view setRectHeight:80]setScreenWidth]setRectBelowOfView:PayInfo];
    
    
   totleview=[[UIView alloc]init];
    totleview.backgroundColor=[UIColor whiteColor];
    [totleview addSubViews:@[PayInfo,view]];
    
    [[totleview setRectHeight:180]setScreenWidth];


}


-(void)viewDidLayoutSubviews{

[[[underview setRectHeight:26]setScreenWidth]setRectMarginBottom:0.0];


}

-(void)didTapPayButnn:(ZTRoundButton*)btn
{
    PurchaseViewController*pvc=[[PurchaseViewController alloc]init];
    pvc.info=orderinfo;
    pvc.tag=@"zhifu";
    [self.navigationController pushViewController:pvc animated:YES];


}
-(void)didTapDelteButnn:(ZTRoundButton*)sender{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_ORDCANCEL] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];

}
#pragma dalegata

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
NSLog(@"01212121%lu",(unsigned long)_cpmxes.count);
return _cpmxes.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartdetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    long row=[indexPath row];
    OrderCpmcModel *cpmxmodel=_cpmxes[row];
    NSLog(@"aaacart%@",cpmxmodel);
    [cell.ShopCartPic setImageFromUrl:cpmxmodel.cppic];
   cell.Producttitle.text=cpmxmodel.cpmc;
   cell.price.text=[NSString stringWithFormat:@"%@",cpmxmodel.oje];
  cell.sl.text=[NSString stringWithFormat:@"x%@",cpmxmodel.osl];
    cell.Topborder=YES;
    cell.BottomBorder=YES;
    cell.BorderWidth=3.0;
    NSLog(@"lasasas%@",self.ttager);
    if ([self.ttager isEqualToString:@"second"]) {
        if([orderinfo.cpmcnum integerValue]>1 )
        {NSLog(@"gouwuchea");
            cell.detailmodell=DetailCartModel;
            cell.detailpayactionBlock=^{
            
             UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil, nil];
            son=cpmxmodel.ordnox;
              [deleaddress show];
           
            };
            cell.detailshowactionBlock=^{
             [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX] delegate:self cancelIfExist:YES];
            selectwuliu=(NSInteger)row;
           // alertShow(@"显示物流");
            };
        }else{
            NSLog(@"dangechangping");
            cell.detailmodell=DetailPayNowModel;
        }

    }else if ([self.ttager isEqualToString:@"third"]) {
        cell.detailmodell=DetailPayNowModel;
        cell.ttarger=self.ttager;
        cell.detailpayactionBlock=^{
       CommentViewController*vc=[[CommentViewController alloc]init];
       vc.father=self.cartorderdetail;
       vc.value=cpmxmodel;
       [self.navigationController pushViewController:vc animated:YES];
       
        };
      
    }
    
    
    else{
        cell.detailmodell=DetailPayNowModel;

    }
    

    
    return cell;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
            
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS] delegate:self cancelIfExist:YES];
            
            break;
            
        default:
            NSLog(@"取消1");
            break;
    }
}

#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
name.text=[NSString stringWithFormat:@"%@",orderinfo.truename];
phonenum.text=[NSString stringWithFormat:@"%@",orderinfo.tel];
address.text=[NSString stringWithFormat:@"%@-%@-%@",prvince,city, orderinfo.address];

    zhifuInfo.text=@"支付信息";
    zhifuInfo.textColor=[UIColor redColor];
    zhifuMenthod.text=[NSString stringWithFormat:@"支付方式：%@",@"在线支付"];
    zhifulx.text=[NSString stringWithFormat:@"支付类型：%@",orderinfo.paym];
    numberorder.text=[NSString stringWithFormat:@"订单编号：%@",orderinfo.ordno];
    TruePay.text=[NSString stringWithFormat:@"实际付款金额：￥%@",orderinfo.ordje];
    ordertime.text=[NSString stringWithFormat:@"下单日期：%@",orderinfo.dateandtime];

[CartTableView reloadData];

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDCANCEL]])
    {
    NSLog(@"sahnchullll");
    //alertShow(@"订单已删除成功");
    [self.navigationController popViewControllerAnimated:YES];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]){
    
        WlWebViewController*wuliu=[[WlWebViewController alloc]init];
        wuliu.UrlString = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/tmlog/id/%@",wuliuarr[selectwuliu]];
        NSLog(@"awuliu%@",wuliuarr[selectwuliu]);
        [self.navigationController pushViewController:wuliu animated:YES];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]])
    {
        NSLog(@"去评价界面");
        NoPayViewController*pingjia=[NoPayViewController new];
        pingjia.tagger=@"third";
        [self.navigationController pushViewController:pingjia animated:YES];
    }
    [ZTCoverView dissmiss];
}


-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
[CartTableView reloadData];
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
    
        [params addEntriesFromDictionary:@{ NET_ARG_DETAIL_ORDNO:[NSString stringWithFormat:@"%@",self.cartorderdetail]}];
        }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDCANCEL]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDCANCEL_ORDNO:[NSString stringWithFormat:@"%@",self.cartorderdetail],
                                           }];
    }if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]) {
        [params addEntriesFromDictionary:@{ NET_ARG_DETAIL_ORDNO_MX:[NSString stringWithFormat:@"%@",self.cartorderdetail]}];
    } if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]])
    {
        [params addEntriesFromDictionary:@{NET_ARG_ORDNO_ORDRECGOODS:[NSString stringWithFormat:@"%@",self.cartorderdetail],
                                           NET_ARG_ORDNO_ORDRECGOODS_ONOX:[NSString stringWithFormat:@"%@",son],
                                           }];}

    
    
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]){
NSLog(@"cartresult%@",result);
NSArray*cartarr=[(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
orderinfo=[orderInfo new];
        for (orderInfo*temporderinfo in cartarr) {
            NSArray*cpmxs=[(NSArray*)temporderinfo.cpmx jsonParseToArrayWithType:[OrderCpmcModel class]];
            _cpmxes=[NSMutableArray array];
            [_cpmxes removeAllObjects];
            [_cpmxes addObjectsFromArray:cpmxs];
            temporderinfo.cpmcnum=[NSNumber numberWithInteger:_cpmxes.count];
            NSLog(@"%@asdqld",temporderinfo.cpmcnum);
            orderinfo=temporderinfo;
        }
        
NSLog(@"turename%@",orderinfo.address);

 city=[[ZTDataCenter sharedInstance]getCityNameByCid:[orderinfo.city integerValue]];
 prvince= [[ZTDataCenter sharedInstance]getProvinceNameByPid:[orderinfo.province integerValue]];

    NSArray*cpmxs=[(NSArray*)orderinfo.cpmx jsonParseToArrayWithType:[OrderCpmcModel class]];
    NSLog(@"cpmxs%@ ",cpmxs);
    _cpmxes=[NSMutableArray array];
    [_cpmxes removeAllObjects];
    [_cpmxes addObjectsFromArray:cpmxs];
    
        NSLog(@"cpnx%@",_cpmxes);}
    
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]){
        NSLog(@"chird%@",result);
        NSArray *arr= [(NSArray*)result jsonParseToArrayWithType:[Logistics class]];
        wuliuarr=[NSMutableArray array];
        for (Logistics *wuliu in arr) {
            [wuliuarr addObject:wuliu.logid];
                  }
    NSLog(@"wuliueeeaa%@",result);
    
    }
}

@end
