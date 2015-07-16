//
//  HomeTabBarController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "HomeTabBarController.h"
#import "NearController.h"
#import "ActivitiesController.h"
#import "MeController.h"
#import "MeSecondViewController.h"
#import "SaleController.h"
#import "IZhongTuanShopViewController.h"
#import "IZhongTuanshoppingtrolleyViewController.h"
#import "CategorySecondViewController.h"

@interface HomeTabBarController ()

@end

@implementation HomeTabBarController

- (instancetype)init
{
    self = [super init];
    
    if (self) {

        UINavigationController *nearNavigation = [[UINavigationController alloc] initWithRootViewController:[[CategorySecondViewController alloc] init]];
        UINavigationController *saleTabController = [[UINavigationController alloc] initWithRootViewController:[[SaleController alloc] init]];
        UINavigationController *acvivitiesTabController = [[UINavigationController alloc] initWithRootViewController:[[IZhongTuanshoppingtrolleyViewController alloc] init]];
        UINavigationController *meTabController = [[UINavigationController alloc] initWithRootViewController:[[MeSecondViewController alloc] init]];
        [self setViewControllers:@[saleTabController,nearNavigation,acvivitiesTabController,meTabController]];
        
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setTitle:@"首页"];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setTitle:@"分类"];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setTitle:@"购物车"];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setTitle:@"我的"];
        
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"tab_sale_nol"]];
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_sale_sel"]];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setImage:[UIImage imageNamed:@"Shop_No_Select"]];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setSelectedImage:[UIImage imageNamed:@"Shop_Select"]];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setImage:[UIImage imageNamed:@"ShopCar_No_Select"]];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setSelectedImage:[UIImage imageNamed:@"ShopCar_Select"]];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setImage:[UIImage imageNamed:@"tab_me_nol"]];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_me_sel"]];

        self.tabBar.tintColor = [UIColor redColor];
        self.tabBar.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}


@end
