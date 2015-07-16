//
//  IZhongTuanShopViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/20.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "IZhongTuanShopViewController.h"
#import "ZTTitleLabel.h"
#import "ShopTableViewCell.h"
#import "ShopModel.h"
#import "ZTCoverView.h"
#import "SaleProduct.h"
#import "ShopTableViewCell.h"
#import "StoreViewController.h"

@interface IZhongTuanShopViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
    ZTTitleLabel*titleview;
    UIView* topview;
    UITableView*Shoplisttableview;
    NSArray*array;
    NSMutableArray*ShopList;
}
@end
@implementation IZhongTuanShopViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    [self initdata];}
-(void)initTitleView{
    titleview=[[ZTTitleLabel alloc]initWithTitle:@"推荐店铺"];
    [titleview fitSize];
    self.navigationItem.titleView=titleview;
}
-(void)initView{
    topview=(UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initTableView];
    [self.view addSubview:Shoplisttableview];
    
}
-(void)initTableView{
    Shoplisttableview=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    //Shoplisttableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    Shoplisttableview.showsHorizontalScrollIndicator=NO;
    Shoplisttableview.showsVerticalScrollIndicator=NO;
    Shoplisttableview.dataSource=self;
    Shoplisttableview.delegate=self;
    Shoplisttableview.backgroundColor=[UIColor clearColor];
    Shoplisttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [Shoplisttableview registerClass:[ShopTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark tableview data
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 175;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell=[[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
//    NSInteger row = [indexPath row];
//    ShopModel *shop = ShopList[row];
//    [cell.ShopPic setImageFromUrl:shop.adpic];
//    NSLog(@"bababa%@",shop.shopname);
//    cell.Shoptitle.text=shop.shopname;
//    cell.ShopWords.text=shop.tgword;
//    cell.collects.text=[NSString stringWithFormat:@"收藏 ：%@",shop.collects];
//    cell.models.text=[NSString stringWithFormat:@"商品 : %@",shop.models];
//    cell.Topborder=YES;
//    cell.BottomBorder=YES;
//    cell.BorderWidth=2.0;
//    [cell setNeedsLayout];
    
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel*p=ShopList[indexPath.row];
   StoreViewController *controller = [StoreViewController new];
    controller.shopidd=p.sid;
    // self.navigationController.navigationBar.topItem.title = @"返回";
    [self.navigationController pushViewController:controller animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ShopList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(void)initdata{
    
    
//    array=[self.adds.gotocontent componentsSeparatedByString:@"|"];
//    NSLog(@"arrayqqq%@",array[1]);
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMSHOP] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
    
    
}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    [ZTCoverView dissmiss];
    alertShow(errmsg);
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMSHOP]])
    {[params addEntriesFromDictionary:
      @{
        NET_ARG_GETTMSHOP_PAGE:[NSString stringWithFormat:@"%@",@"0"],}];}
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMSHOP]]){
    
    
    NSLog(@"shopshop%@",result);
    
        NSArray *sorteAry = [(NSArray*)result sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            /// TODO: add other data type compare eg:date,time
            //这里排序有问题第一次和第二次结果相反
            NSNumber *v1 = [obj1 valueForKey:@"xh"];
            NSNumber *v2 = [obj2 valueForKey:@"xh"];
            if (v1 < v2) {
                return NSOrderedAscending ;
            }else{
            return NSOrderedDescending;
            }
        }];

    NSLog(@"asasa%@",sorteAry);
NSArray *tm_shops = [(NSArray*)sorteAry jsonParseToArrayWithType:[ShopModel class]];
        NSLog(@"nimeia%@save",tm_shops);
        ShopList =[NSMutableArray array];
        [ShopList addObjectsFromArray:tm_shops];
        
        NSLog(@"nime%@save",ShopList);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [Shoplisttableview reloadData];
            
        });
        
    }
}

@end
