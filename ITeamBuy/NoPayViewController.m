
//  NoPayViewController.m
//  ZhongTuan
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
#import "NoPayViewController.h"
#import "ZTTitleLabel.h"
#import "NoPayCell.h"
#import "ZTIconButton.h"
#import "ZTCoverView.h"
#import "orderInfo.h"
#import "DetailOrderviewcontroller.h"
#import "PurchaseViewController.h"
#import "OrderCpmcModel.h"
#import "CartDetailViewController.h"
#import "WlWebViewController.h"
#import "Logistics.h"

@interface NoPayViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
UIView *_topLayout;
    ZTTitleLabel*_belowtitleview;
    ZTTitleLabel* _titleView;
    UITableView *_nopayListView;
    //choice temai nopay
    ZTIconButton *_TMnoapyBtn;
    ZTIconButton *_tuangouBtn;
    //tableview headview
    UIView *_headerView;
    //nopaylist
     NSMutableArray *nopaylist;
     //data
     NSMutableArray *_orderarr;
     NSMutableArray*_cpmxes;
      NSString* dingdan;//订单号
      NSString*Chirdorder;//查询物流订单号
      NSNumber*wuliudanhao;//物流单号
    
      NSString *ordernoxm;//子订单号
}
@end

@implementation NoPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initData];
    [self initTitleBar];
    [self initViews];
}
-(void)viewWillAppear:(BOOL)animated{
NSLog(@"yisdsdsdd");
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self initData];
    }
-(void)initData{
    if ([self.tagger isEqualToString:@"first"]) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }else if([self.tagger isEqualToString:@"second"]){
    NSLog(@"ooooooo");
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }else if([self.tagger isEqualToString:@"third"]){
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }else if([self.tagger isEqualToString:@"four"]){
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
    
    else{
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];}
}
-(void)initTitleBar{
    if ([self.tagger isEqualToString:@"first"]) {
        _titleView = [[ZTTitleLabel alloc] initWithTitle:@"待支付"];
        [_titleView fitSize];
        self.navigationItem.titleView = _titleView;
    }
    else if([self.tagger isEqualToString:@"second"])
    { _titleView = [[ZTTitleLabel alloc] initWithTitle:@"待收货"];
        [_titleView fitSize];
        self.navigationItem.titleView = _titleView;
    } else if([self.tagger isEqualToString:@"third"])
    { _titleView = [[ZTTitleLabel alloc] initWithTitle:@"待评价"];
        [_titleView fitSize];
        self.navigationItem.titleView = _titleView;
    }else if([self.tagger isEqualToString:@"four"])
    { _titleView = [[ZTTitleLabel alloc] initWithTitle:@"退换/售后"];
        [_titleView fitSize];
        self.navigationItem.titleView = _titleView;
    }
    else{
        _titleView = [[ZTTitleLabel alloc] initWithTitle:@"待支付"];
        [_titleView fitSize];
        self.navigationItem.titleView = _titleView;
        }
    }
-(void)initViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    self.navigationItem.titleView = _titleView;
    [self initTableView];
    [self.view addSubview:_nopayListView];
}
-(void)initTableView{
    _nopayListView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _nopayListView.showsHorizontalScrollIndicator = NO;
    _nopayListView.showsVerticalScrollIndicator = NO;
    _nopayListView.delegate = self;
    _nopayListView.dataSource = self;
    _nopayListView.backgroundColor = [UIColor clearColor];
   // _nopayListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_nopayListView registerClass:[NoPayCell class] forCellReuseIdentifier:@"cell"];
}

-(void)viewDidLayoutSubviews{

//_nopayListView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
   // [[[self.topview setScreenWidth] setRectHeight:30.0] setRectBelowOfView:_topLayout];

    //[[[_nopayListView setScreenWidth] setRectBelowOfView:self.topview] heightToEndWithPadding:0.0];
}

#pragma mark - tableview Delegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
NoPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    long row=[indexPath row];
    NSLog(@"%ldcaonimald",row);
         orderInfo *order = _orderarr[row];
 NoPayCell __weak *safecell=cell;
   cell.Ordernum.text=[NSString stringWithFormat:@"订单号：%@", order.ordno];
   cell.TurePay.text=[NSString stringWithFormat:@"实际付款￥%@",order.ordje];
    cell.borderWidth=5.0;
    cell.topBorder=YES;
    cell.bottomBorder=YES;
    if([order.cpmcnum integerValue]>1 ){
        NSLog(@"laizigouwuche");
        cell.modell=CartModel;
    NSMutableArray*pices=[NSMutableArray array];
        for (int i=0; i<[order.cpmcnum integerValue]; i++) {
            NSArray*cpmxs=[(NSArray*)order.cpmx jsonParseToArrayWithType:[OrderCpmcModel class]];
           NSMutableArray *cpxq=[NSMutableArray array];
            [cpxq removeAllObjects];
            [cpxq addObjectsFromArray:cpmxs];
            OrderCpmcModel*pic=cpxq[i];
            [pices addObject:pic.cppic];
                   }
        
        if(pices.count==2) {
            [cell.toppicone setImageFromUrl:pices[0]];
            [cell.toppictwo setImageFromUrl:pices[1]];
        }else if(pices.count==3){
        [cell.toppicone setImageFromUrl:pices[0]];
        [cell.toppictwo setImageFromUrl:pices[1]];
        [cell.toppicthird setImageFromUrl:pices[2]];}
        else{
            [cell.toppicone setImageFromUrl:pices[0]];
            [cell.toppictwo setImageFromUrl:pices[1]];
            [cell.toppicthird setImageFromUrl:pices[2]];
            [cell.toppicfour setImageFromUrl:pices[3]];
        }
        cell.payactionBlock=^{
//            PurchaseViewController*pvc=[[PurchaseViewController alloc]init];
//            pvc.info=_orderarr[row];
//            pvc.tag=@"zhifu";
//            [self.navigationController pushViewController:pvc animated:YES];
alertShow(@"暂时不支持售后服务");
        };

    }
    else{
        NSLog(@"laizilijigoumai");
       // long row=[indexPath row];
        cell.modell=PayNowModel;
        NSLog(@"yige");
        cell.indicatorRightPadding = 15.0;
        [cell.pic setImageFromUrl:order.fcppic];
        cell.title.text=order.fcpmc;
        cell.totolprice.text=[order.ordje stringValue];
        cell.quantity.text=[order.ordsl stringValue];
        
        cell.payactionBlock=^{
//            PurchaseViewController*pvc=[[PurchaseViewController alloc]init];
//            pvc.info=_orderarr[row];
//            pvc.tag=@"zhifu";
//            [self.navigationController pushViewController:pvc animated:YES];
alertShow(@"暂时不支持售后服务");
        };
}
    int ordstaue=[order.ordzt intValue];
    if (ordstaue==0) {
        cell.statue.text=[NSString stringWithFormat:@"状态：%@",@"待支付"];
        cell.tagg=@"first";
                cell.payactionBlock=^{
                    PurchaseViewController*pvc=[[PurchaseViewController alloc]init];
                    pvc.info=_orderarr[row];
                    pvc.tag=@"zhifu";
                    [self.navigationController pushViewController:pvc animated:YES];
                };

    }
    else if (ordstaue==1){
        cell.statue.text=[NSString stringWithFormat:@"状态：%@",@"已支付"];
    }
    else if (ordstaue==2){
        cell.statue.text=[NSString stringWithFormat:@"状态：%@",@"已收货/待评价"];
    }
    else if(ordstaue==4){
        cell.statue.text=[NSString stringWithFormat:@"状态：%@",@"已发货"];
        if ([self.tagger isEqualToString:@"second"]) {
            cell.tagg=@"two";
            cell.showactionBlock = ^{
                //这里有bug会循环引用
                if ( cell.modell==PayNowModel) {
                    NSLog(@"查看物流");
                    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX] delegate:self cancelIfExist:YES];
                    Chirdorder=order.ordno;
                }
                else{
                    CartDetailViewController *con = [CartDetailViewController new];
                    orderInfo*orderinfo =_orderarr[row];
                    con.cartorderdetail=orderinfo.ordno;
                    con.ttager=self.tagger;
                    NSLog(@"dingdanhaoma%@",orderinfo.ordno);
                    [self.navigationController pushViewController:con animated:YES];}};
            
                      cell.payactionBlock = ^{
                if (cell.modell==PayNowModel) {
                    NSLog(@"确认收货");
                    UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil, nil];
                    dingdan=order.ordno;
                    
                    NSArray*cpmxs=[(NSArray*)order.cpmx jsonParseToArrayWithType:[OrderCpmcModel class]];
                   OrderCpmcModel*model =cpmxs[0];
                 ordernoxm=model.ordnox;
                    
                    [deleaddress show];
                }
                else{
                    CartDetailViewController *con = [CartDetailViewController new];
                    orderInfo*orderinfo =_orderarr[row];
                    con.cartorderdetail=orderinfo.ordno;
                    con.ttager=self.tagger;
                    NSLog(@"dingdanhaoma%@",orderinfo.ordno);
                    [self.navigationController pushViewController:con animated:YES];
                
                }
           };
        }else{
        
        }
        
    }else if (ordstaue==6){
     cell.tagg=@"second";
    // cell.statue.text=[NSString stringWithFormat:@"状态：%@",@"已发货"];
    }
    if ([self.tagger isEqualToString:@"third"]) {
    cell.tagg=@"third";
        cell.payactionBlock=^{
        
            long row=[indexPath row];
            CartDetailViewController *con = [CartDetailViewController new];
            orderInfo*orderinfo =_orderarr[row];
            con.cartorderdetail=orderinfo.ordno;
            con.ttager=self.tagger;
            NSLog(@"dingdanhaoma%@",orderinfo.ordno);
            [self.navigationController pushViewController:con animated:YES];
            //alertShow(@"去评价");
        };
    }
return  cell;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderarr.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//long row=[indexPath row];
//    orderInfo *order = _orderarr[row];
//    if([order.cpmcnum integerValue]>1 ){
//    NSLog(@"laizigouwuche");
        long row=[indexPath row];
        CartDetailViewController *con = [CartDetailViewController new];
        orderInfo*orderinfo =_orderarr[row];
        con.cartorderdetail=orderinfo.ordno;
        con.ttager=self.tagger;
        NSLog(@"dingdanhaoma%@",orderinfo.ordno);
        [self.navigationController pushViewController:con animated:YES];
   // }
//    else{
//    NSLog(@"laizilijigoumai");
//    long row=[indexPath row];
//    DetailOrderviewcontroller *con = [DetailOrderviewcontroller new];
//    orderInfo*orderinfo =_orderarr[row];
//    con.oederdetail=orderinfo.ordno;
//        [self.navigationController pushViewController:con animated:YES];}
}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result
{ if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]])
    {
    NSLog(@"去评价界面");
    NoPayViewController*pingjia=[NoPayViewController new];
    pingjia.tagger=@"third";
    [self.navigationController pushViewController:pingjia animated:YES];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]) {
        
        WlWebViewController*wuliu=[[WlWebViewController alloc]init];
        
        wuliu.UrlString = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/tmlog/id/%@",wuliudanhao];
        [self.navigationController pushViewController:wuliu animated:YES];
    }
    
    else{
    [ZTCoverView dissmiss];
        [_nopayListView reloadData];
        }
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
[_nopayListView reloadData];
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([self.tagger isEqualToString:@"first"]) {
        if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
            [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[NSNumber numberWithInt:0]}];
        }}
else if([self.tagger isEqualToString:@"second"])
{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[self getorderstatue]}];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]])
    {
        [params addEntriesFromDictionary:@{NET_ARG_ORDNO_ORDRECGOODS:[NSString stringWithFormat:@"%@",dingdan],
                                           NET_ARG_ORDNO_ORDRECGOODS_ONOX:[NSString stringWithFormat:@"%@",ordernoxm],
                                           }];}
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]){
        [params addEntriesFromDictionary:@{NET_ARG_DETAIL_ORDNO_MX:[NSString stringWithFormat:@"%@",Chirdorder],
                                           }];}
    

    }
else if([self.tagger isEqualToString:@"third"])
{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[NSNumber numberWithInt:2]}];
    }}
else if([self.tagger isEqualToString:@"four"])
{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[self getreturnnum]}];
    }}
    
else{
    [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[NSNumber numberWithInt:0]}];}
 
}
    

-(NSString*)getorderstatue{

return @"1,4";
}
-(NSString*)getreturnnum{

return @"1,2,4,6";
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        NSLog(@"aaaaaaresult%@result",result);
        
        NSArray *orderes = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
        _orderarr=[NSMutableArray array];
        [_orderarr removeAllObjects];
        [_orderarr addObjectsFromArray:orderes];
      
      
        for (orderInfo*orderinfo in _orderarr) {
        NSLog(@"-----%@",orderinfo.cpmx);
            NSArray*cpmxs=[(NSArray*)orderinfo.cpmx jsonParseToArrayWithType:[OrderCpmcModel class]];
            _cpmxes=[NSMutableArray array];
            [_cpmxes removeAllObjects];
            [_cpmxes addObjectsFromArray:cpmxs];
            orderinfo.cpmcnum=[NSNumber numberWithInteger:_cpmxes.count];
            
        }
        
        NSLog(@"%ld------%@------%@------%ld",_orderarr.count,_orderarr,_cpmxes,_cpmxes.count);

    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD_MX]]) {
    NSLog(@"chird%@",result);
        NSArray *arr= [(NSArray*)result jsonParseToArrayWithType:[Logistics class]];
Logistics*wuliu=arr[0];
         wuliudanhao=wuliu.logid;
    NSLog(@"ads%@",wuliudanhao);
    // logid = 84;
        NSLog(@"chird%@",result);
    }
}

@end
