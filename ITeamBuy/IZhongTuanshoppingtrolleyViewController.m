//
//  IZhongTuanshoppingtrolleyViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/20.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.

#import "IZhongTuanshoppingtrolleyViewController.h"
#import "ZTTitleLabel.h"
#import "SaleController.h"
#import "HomeTabBarController.h"
#import "ZTCoverView.h"
#import "ShopCart.h"
#import "ShopCartTableViewCell.h"
#import "ZTRoundButton.h"
#import "ZTNumberItem.h"
#import "ShopCartOrderInfoTableViewController.h"

@interface IZhongTuanshoppingtrolleyViewController ()<NetResultProtocol,UITableViewDataSource,UITableViewDelegate>
{UIView*titleview;
UIButton*bt;
UIImageView*tubiao;
UILabel*label;
UIView*view;
UIView* _bottomBar;
UITableView*shopcarttableview;
ZTRoundButton* _buyBtn;
ZTRoundButton*_delteBtn;
UILabel*totlemoney;
UILabel*select;
ZTNumberItem*numberItems;

//data
NSMutableArray *shopcartarr;
NSString*token;
NSInteger count;
NSArray*btnes;
NSInteger totleselectnum;
NSMutableArray*arr;
NSNumber*cttid;
NSMutableArray*selectproid;
CGFloat sum;
}
@end

@implementation IZhongTuanshoppingtrolleyViewController
-(void)viewDidLoad{

[super viewDidLoad];
[self initTitleView];
[self initView];
}
-(void)viewWillAppear:(BOOL)animated{

[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden=NO;
self.navigationController.navigationBar.hidden=NO;

    if (token) {
    [self initData];
    }
}
-(void)initTitleView{
titleview=[[ZTTitleLabel alloc]initWithTitle:@"购物车"];
[titleview fitSize];
self.navigationItem.titleView=titleview;
}
/**
 初始化底部bar
 */
-(void)initBootomBar{
    _bottomBar   = [UIView new];
    _bottomBar.backgroundColor = [UIColor whiteColor];
    
   _buyBtn = [ZTRoundButton new];
   //[_buyBtn setImage:[UIImage imageNamed:@"sale_buyBtn_bg"] forState:UIControlStateNormal];   [_buyBtn addTarget:self action:@selector(didTapTotleBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    _buyBtn.backgroundColor=[UIColor redColor];
    [_buyBtn setTitle:@"去结算" forState:UIControlStateNormal];
    
   _delteBtn = [ZTRoundButton new];
   // [_delteBtn setImage:[UIImage imageNamed:@"sale_collectBtn_bg"] forState:UIControlStateNormal];
    //[_delteBtn addTarget:self action:@selector(didTapDelteBtnn:) forControlEvents:UIControlEventTouchUpInside];
  _delteBtn.backgroundColor=[UIColor grayColor];
   [_delteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_delteBtn addTarget:self action:@selector(DeleCart:) forControlEvents:UIControlEventTouchUpInside];
    

     UILabel*totle=[UILabel new];
    totle.font = [UIFont systemFontOfSize:14.0];
    totle.textColor = [UIColor colorWithHex:0x333333];
totlemoney=[UILabel new];
    totlemoney.font = [UIFont systemFontOfSize:14.0];
    totlemoney.textColor = [UIColor colorWithHex:0x333333];
totlemoney.text=@"00000.00";
totlemoney.text=[NSString stringWithFormat:@"%@ ￥ %@",@"总计",totlemoney.text];
select=[UILabel new];
select.font = [UIFont systemFontOfSize:14.0];
select.textColor = [UIColor colorWithHex:0x333333];

select.text=[NSString stringWithFormat:@"已选 %@件",@"0"];
 totleselectnum =0;
   [_bottomBar addSubViews:@[_buyBtn,totlemoney, _delteBtn,select]];
   [[[select  fitSize]setRectMarginLeft:25]setRectMarginTop:10];
   [[[[[_delteBtn setRectWidth:40]setRectHeight:20] setRectOnRightSideOfView:select]addRectX:5]setRectMarginTop:10];
   [[[[totlemoney fitSize]setRectOnRightSideOfView:_delteBtn]addRectX:20]setRectMarginTop:10];
   [[[[[_buyBtn setRectWidth:60]setRectHeight:20]setRectOnRightSideOfView:totlemoney]addRectX:8.0]  setRectMarginTop:10];
   }
-(void)initView{
    token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (!token) {
   view=[[UIView alloc]init];
 tubiao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopbug"]];
label=[[UILabel alloc]init];
label.text=@"你购物车没有商品";
label.font=[UIFont systemFontOfSize:12];
bt=[[UIButton alloc]init];
[view addSubViews:@[tubiao,label,bt]];
[[[[[tubiao fitSize]setRectMarginTop:5]setRectMarginLeft:89]setRectHeight:60]setRectWidth:40];
[[[[label fitSize]setRectBelowOfView:tubiao]addRectY:7]setRectMarginLeft:58];
[[[[[bt  fitSize] setRectBelowOfView:label]setRectX:7] setRectHeight:40]setRectWidth:210];
[view wrapContents];
[self.view addSubview:view];
[bt setTitle:@"随便逛逛"forState: UIControlStateNormal];

[bt setBackgroundImage:[UIImage imageNamed:@"activebtn_no_select"] forState:UIControlStateNormal];
[bt setBackgroundImage:[UIImage imageNamed:@"activebtn_select"] forState:UIControlStateHighlighted];

    [bt addTarget:self action:@selector(gotoshouye:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
    [self initBootomBar];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initTableview];
    [self.view addSubViews:@[shopcarttableview,_bottomBar]];
    }
    
       }
-(void)initTableview{
    shopcarttableview=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds]style:UITableViewStylePlain];
    shopcarttableview.showsHorizontalScrollIndicator=NO;
    shopcarttableview.showsHorizontalScrollIndicator=NO;
    shopcarttableview.delegate=self;
    shopcarttableview.dataSource=self;
    shopcarttableview.backgroundColor=[UIColor clearColor];
    shopcarttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [shopcarttableview registerClass:[ShopCartTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)viewDidLayoutSubviews{
 [[shopcarttableview setScreenWidth] heightToEndWithPadding:44.0];
[[[_bottomBar setScreenWidth] setRectHeight:44.0] setRectOnTopOfView:self.tabBarController.tabBar];
        if (!token) {
      [view setRectCenterInParent];}
}
#pragma click event
-(void)DeleCart:(UIButton*)bt{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_DELCART] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];
}

-(void)gotoshouye:(UIButton*)sender{
NSLog(@"hah");
HomeTabBarController*vc=[HomeTabBarController new];

   [self presentViewController:vc animated:YES completion:nil];
}
-(void)initData{
arr=[NSMutableArray array];
selectproid=[NSMutableArray array];
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_GETCAR] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];
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
#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
NSLog(@"22");
    //ShopCartTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //NSLog(@"celllll%@",cell);
 ShopCartTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
       cell = [[ShopCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];   }

   //每次刷新数据要处理部分   reloaddata/向下滑动刷新
    NSInteger row = [indexPath row];
    ShopCart*shoptart = shopcartarr[row];
    //获得cell索引与对象对应
    cell.cartctid =shoptart.ctid;
    cell.ccont=(long)[shoptart.sl integerValue];
   
   ShopCart  __weak *selectnum=shoptart;
   
    if ([selectnum.Selectnum isEqualToString:@"yes"]) {
    NSLog(@"nihao");
        cell.btnSelect=NO;
        [cell.selectbutton setImage:[UIImage imageNamed:@"cart_sure_num_select"] forState:UIControlStateNormal];}

    if ([selectnum.Selectnum isEqualToString:@"no"]) {
        cell.btnSelect=YES;
        [cell.selectbutton setImage:[UIImage imageNamed:@"cart_sure_num"] forState:UIControlStateNormal];
    }

     //cell中显示数据部分
    cell.kcTag.text=[NSString stringWithFormat:@"x%@",shoptart.sl];
    [cell.ShopCartPic setImageFromUrl:shoptart.cppic];
    cell.Producttitle.text=shoptart.cpmc;
    
            if (![self isNull:shoptart.chima]) {
        cell.cima.text=@"";
    }else{
        cell.cima.text=[NSString stringWithFormat:@"%@",shoptart.chima];}
    cell.price.text=[NSString stringWithFormat:@"%@",shoptart.dj];
    cell.Topborder=YES;
    cell.BottomBorder=YES;
    cell.BorderWidth=1.0;
    cell.title.text=@"";
    cell.countLabel.text=[NSString stringWithFormat:@"%@",shoptart.sl];
  
//点击cell中加减按钮处理事件
     ShopCartTableViewCell __weak *weakcell=cell;
    cell.didTapAddBtn=^{
    NSLog(@"addbtn");
        weakcell.ccont ++;
        weakcell.countLabel.text = [NSString stringWithFormat:@"%ld",(long)weakcell.ccont];
    };
    cell.didTapSubBtn=^{
        if (weakcell.ccont != 1) {
            weakcell.ccont --;
          }
        weakcell.countLabel.text = [NSString stringWithFormat:@"%ld",(long)weakcell.ccont];
    };
    
    
   // 点击cell后面修改按钮处理事件
   
    cell.didTapXGBtn=^{
          weakcell.kcTag.text= [NSString stringWithFormat:@"x%@", shoptart.sl];
          // 某行cell对应count和ctid修改后上传服务器
          cttid=weakcell.cartctid;
          count=weakcell.ccont;
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_EDITCART] delegate:self cancelIfExist:YES];
               [ZTCoverView alertCover];
        
           //再次请求数据刷新
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_GETCAR] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    };
    
    //点击cell前按钮处理事件
    
    NSMutableArray __weak*arry=arr;
    NSMutableArray __weak*weakselectproid=selectproid;
    cell.didTapSelectBtn=^{
        if (weakcell.btnSelect==NO) {
        NSLog(@"nimabinilma");
         // weakcell.selectbutton.tag=row;
        selectnum.Selectnum=@"yes";
       [weakselectproid addObject:selectnum];
                   totleselectnum++;
            select.text=[NSString stringWithFormat:@"已选 %ld件",(long)totleselectnum];
            CGFloat cellmoney=0.0000;
            cellmoney=[weakcell.price.text floatValue]*weakcell.ccont ;
            NSString*cellmoneyy=[NSString stringWithFormat:@"%lf",cellmoney];
            [arry addObject:cellmoneyy];
        }
        if (weakcell.btnSelect==YES) {
           // weakcell.selectbutton.tag=100;
             selectnum.Selectnum=@"no";
             [weakselectproid removeObject:selectnum];
            totleselectnum--;
             NSLog(@"cacacaca");
            select.text=[NSString stringWithFormat:@"已选 %ld件",(long)totleselectnum];
            CGFloat cellmoney=0.0000;
            cellmoney=[weakcell.price.text floatValue]*weakcell.ccont ;
            NSString*cellmoneyy=[NSString stringWithFormat:@"%lf",cellmoney];
            [arry removeObject:cellmoneyy];
        }
NSLog(@"%@",arry);
              sum=0.00;
        for (int i=0; i<arry.count; i++) {
               CGFloat cellmo= [arry[i] floatValue];
            sum+=cellmo;
        }

totlemoney.text=[NSString stringWithFormat:@"%@ ￥ %0.2f",@"总计",sum];

select.text=[NSString stringWithFormat:@"已选 %ld件",totleselectnum];
        [_buyBtn addTarget:self action:@selector(GoToPay:) forControlEvents:UIControlEventTouchUpInside];
    };
    [cell setNeedsLayout];
        return cell;
        }

-(void)GoToPay:(UIButton*)sender{
ShopCartOrderInfoTableViewController*vc=[[ShopCartOrderInfoTableViewController alloc]init];

vc.money=[NSString stringWithFormat:@"%f",sum];
NSLog(@"qunidaye%@",vc.money);
vc.CartProids=selectproid;
[self.navigationController pushViewController:vc animated:YES];
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger row = [indexPath row];
//    [self performSelector:NSSelectorFromString(btnes[row]) withObject:nil afterDelay:0];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   NSLog(@"11");
    return shopcartarr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ return 1;
}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETCAR]])
    {[shopcarttableview reloadData];
    totlemoney.text=@"00000.00";
    totlemoney.text=[NSString stringWithFormat:@"%@ ￥ %@",@"总计",totlemoney.text];
    totleselectnum=0;
    select.text=[NSString stringWithFormat:@"已选 %@件",@"0"];
    [arr removeAllObjects];
       shopcarttableview.hidden=NO;
       view.hidden=YES;
         }
if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_DELCART]])
{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex: NET_API_GETCAR] delegate:self cancelIfExist:YES];
        }
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
NSLog(@"qqqqqqqqqqqq%@",errmsg);
alertShow(errmsg);
    if ([errmsg isEqualToString:@"购物车为空"]) {
        shopcarttableview.hidden=YES;
        view=[[UIView alloc]init];
        tubiao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopbug"]];
        label=[[UILabel alloc]init];
        label.text=@"你购物车没有商品";
        label.font=[UIFont systemFontOfSize:12];
        bt=[[UIButton alloc]init];
        [view addSubViews:@[tubiao,label,bt]];
        [[[[[tubiao fitSize]setRectMarginTop:5]setRectMarginLeft:89]setRectHeight:60]setRectWidth:40];
        [[[[label fitSize]setRectBelowOfView:tubiao]addRectY:7]setRectMarginLeft:58];
        [[[[[bt  fitSize] setRectBelowOfView:label]setRectX:7] setRectHeight:40]setRectWidth:210];
        [view wrapContents];
        [self.view addSubview:view];
        [bt setTitle:@"随便逛逛"forState: UIControlStateNormal];
        
        [bt setBackgroundImage:[UIImage imageNamed:@"activebtn_no_select"] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"activebtn_select"] forState:UIControlStateHighlighted];
        
        [bt addTarget:self action:@selector(gotoshouye:) forControlEvents:UIControlEventTouchUpInside];
        [view setRectCenterInParent];
        totlemoney.text=@"00000.00";
        totlemoney.text=[NSString stringWithFormat:@"%@ ￥ %@",@"总计",totlemoney.text];
        totleselectnum=0;
        select.text=[NSString stringWithFormat:@"已选 %@件",@"0"];
    }
  

[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_EDITCART]]) {
        [params addEntriesFromDictionary:@{NET_ARG_EDITCART_CTID:[NSString stringWithFormat:@"%@",cttid],NET_ARG_EDITCART_TMSL:[NSString stringWithFormat:@"%ld",(long)count],
                                           }];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_DELCART]]) {
        [params addEntriesFromDictionary:@{NET_ARG_DELCART_CTID:[NSString stringWithFormat:@"%@",[self getctids]],
                                           }];
    }
}
    -(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
       
       NSLog(@"wocao%@",result);
        if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETCAR]])
        {
   NSArray *shopcar = [(NSArray*)result jsonParseToArrayWithType:[ShopCart class]];
                       shopcartarr=[NSMutableArray array];
            [shopcartarr removeAllObjects];
            [shopcartarr addObjectsFromArray:shopcar];
            NSLog(@"gouwuche%@gouwuche",shopcartarr);
            }
        
        if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_DELCART]]) {
            
        NSLog(@"sahnchu%@",result);
        }

    }
-(NSString*)getctids{

    NSMutableArray*ctids=[NSMutableArray array];
    for (ShopCart*shopcart in selectproid) {
        NSNumber*ctid= shopcart.ctid;
        [ctids addObject:ctid];
    }
    NSString *string = [ctids componentsJoinedByString:@","];
    
    return string;

}



@end
