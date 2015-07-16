//
//  DisCountViewController.m
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "DisCountViewController.h"
#import "ZTTitleLabel.h"
#import "DisCountTableViewCell.h"
#import "DisCountmodel.h"
#import "SaleOrderViewController.h"
@interface DisCountViewController ()<UITableViewDataSource,UITableViewDelegate>{
ZTTitleLabel*_titleView;
UITableView*DisTbleView;
BOOL select;
}

@end

@implementation DisCountViewController

- (void)viewDidLoad {
[super viewDidLoad];
[self initTitleBar];
[self initView];
}
-(void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden=YES;
NSLog(@"111111%@",self.QuanArr);

}
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"优惠劵"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;

}
-(void)initView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
        [self initTableView];
    [self.view addSubview:DisTbleView];
   }
-(void)initTableView{
    DisTbleView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    DisTbleView.showsHorizontalScrollIndicator = NO;
    DisTbleView.showsVerticalScrollIndicator = NO;
    DisTbleView.delegate = self;
    DisTbleView.dataSource = self;
    DisTbleView.backgroundColor = [UIColor clearColor];
    DisTbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   [DisTbleView registerClass:[DisCountTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableview Delegate
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    long row=[indexPath row];
    DisCountmodel*discount=self.QuanArr[row];
    
    
    NSString *nstring =discount.edate ;
    NSArray *arrayedate = [nstring componentsSeparatedByString:@" "];

    cell.tmquno.text=[NSString stringWithFormat:@"编号：%@",discount.tmqno];
    cell.etime.text=arrayedate[0];
    cell.stime.text=@"截止日期：";
    cell.tmQuanmc.text=discount.tmqmc;
    cell.tmQuanmc.textColor = [UIColor redColor];
    cell.DisCountMoney.text=[NSString stringWithFormat:@"%@元",discount.tmqje];
    if ([discount.shopid integerValue]==0) {
        cell.DisCountType.text=[ NSString stringWithFormat:@"全场通用      订单满:%@才可使用",discount.ordje] ;
    }
    else{
     cell.DisCountType.text=[ NSString stringWithFormat:@"仅限店铺使用      订单满:%@才可使用",discount.ordje] ;    }
    cell.LimitMoney.text=[NSString stringWithFormat:@"%@",discount.ordje];
    
         return  cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.QuanArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        long row=[indexPath row];
        DisCountmodel*discount=self.QuanArr[row];
    if ([discount.select isEqualToString:@"no"]) {
        self.delegate.Quanmc=@"选择使用优惠劵";
    self.delegate.Quanzhi=[NSString stringWithFormat:@"%@",@"金额"];
        discount.select=@"yes";
         self.delegate.rrow=100;
        NSLog(@"3122222");
        
       self.delega.Quanmcb=@"选择使用优惠劵";
         self.delega.Quanzhib=[NSString stringWithFormat:@"%@",@"金额"];
        discount.select=@"yes";
        self.delega.roww=100;
        
         [self.navigationController popViewControllerAnimated:YES];
    }
      else if ([discount.select isEqualToString:@"yes"])
    {
        self.delegate.quanno=discount.tmqno;
        NSLog(@"aaa111aaa%@",discount.tmqno);
        self.delegate.Quanmc=discount.tmqmc;
        self.delegate.Quanzhi=[NSString stringWithFormat:@"%@",discount.tmqje];
         self.delegate.rrow=row;
         NSLog(@"4122222");
        self.delega.quanhao=discount.tmqno;
        self.delega.Quanmcb=discount.tmqmc;
        self.delega.Quanzhib=[NSString stringWithFormat:@"%@",discount.tmqje];
        self.delega.roww=row;
        
          [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

@end
