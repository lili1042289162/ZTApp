//
//  ShopCartOrderInfoTableViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/5/30.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ShopCartOrderInfoTableViewController.h"
#import "ZTAddressItem.h"
#import "ZTTitleLabel.h"
#import "NoPayCell.h"
#import "MyAddressViewController.h"
#import "OrderInfoTableViewCell.h"
#import "ShopCart.h"
#import "ZTRoundButton.h"
#import "PurchaseViewController.h"
#import "ZTCoverView.h"
#import "DisCountViewController.h"
#import "DisCountmodel.h"
@interface ShopCartOrderInfoTableViewController ()<NetResultProtocol>{
//view
UIView*headview;
ZTAddressItem*addressview;
UIView* _bottomBar;
ZTRoundButton*_buyBtn;
UILabel*totleprice;
UISwitch*switchbtn;
//data
NSMutableArray*ShopCartorderarr;
NSMutableArray*messagees;
NSMutableArray*DisCountes;
NSNumber*ZTbt;
}

@end

@implementation ShopCartOrderInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self initTitleBar];
   [self initview];
    
   NSLog(@"gouwuchea%@   %@",self.CartProids,self.money);
}
-(void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden=YES;
    if (self.addres) {
        addressview.nameLabel.text = self.addres.truename;
        addressview.phoneLabel.text =[self.addres.tel stringValue];
        addressview.addLabel.text =self.addres.address;
    }
NSLog(@"%@aa",self.addres);
    if (self.Quanzhib&&self.Quanmcb) {
        self.discountview.QuanLabel.text=self.Quanmcb;
        self.discountview.QuanZhi.text=[NSString stringWithFormat:@"￥%@",self.Quanzhib];
       totleprice.text=[NSString stringWithFormat:@"￥ %0.2f",[self.money floatValue]-[self.Quanzhib floatValue]-[self.tuanbimoney floatValue]];
       
       
    }}
#pragma mark  - build views
-(void)initTitleBar{
ZTTitleLabel*titleview=[[ZTTitleLabel alloc]initWithTitle:@"订单信息"];
[titleview fitSize];
self.navigationItem.titleView=titleview;
}
-(void)initview{
    [self initHeadview];
    [self initBootomBar];
    [self initTableView];
self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
messagees=[NSMutableArray array];
    UITapGestureRecognizer*discount=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdiscountt:)];
    discount.numberOfTapsRequired=1;
    [self.discountview addGestureRecognizer:discount];
    self.roww=100;
    }
-(void)initHeadview{
headview=[[UIView alloc]initWithFrame:CGRectZero];
addressview =[ZTAddressItem new];
addressview.nameLabel.text = @"                  ";
addressview.phoneLabel.text = @"                                  ";
addressview.addLabel.text = @"                       点击新增地址";
addressview.leftPadding=11.0;
addressview.lineGap=13.0;
addressview.contentGap=9.0;
addressview.indicatorRightPadding=15.0;
addressview.borderColor=[UIColor colorWithHex:COL_LINEBREAK];
addressview.borderWidth=1.0;
addressview.backgroundColor=[UIColor colorWithHex:0xfbfbfb];
[[addressview setScreenWidth] setRectHeight:65.0];
//addressview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ADDaddress:)];
    [addressview addGestureRecognizer:tap];
    
addressview.backgroundColor=[UIColor whiteColor];
[headview addSubview:addressview];
[[[headview wrapContents]addRectHeight:10.0]setBackgroundColor:[UIColor clearColor]];

}
/**
 初始化底部bar
 */
-(void)initBootomBar{

    self.discountview=[DisCountView new];
    
    self.discountview.QuanLabel.text=@"选择使用优惠劵";
    self.discountview.QuanLabel.textColor = [UIColor colorWithHex:0x333333];
    self.discountview.QuanZhi.text=@"优惠劵金额";
    self.discountview.QuanZhi.textColor = [UIColor colorWithHex:0x333333];
    self.discountview.leftPadding = 11.0;
    self.discountview.indicatorRightPadding = 15.0;
    self.discountview.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    self.discountview.borderWidth = 1.0;
    self.discountview.backgroundColor = [UIColor colorWithHex:0xfbfbfb];
    self.discountview.backgroundColor=[UIColor clearColor];
    
     self.ZTuanBi=[DisCountView new];
    
    self.ZTuanBi.QuanLabel.text=@"选择使用团币";
    self.ZTuanBi.QuanLabel.textColor = [UIColor colorWithHex:0x333333];
    self.ZTuanBi.QuanZhi.text=@"团币金额        ";
    self.ZTuanBi.QuanZhi.textColor = [UIColor colorWithHex:0x333333];
    switchbtn=[[UISwitch alloc]initWithFrame:CGRectMake(130, 1, 0, 0)];
    self.ZTuanBi.leftPadding = 11.0;
    self.ZTuanBi.indicatorRightPadding = -15.0;
   self.ZTuanBi.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
  self.ZTuanBi.borderWidth = 1.0;
    self.ZTuanBi.backgroundColor=[UIColor clearColor];
    //self.ZTuanBi.backgroundColor = [UIColor colorWithHex:0xfbfbfb];
    [self.ZTuanBi addSubview:switchbtn];
    [switchbtn addTarget:self action:@selector(switchActionb:) forControlEvents:UIControlEventValueChanged];


    _bottomBar   = [UIView new];
    _bottomBar.backgroundColor = [UIColor whiteColor];
    
    _buyBtn = [ZTRoundButton new];
    [_buyBtn setImage:[UIImage imageNamed:@"sale_buyBtn_bg"] forState:UIControlStateNormal];   [_buyBtn addTarget:self action:@selector(didTapTotleBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel*totle=[UILabel new];
    totle.font = [UIFont systemFontOfSize:14.0];
    totle.textColor = [UIColor colorWithHex:0x333333];
    totle.text=@"总计 :";
    
    totleprice=[UILabel new];
    totleprice.font = [UIFont systemFontOfSize:14.0];
    totleprice.textColor = [UIColor colorWithHex:0x333333];

    totleprice.text=[NSString stringWithFormat:@"￥ %0.2f",[self.money floatValue]];
       [_bottomBar addSubViews:@[_buyBtn,totle, totleprice,self.discountview,self.ZTuanBi]];
       [[[[self.discountview setScreenWidth]setRectHeight:30]setRectMarginLeft:1.0]setRectMarginTop:0.0];
       [[[[self.ZTuanBi setScreenWidth]setRectHeight:33]setRectMarginLeft:1.0]setRectBelowOfView:self.discountview];
           [[[[totle  fitSize]setRectMarginLeft:25]setRectBelowOfView:self.ZTuanBi]addRectY:6.0];
    [[[[[[totleprice fitSize]setRectHeight:20] setRectOnRightSideOfView:totle]addRectX:5]setRectBelowOfView:self.ZTuanBi]addRectY:6.0];
    [[[[[[_buyBtn setRectWidth:60]setRectHeight:20]setRectOnRightSideOfView:totleprice]addRectX:100.0]setRectBelowOfView:self.ZTuanBi]addRectY:6.0];
  
   _bottomBar.backgroundColor=[UIColor grayColor];
    
}
-(void)initTableView{
[self.tableView registerClass:[OrderInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
self.tableView.backgroundColor=[UIColor clearColor];
self.tableView.separatorStyle=UITableViewCellAccessoryNone;
self.tableView.tableHeaderView=headview;
[self.tableView addSubview:_bottomBar];
}
-(void)viewDidLayoutSubviews{
    [[self.tableView setScreenWidth] heightToEndWithPadding:0.0];
     [[[_bottomBar setScreenWidth] setRectHeight:92.0] setRectMarginBottom:0.0];
}

#pragma mark click event

-(void)switchActionb:(UISwitch*)sender{
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"kai");
        //
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY] delegate:self cancelIfExist:YES];
    }
    else  {
        ZTbt=[NSNumber numberWithFloat:0];
self.tuanbimoney=@"0";
        self.ZTuanBi.QuanZhi.text=@"团币数量";
        
        totleprice.text=[NSString stringWithFormat:@"￥ %0.2f",[self.money floatValue]-[self.Quanzhib floatValue]-[self.tuanbimoney floatValue]];
        
        }
    
    
}

-(void)tapdiscountt:(UIGestureRecognizer*)sender{
    
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMQUAN] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
    
    
}

-(void)ADDaddress:(UIGestureRecognizer*)tap{
    
    MyAddressViewController*vc=[[MyAddressViewController alloc]init];
    vc.ttag=@"order";
    vc.delega=self;
    
    [self.navigationController  pushViewController:vc animated:YES];
    
    NSLog(@"haha");
    
}
-(void)didTapTotleBuyBtn:(UIButton*)sender{

    if (self.addres.uaid!=nil) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CARTORDER] delegate:self cancelIfExist:YES];
        
        [ZTCoverView alertCover];
    }
    else{
        
        alertShow(@"地址未设置或数量为空");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.CartProids.count;

}
-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
OrderInfoTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    ShopCart*shoptart = self.CartProids[row];
    [cell.ShopCartPic setImageFromUrl:shoptart.cppic];
    cell.Producttitle.text=shoptart.cpmc;
    
    if (![self isNull:shoptart.chima]) {
        cell.cima.text=@"";
    }else{
        cell.cima.text=[ NSString stringWithFormat:@"%@",shoptart.chima];}
    
    cell.price.text=[NSString stringWithFormat:@"%@",shoptart.dj];
    cell.sl.text=[NSString stringWithFormat:@"x%@",shoptart.sl];
    cell.Topborder=YES;
    cell.BottomBorder=YES;
    cell.BorderWidth=1.0;
    cell.liuyan.delegate=self;
    if (cell.liuyan.text==nil) {
        cell.liuyan.text=@"没有留言";
    }else{
        [messagees addObject:cell.liuyan.text];}
return cell;

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
#pragma initdata


#pragma net work

-(void)requestUrl:(NSString*)request resultSuccess:(id)result{


     if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
     
     NSLog(@"ahhaha%ld",self.roww);
     
         if (self.roww!=100) {
                         DisCountmodel*discount=DisCountes[self.roww];
                         discount.select=@"no";
                         DisCountViewController*dicvc=[DisCountViewController new];
                         dicvc.delega=self;
                         dicvc.QuanArr=DisCountes;
                         [self.navigationController pushViewController:dicvc animated:YES];
             
                     }
                     else{
             
                         DisCountViewController*dicvc=[DisCountViewController new];
                         dicvc.delega=self;
                         dicvc.QuanArr=DisCountes;
                         [self.navigationController pushViewController:dicvc animated:YES];
                         
                         NSLog(@"qunima%@",result);}
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]){
        
        
    ZTbt=[result objectForKey:@"ordtbmoney"];
       
        self.ZTuanBi.QuanZhi.text=[NSString stringWithFormat:@"团币:%@",[result objectForKey:@"ordtbmoney"]];
      self.tuanbimoney=[NSString stringWithFormat:@"%0.2f",[ZTbt floatValue]*0.01 ];
      
       totleprice.text=[NSString stringWithFormat:@"￥ %0.2f",[self.money floatValue]-[self.Quanzhib floatValue]-[self.tuanbimoney floatValue]];
      
        }
     if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CARTORDER]]){
        NSLog(@"adada%@",result);

     NSString*ordernumber=[result objectForKey:@"ordno"];
   
    PurchaseViewController*purchaseviewcontrollervc=[[PurchaseViewController alloc]init];
    float floatmoney = [ self.money floatValue];
   purchaseviewcontrollervc.paymoney=[NSNumber numberWithFloat:floatmoney];
    //    purchaseviewcontrollervc.payproduct=_product;
  purchaseviewcontrollervc.ordno=ordernumber;
    [self.navigationController pushViewController:purchaseviewcontrollervc animated:YES];
    }
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]){
    [switchbtn setOn:NO animated:YES];
    }

alertShow(errmsg);
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CARTORDER]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_CARTORDER_ADDRID:[self getaddressuid],
                                           NET_ARG_CARTORDER_SENDIDD:[self getsendidd],
                                           NET_ARG_CARTORDER_INVOICE:[self getinvoice],
                                           NET_ARG_CARTORDER_LNGO:[self getlngo],
                                           NET_ARG_CARTORDER_LATO:[self getlato],
                                           NET_ARG_CARTORDER_CTID:[self getcartctid],
                                           NET_ARG_CARTORDER_CTMESS:[self getshangpingliuyan],
                                           NET_ARG_CARTORDER_TBJE:[NSString stringWithFormat:@"%@",ZTbt],
                                           NET_ARG_TMQNO_CARTORDER_TMQNO:[NSString stringWithFormat:@"%@",self.quanhao],
                                           }];

    }
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
              [params addEntriesFromDictionary:@{
                                           NET_ARG_GETTMQUAN_SHOPID:[NSString stringWithFormat:@"%@,%@",@"0",[self getshopides]],
                                           NET_ARG_GETTMQUAN_ORDJE:[NSString stringWithFormat:@"%@,%@",self.money,[self getmoney]],                                                                         }];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_ORDTBMONEY_TMID:[NSString stringWithFormat:@"%@",[self gettmides]],                                                                          }];
    }

}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    NSLog(@"ordere%@",result);
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
        NSArray *discountes = [(NSArray*)result jsonParseToArrayWithType:[DisCountmodel class]];
        DisCountes=[NSMutableArray array];
        [DisCountes removeAllObjects];
        [DisCountes addObjectsFromArray:discountes];
        for (DisCountmodel*a in DisCountes) {
            a.select=@"yes";
        }
        NSLog(@"quan%@ discount%@",result,DisCountes);
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]){
    NSLog(@"tttbbbmoney%@",result);
    }

}
-(NSString*)getshopides{

    NSMutableArray*shopides=[NSMutableArray array];
    for (ShopCart*shopcart in self.CartProids) {
        NSLog(@"xuanzong%@",shopcart.shopid);
        [shopides addObject:shopcart.shopid];
    }
    NSString *string = [shopides componentsJoinedByString:@","];
    
    return string;

}
-(NSString*)gettmides{


NSMutableArray*mides=[NSMutableArray array];
    for (ShopCart*shopcart in self.CartProids) {
        NSLog(@"nitamadexuanzong%@",shopcart.mid);
        NSNumber*mid= shopcart.mid;
        [mides addObject:mid];
    }
    NSString *string = [mides componentsJoinedByString:@","];
    
    return string;



}
-(NSString*)getmoney{

    NSMutableArray*shopmoney=[NSMutableArray array];
    for (ShopCart*shopcart in self.CartProids) {
        NSLog(@"xuanzong%@",shopcart.sl);
        NSLog(@"moneyy%@",shopcart.dj);
        float moey=[shopcart.sl floatValue]*[shopcart.dj floatValue];
    NSNumber*shopmon=[NSNumber numberWithFloat:moey];
            [shopmoney addObject:shopmon];
    }
    NSString *string = [shopmoney componentsJoinedByString:@","];
    
    return string;

}
-(NSNumber*)getaddressuid
    {
return self.addres.uaid;
        
    }
-(NSNumber*)getsendidd
    {
return [NSNumber numberWithInt:100];
    }
-(NSNumber*)getinvoice
{
return [NSNumber numberWithInt:100];
}
-(NSNumber*)getlngo
    {
        
return [[NSUserDefaults standardUserDefaults]objectForKey:@"long"];
        
    }
-(NSNumber*)getlato
    {
        
return [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    }
-(NSString*)getcartctid{
//ctid/购物车id(用,分隔)

NSMutableArray*ctids=[NSMutableArray array];
    for (ShopCart*shopcart in self.CartProids) {
    NSLog(@"xuanzong%@",shopcart.sl);
               NSNumber*ctid= shopcart.ctid;
               [ctids addObject:ctid];
    }
NSString *string = [ctids componentsJoinedByString:@","];

return string;
}
-(NSString*)getshangpingliuyan{

//ctmess/购物留言(用|分隔)
NSString*message=[messagees componentsJoinedByString:@"|"];

return message;

}
@end
