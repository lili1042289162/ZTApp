//
//  SaleOrderViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "SaleOrderViewController.h"
#import "TeMaiProduct.h"
#import "MyAddressViewController.h"
#import "ZTNetWorkUtilities.h"
#import "ZTCoverView.h"
#import "DisCountmodel.h"
#import "DisCountViewController.h"
#import "MeController.h"
@interface SaleOrderViewController ()<NetResultProtocol>
{   UISwitch*switchbtn;
    UIView *_topLayout;
    // data
    TeMaiProduct* _product;
    NSInteger count;
    CGFloat price;
    NSMutableArray*discountarr;
     NSNumber*bt;
}
@end

@implementation SaleOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self initTitleBar];
    
    [self initViews];
    //[self loadData];
    NSLog(@"%@ha%@ha%@",self.reviseaddress.truename,[self.reviseaddress.tel stringValue],self.reviseaddress.address);
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
          if (self.reviseaddress==nil) {
        NSLog(@"%@oooooooooooooo",self.reviseaddress);
        
       _addItem.nameLabel.text = @"                  ";
        _addItem.phoneLabel.text = @"                                  ";
        _addItem.addLabel.text = @"                    点击新增地址";
    }
    else{
        _addItem.nameLabel.text =self.reviseaddress.truename;
        
        _addItem.phoneLabel.text = [self.reviseaddress.tel stringValue];
        _addItem.addLabel.text =self.reviseaddress.address;
    }
    
    self.navigationController.navigationBar.hidden = NO;
    //添加键盘的监听事件
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    NSLog(@"%@  %@",self.Quanzhi,self.Quanmc);
    if (self.Quanzhi&&self.Quanmc) {
    
        self.discountview.QuanLabel.text=self.Quanmc;
        self.discountview.QuanZhi.text=[NSString stringWithFormat:@"￥%@",self.Quanzhi];
        _buyItem.totalPrice.text =[NSString stringWithFormat:@"￥%0.2f", price-[self.Quanzhi floatValue]-[self.TBmoney floatValue]];
        
      
        
    }
    
}

#pragma mark - build views
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"提交订单"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

-(void)initViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    _productItem = [ZTProductItem new];
    [self initNumberItem];
    [self initAddItem];
    //[self initInVoice];
     [self initDisCount];
     [self initTuanBi];
    [self initBuyItem];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubViews:@[_addItem,_productItem,_numberItem,_discountview,_Tuanbi, _buyItem]];
    
    
    UITapGestureRecognizer*revisetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaddress)];
    revisetap.numberOfTapsRequired=1;
    [_addItem addGestureRecognizer:revisetap];
    
    
    UITapGestureRecognizer*discount=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdiscount:)];
    discount.numberOfTapsRequired=1;
    [self.discountview addGestureRecognizer:discount];
    }



-(void)tapaddress
{
    NSLog(@"dianjil");
    MyAddressViewController*MyAddressvc=[[MyAddressViewController alloc]init];
    //[self sendertags:@"order"];
    MyAddressvc.ttag=@"order";
    MyAddressvc.delegate=self;
    [self.navigationController pushViewController:MyAddressvc animated:YES];
}
-(void)tapdiscount:(UIGestureRecognizer*)sender{
 
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMQUAN] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
    NSLog(@"aaaa");

}
-(void)initNumberItem{
    _numberItem = [ZTNumberItem new];
    _numberItem.backgroundColor=[UIColor whiteColor];
    __weak id safeSelf = self;
    NSNumber __weak*time=self.buynumbers;
    _numberItem.didTapAddBtn = ^(){
                 NSLog(@"cout%@cout",time);
        if ([time intValue]) {
            if (count>=[time integerValue])
            {
                NSString*mess=@"已达到最大购买量";
                alertShow(mess);
            }
        }
             else{
               NSLog(@"cout");
                   [safeSelf onClickAddBtn];}
    };
    _numberItem.didTapSubBtn = ^(){
        [safeSelf onClickSubBtn];
    };
}

-(void)initAddItem{
    _addItem = [ZTAddressItem new];
    _addItem.leftPadding = 11.0;
    _addItem.lineGap = 13.0;
    _addItem.contentGap = 9.0;
    _addItem.indicatorRightPadding = 15.0;
    _addItem.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _addItem.borderWidth = 1.0;
    _addItem.backgroundColor = [UIColor colorWithHex:0xfbfbfb];
}
-(void)initDisCount{
self.discountview=[DisCountView new];

    self.discountview.QuanLabel.text=@"选择使用优惠劵";
    self.discountview.QuanZhi.text=@"优惠劵金额";
    self.discountview.leftPadding = 11.0;
    self.discountview.indicatorRightPadding = 15.0;
    self.discountview.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    self.discountview.borderWidth = 1.0;
    self.discountview.backgroundColor = [UIColor colorWithHex:0xfbfbfb];

}
-(void)initTuanBi{
    self.Tuanbi=[DisCountView new];
    
    self.Tuanbi.QuanLabel.text=@"选择使用团币";
    self.Tuanbi.QuanZhi.text=@"团币数量       ";
    switchbtn=[[UISwitch alloc]initWithFrame:CGRectMake(120, 1, 0, 0)];
    self.Tuanbi.leftPadding = 11.0;
   self.Tuanbi.indicatorRightPadding = -15.0;
    self.Tuanbi.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    self.Tuanbi.borderWidth = 1.0;
    self.Tuanbi.backgroundColor = [UIColor colorWithHex:0xfbfbfb];
   [self.Tuanbi addSubview:switchbtn];
   [switchbtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}

-(void)initInVoice{
    self.invoice = [ZTTextContentView new];
    self.invoice.text =@"发票：公司抬头";
    self.invoice.textContainerInset = UIEdgeInsetsMake(10, 30.0, 10, 30.0);
    self.invoice.editable = YES;
    self.invoice.scrollEnabled = NO;
    self.invoice.font = [UIFont systemFontOfSize:10.0];
    self.invoice.textColor = [UIColor colorWithHex:0x656565];
    self.invoice.topBorder = YES;
    self.invoice.bottomBorder = YES;
    self.invoice.borderWidth = 0.5;
    self.invoice.keyboardType = UIKeyboardAppearanceDefault;
    self.invoice.returnKeyType = UIReturnKeyDone;
     self.invoice.delegate=self;
     self.invoice.tag=1000;
}
#pragma keybord event
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

// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification
{
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    NSLog(@"gaodu%@",keyboardObject);
    //调整放置有textView的view的位置
    
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:0.01];
    
    //设置view的frame，往上平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-keyboardRect.size.height-40, 320, 40)];
    [UIView commitAnimations];
}

//键盘消失时
-(void)keyboardDidHidden
{
    //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    //设置view的frame，往下平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-165, 320, 40)];
    [UIView commitAnimations];
}



-(void)initBuyItem{
    _buyItem = [ZTBuyItem new];
    __weak id safeSelf = self;
    _buyItem.didTapOrder = ^(){
        [safeSelf onClickOrderBtn];
    };
}
#pragma mark - layout views

-(void)viewDidLayoutSubviews{
    [[[_productItem setScreenWidth] setRectHeight:80.0] setRectBelowOfView:_topLayout];
    [[[[_numberItem setScreenWidth] setRectHeight:80.0] setRectBelowOfView:_productItem] addRectY:10.0];
    [[[[_addItem setScreenWidth] setRectHeight:65.0] setRectBelowOfView:_numberItem] addRectY:10.0];
   // [[[[self.invoice setScreenWidth]setRectHeight:30.0]setRectBelowOfView:_addItem]addRectY:10.0];
   [[[[self.discountview setScreenWidth]setRectHeight:30]setRectBelowOfView:_addItem]addRectY:10.0];
   [[[[self.Tuanbi setScreenWidth]setRectHeight:33]setRectBelowOfView:self.discountview]addRectY:7.0];
    [[[[_buyItem setScreenWidth] setRectHeight:60.0] setRectBelowOfView:self.Tuanbi] addRectY:7.0];
}

-(void)initData{
    _product = [[ZTDataCenter sharedInstance] getProductWithPid:_productId forType:CKEY_TE_MAI];
    NSLog(@"product%@product",_product.shopid);
    count = 1;
    price = [_product.tmdj floatValue];
    
    self.Quanzhi=@"0";
    self.TBmoney=@"0";
   self.rrow=100;
}

-(void)loadData{
    _productItem.title.text = _product.title;
    [_productItem.pic setImageFromUrl:_product.picurl];
    NSString*tedjj=[NSString stringWithFormat:@"%@",_product.tmdj];
        _productItem.price.text  =tedjj;
    _numberItem.countLabel.text = @"1";
    _numberItem.kc.text = @"50";
    _buyItem.total.text = @"1";
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",price];
    if (_product==nil) {
        NSLog(@"dashab");
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETATEMAI] delegate:self cancelIfExist:YES ];
        _productItem.title.text =@"setrdhftxgfdzszfxghcnbvcxzxcbvvxczxSAgdvxczcnvcxv";
         _buyItem.totalPrice.text=@"00000000000";
        _productItem.price.text  =@"1233456789";
        [ZTCoverView alertCover];
    }
    
    
}

#pragma mark - onClick Events
/**
 点击下单按钮
 
 */

-(void)switchAction:(UISwitch*)sender{
  BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"kai");
         [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY] delegate:self cancelIfExist:YES];
    }
    else  {
    bt=0;
    self.TBmoney=@"0";
    // _buyItem.totalPrice.text =[NSString stringWithFormat:@"￥%0.2f", price-[self.Quanzhi floatValue] ];
  _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price-[self.Quanzhi floatValue]+[self.TBmoney floatValue]];
        self.Tuanbi.QuanZhi.text=@"团币数量";
    }


}

-(void)onClickOrderBtn{
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.reviseaddress.uaid!=nil&&count>0) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER] delegate:self cancelIfExist:YES];
        
        [ZTCoverView alertCover];
    }
    else{
        
        alertShow(@"地址未设置或数量为空");
    }
}

/**
 点击加按钮
 */
-(void)onClickAddBtn{
    count ++;
       _numberItem.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.total.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price-[self.Quanzhi floatValue]-[self.TBmoney floatValue]];
    [_buyItem setNeedsLayout];
    [_buyItem layoutIfNeeded];
}

/**
 点击减按钮
 */
-(void)onClickSubBtn{
    if (count != 1) {
        count --;
    }
    _numberItem.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.total.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price-[self.Quanzhi floatValue]-[self.TBmoney floatValue]];
    [_buyItem setNeedsLayout];
    [_buyItem layoutIfNeeded];
}
# pragma mark  net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result
{
    if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI]]){
    
        _productItem.title.text = _product.title;
        [_productItem.pic setImageFromUrl:_product.picurl];
        NSString*tedjj=[NSString stringWithFormat:@"%@",_product.tmdj];
        _productItem.price.text  =tedjj;
        
        _numberItem.countLabel.text = @"1";
        _numberItem.kc.text = @"50";
        _buyItem.total.text = @"1";
       
        _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",price];
    
           }
  else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]])
{self.ordernumber=[result objectForKey:@"ordno"];
    NSLog(@"%@dindan",self.ordernumber);
    PurchaseViewController*purchaseviewcontroller=[[PurchaseViewController alloc]init];
    purchaseviewcontroller.paymoney=[ NSNumber  numberWithFloat:[ _product.tmdj floatValue] *count];
    purchaseviewcontroller.payproduct=_product;
    purchaseviewcontroller.ordno=self.ordernumber;
    [self.navigationController pushViewController:purchaseviewcontroller animated:YES];}
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
        if (self.rrow!=100) {
             DisCountmodel*discount=discountarr[self.rrow];
             discount.select=@"no";
            DisCountViewController*dicvc=[DisCountViewController new];
            dicvc.delegate=self;
            dicvc.QuanArr=discountarr;
            [self.navigationController pushViewController:dicvc animated:YES];
            
        }
        else{
      
        DisCountViewController*dicvc=[DisCountViewController new];
        dicvc.delegate=self;
        dicvc.QuanArr=discountarr;
        [self.navigationController pushViewController:dicvc animated:YES];

            NSLog(@"qunima%@",result);}
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]) {
    bt=[result objectForKey:@"ordtbmoney"];
        self.Tuanbi.QuanZhi.text=[NSString stringWithFormat:@"团币:%@",[result objectForKey:@"ordtbmoney"]];
        self.TBmoney=[NSString stringWithFormat:@"%0.2f",[bt floatValue]*0.01 ];
        
        _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price-[self.Quanzhi floatValue]-[self.TBmoney floatValue]];
        NSLog(@"asasa%@",self.TBmoney);
    }
    
    
    [ZTCoverView dissmiss];
    
   }
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result
{if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]])
{ NSLog(@"wwq%@wwq",result);}
  if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
  {     NSLog(@"wwq%@wwq",result);
  _product=[[TeMaiProduct alloc]init];
      _product.picurl=[result objectForKey:@"picurl"];
      
      _product.tmdj=[result objectForKey:@"tmdj"];
      
      _product.title=[result objectForKey:@"title"];
        _product.tmid=[result objectForKey:@"tmid"];
      _product.shopid=[result objectForKey:@"shopid"];
      
      count = 1;
      price = [_product.tmdj floatValue];
  }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
    
    NSLog(@"asasas%@",result);
        NSArray *discountes = [(NSArray*)result jsonParseToArrayWithType:[DisCountmodel class]];
        discountarr=[NSMutableArray array];
        [discountarr removeAllObjects];
        [discountarr addObjectsFromArray:discountes];

        for (DisCountmodel*a in discountarr) {
        
            a.select=@"yes";
        }

    NSLog(@"quan%@ discount%@",result,discountarr);
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]) {
    NSLog(@"12121%@",[result objectForKey:@"ordtbmoney"]);
    
    }
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg
{alertShow(errmsg);
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]) {
         [switchbtn setOn:NO animated:YES];
        
    }

[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params
{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_ADDRESSIDD:[self getaddressuid],
                                           NET_ARG_SENDIDD:[self getsendidd],
                                           NET_ARG_INVOICE:[self getinvoice],
                                           NET_ARG_LNGO:[self getlngo],
                                           NET_ARG_LATO:[self getlato],
                                           NET_ARG_SHOPIDD:[self getshopidd],
                                           NET_ARG_SPSU:[self getshangpingshuju],
                                           NET_ARG_TMQNO:[NSString stringWithFormat:@"%@", self.quanno],
                                           NET_ARG_TBMONEY:[NSString stringWithFormat:@"%@",bt],                                                                      }];
    
        
    }
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
    {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_TEMAI_TMID:[NSString stringWithFormat:@"%@",self.productId],                                                                          }];
    }
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMQUAN]]){
    
        [params addEntriesFromDictionary:@{
                                           NET_ARG_GETTMQUAN_SHOPID:[NSString stringWithFormat:@"%@,%@", @"0",_product.shopid],
                                           NET_ARG_GETTMQUAN_ORDJE:[NSString stringWithFormat:@"%@,%@",_product.tmdj,_product.tmdj],                                                                         }];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDTBMONEY]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_ORDTBMONEY_TMID:[NSString stringWithFormat:@"%@",self.productId],                                                                          }];
    }


}
-(NSNumber*)getaddressuid
{
    
    
    return self.reviseaddress.uaid;
    
}
-(NSNumber*)getsendidd
{
    return [NSNumber numberWithInt:100];
}
-(NSString*)getinvoice
{
    return [NSString stringWithFormat:@"%@",self.invoice.text];
}
-(NSNumber*)getlngo
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"long"];
    
}
-(NSNumber*)getlato
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
}
-(NSNumber*)getshopidd{
    
    return _product.shopid;
}
-(NSString*)getshangpingshuju
{
    NSArray*keys=[[NSArray alloc]initWithObjects:@"sl",@"cpmc",@"je",@"cppic", @"dj",@"cm",nil];
    NSArray*values=[[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:count],_product.title,[ NSNumber  numberWithFloat:[ _product.tmdj floatValue] *count],_product.picurl,_product.tmdj,[NSString stringWithFormat:@"%@",self.cimaid], nil];
    NSDictionary*spxq=[[NSDictionary alloc]initWithObjects:values forKeys:keys];
    
    NSMutableDictionary*sp=[[NSMutableDictionary alloc]init];
    //[sp setObject:spxq forKey:[_product.tmid stringValue]];
    [sp setObject:spxq forKey:[NSString stringWithFormat:@"%@",_product.tmid]];
    NSMutableDictionary*sd=[[NSMutableDictionary alloc]init];
    //[sd setObject:sp forKey:[_product.shopid stringValue]];
    [sd setObject:sp forKey:[NSString stringWithFormat:@"%@",_product.shopid]];
    NSData*jsondata=[NSJSONSerialization dataWithJSONObject:sd options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@sb ",[[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding]);
    
    return [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
}

@end
