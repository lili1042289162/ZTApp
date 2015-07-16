//
//  CategorySecondViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/7/10.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CategorySecondViewController.h"
#import "ZTTitleLabel.h"
#import "ShopTableViewCell.h"
#import "ZTCoverView.h"
#import "dalei.h"
#import "ZTButtonGridView.h"
#import "ZTButtonCell.h"
#import "SaleProduct.h"
#import "Girlclothes.h"
@interface CategorySecondViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol,ZTButtonGridViewDelegate>{
    ZTTitleLabel*titleview;
    UIView* topview;
    UITableView*Categorylisttableview;
    NSArray*array;
    NSMutableArray*leibie;
    NSMutableArray*daleibie;
    NSMutableArray*women;
    NSMutableArray*men;
    NSMutableArray*jiaju;
    NSMutableArray*shuma;
    NSMutableArray*muying;
    NSMutableArray*nanzhuang;
    NSMutableArray*shiping;
    NSDictionary*dateresources;
    ZTButtonGridView*growview;
    NSInteger row ;
}
@end
@implementation CategorySecondViewController
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
    [self initdata];
    }
-(void)initTitleView{
    titleview=[[ZTTitleLabel alloc]initWithTitle:@"分类"];
    [titleview fitSize];
    self.navigationItem.titleView=titleview;
}
-(void)initView{
    topview=(UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initTableView];
    [self.view addSubViews:@[Categorylisttableview]];
    
}
-(void)buildrightview{

    growview = [[ZTButtonGridView alloc] initWithIcons:dateresources cell:@"ZTButtonCell" column:3 rowSpace:1.0 columnSpace:1.0 edgeSpace:1.0  version:@"second"];
    NSLog(@"growview%@data%@",growview,dateresources);
    growview.tag=@"0";
       growview.bottomBorder = YES;
    growview.borderWidth = 1.0;
    growview.ztButtonViewDelegate=self;
    [self.view addSubview:growview];
}
-(void)initTableView{
  //  Categorylisttableview=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    NSLog(@"doitdo");
    Categorylisttableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 20, 50, 320) style:UITableViewStylePlain];

    Categorylisttableview.showsHorizontalScrollIndicator=NO;
    Categorylisttableview.showsVerticalScrollIndicator=NO;
    Categorylisttableview.dataSource=self;
    Categorylisttableview.delegate=self;
    Categorylisttableview.scrollEnabled=NO;
    Categorylisttableview.backgroundColor=[UIColor clearColor];
    Categorylisttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [Categorylisttableview registerClass:[ShopTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)viewDidLayoutSubviews{
[Categorylisttableview setRectBelowOfView:topview];
[[[[growview setRectBelowOfView:topview]addRectY:20]setRectOnRightSideOfView:Categorylisttableview]addRectX:10];
}
#pragma mark tableview data
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
     row = [indexPath row];
dalei*catagory=leibie[row];
NSLog(@"ceshilma%@",catagory.lbname);
   cell.Shoptitle.text=[NSString stringWithFormat:@"%@",catagory.lbname];
   NSLog(@"cehishishisihi%@",cell.Shoptitle.text);
   cell.Topborder=YES;
    cell.BottomBorder=YES;
   cell.BorderWidth=2.0;
    [cell setNeedsLayout];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger roww = [indexPath row];
    
    if (roww==0) {
     [growview removeFromSuperview];
         NSMutableArray*onepicurls=[NSMutableArray array];
           NSMutableArray*onewenzi=[NSMutableArray array];
        for (dalei*one in women) {
            [onepicurls addObject:one.icon];
            [onewenzi addObject:one.lbname];}
        dateresources=@{
                      @"icons":onepicurls,
                           @"titles":onewenzi,
                          };
                          NSLog(@"asasa%@",dateresources);
        [self buildrightview];
        
    }if (roww==1) {
    [growview removeFromSuperview];
        NSMutableArray*twopicurls=[NSMutableArray array];
        NSMutableArray*twowenzi=[NSMutableArray array];
        for (dalei*two in men) {
            [twopicurls addObject:two.icon];
            [twowenzi addObject:two.lbname];}
        dateresources=@{
                        @"icons":twopicurls,
                        @"titles":twowenzi,
                        };
        NSLog(@"asasa%@",dateresources);
        [self buildrightview];

    
        NSLog(@"men1");
    }if (roww==2) {
     [growview removeFromSuperview];
        NSMutableArray*twopicurls=[NSMutableArray array];
        NSMutableArray*twowenzi=[NSMutableArray array];
        for (dalei*two in jiaju) {
            [twopicurls addObject:two.icon];
            [twowenzi addObject:two.lbname];}
        dateresources=@{
                        @"icons":twopicurls,
                        @"titles":twowenzi,
                        };
        NSLog(@"asasa%@",dateresources);
        [self buildrightview];
        NSLog(@"jiaju2");
    }if (roww==3) {
     [growview removeFromSuperview];
        NSMutableArray*thirdpicurls=[NSMutableArray array];
        NSMutableArray*thirdwenzi=[NSMutableArray array];
        for (dalei*third in shuma) {
            [thirdpicurls addObject:third.icon];
            [thirdwenzi addObject:third.lbname];}
        dateresources=@{
                        @"icons":thirdpicurls,
                        @"titles":thirdwenzi,
                        };
        NSLog(@"asasa%@",dateresources);
        [self buildrightview];
        NSLog(@"shuma3");
    }if (roww==4) {
     [growview removeFromSuperview];
        NSMutableArray*fourpicurls=[NSMutableArray array];
        NSMutableArray*fourwenzi=[NSMutableArray array];
        for (dalei*four in muying) {
            [fourpicurls addObject:four.icon];
            [fourwenzi addObject:four.lbname];}
        dateresources=@{
                        @"icons":fourpicurls,
                        @"titles":fourwenzi,
                        };
        NSLog(@"asasa%@",dateresources);
        [self buildrightview];
        NSLog(@"muying4");
    }if (roww==5) {
     [growview removeFromSuperview];
        NSMutableArray*fivepicurls=[NSMutableArray array];
        NSMutableArray*fivewenzi=[NSMutableArray array];
        for (dalei*five in nanzhuang) {
            [fivepicurls addObject:five.icon];
            [fivewenzi addObject:five.lbname];}
        dateresources=@{
                        @"icons":fivepicurls,
                        @"titles":fivewenzi,
                        };
        NSLog(@"asasa%@",dateresources);
        [self buildrightview];
        NSLog(@"nanzhuang5");
    }if (roww==6) {
     [growview removeFromSuperview];
        NSMutableArray*sixpicurls=[NSMutableArray array];
        NSMutableArray*sixwenzi=[NSMutableArray array];
        for (dalei*six in shiping) {
            [sixpicurls addObject:six.icon];
            [sixwenzi addObject:six.lbname];}
        dateresources=@{
                        @"icons":sixpicurls,
                        @"titles":sixwenzi,
                        };
        NSLog(@"shipinga%@",dateresources);
        [self buildrightview];
        NSLog(@"shiping6");
        
    }

}
#pragma click
-(void)didTapCollectionAtIndex:(NSIndexPath*)index{
   
        //dalei*daleilei=leibie[index.row];
       dalei*onewomen=women[index.row];
        Girlclothes*girlvc=[[Girlclothes alloc]init];
        girlvc.gril=onewomen.lbid;
        girlvc.lanamee=onewomen.lbname;
        [self.navigationController pushViewController:girlvc animated:YES];
 NSLog(@"首页哦gggghah%ld",(long)index.row);
        
//        dalei*daleilei=leibie[index.row];
//        Girlclothes*girlvc=[[Girlclothes alloc]init];
//        girlvc.gril=daleilei.lbid;
//        girlvc.lanamee=daleilei.lbname;
//        
//        [self.navigationController pushViewController:girlvc animated:YES];
        
    
    
    
    NSLog(@"首页哦hah%ld",(long)index.row);
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return daleibie.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)initdata{
    // 获取特卖大类
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMLB] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
        [Categorylisttableview reloadData];
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

    NSLog(@"daleilei%@",result);
    NSArray *leibiee = [(NSArray*)result jsonParseToArrayWithType:[dalei class]];
    leibie=[NSMutableArray array];
    [leibie addObjectsFromArray:leibiee];
    daleibie=[NSMutableArray array];
    women=[NSMutableArray array];
    men=[NSMutableArray array];
    jiaju=[NSMutableArray array];
    shuma=[NSMutableArray array];
    muying=[NSMutableArray array];
    nanzhuang=[NSMutableArray array];
    shiping=[NSMutableArray array];
    for (dalei*catagary in leibie) {
        

      if([catagary.cup integerValue]==0){
        [daleibie addObject:catagary];
       NSLog(@"%@yyyyy",catagary.lbname);}
        if ([catagary.cup integerValue]== 1) {
            [women addObject:catagary];
             NSLog(@"%@women",catagary.lbname);
        }if ([catagary.cup integerValue]== 15) {
            [men addObject:catagary];
             NSLog(@"%@men",catagary.lbname);
        }if ([catagary.cup integerValue]==16) {
            [jiaju addObject:catagary];
              NSLog(@"%@jiaju",catagary.lbname);
        }if ([catagary.cup integerValue]==17) {
            [shuma addObject:catagary];
              NSLog(@"%@shuma",catagary.lbname);
        }if ([catagary.cup integerValue]==18) {
            [muying addObject:catagary];
              NSLog(@"%@muying",catagary.lbname);
        }if ([catagary.cup integerValue]==20) {
            [nanzhuang addObject:catagary];
              NSLog(@"%@nanzhuang",catagary.lbname);
        }if ([catagary.cup integerValue]== 50) {
            [shiping addObject:catagary];
              NSLog(@"%@shiping",catagary.lbname);
        }

    }
    
      }


@end




