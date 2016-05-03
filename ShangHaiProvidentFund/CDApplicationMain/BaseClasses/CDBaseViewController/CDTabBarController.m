//
//  CDTabBarController.m
//  CDAppDemo
//
//  Created by cdd on 15/10/22.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDTabBarController.h"
#import "CDNavigationController.h"
#import "UIImage+CDImageAdditions.h"
#import "CDNewsAndTrendsController.h"
#import "CDMineAccountController.h"
#import "CDConvenientToolsController.h"
#import "CDAboutUsController.h"

@interface CDTabBarController ()

@end

@implementation CDTabBarController

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.barTintColor=colorForHex(@"#01b2d3");
    [self.tabBar setTintColor:[UIColor whiteColor]];
    //去除顶部的线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage cd_imageWithColor:colorForHex(@"#01b2d3")]];
//    [[UITabBar appearance]setShadowImage:[UIImage new]];
//    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"minecenter_headbackground"]];
    
    //设置UITabBarItem Title颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor darkGrayColor]} forState:UIControlStateNormal];//NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]} forState:UIControlStateSelected];
    
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    CDNewsAndTrendsController *oneVC = [[CDNewsAndTrendsController alloc]init];
    [self setUpOneChildViewController:oneVC image:[UIImage imageNamed:@"tab_home_normal"] title:@"新闻动态"];
    
    CDMineAccountController *twoVC = [[CDMineAccountController alloc]init];
    [self setUpOneChildViewController:twoVC image:[UIImage imageNamed:@"tab_mine_normal"] title:@"账户查询"];
    
    CDConvenientToolsController *threeVC = [[CDConvenientToolsController alloc]init];
    [self setUpOneChildViewController:threeVC image:[UIImage imageNamed:@"tab_product_normal"] title:@"便民工具"];
    
    CDAboutUsController *fourVC = [[CDAboutUsController alloc]init];
    [self setUpOneChildViewController:fourVC image:[UIImage imageNamed:@"tab_settingicon"] title:@"关于我们"];
}

- (void)setupMineCenterChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectimage title:(NSString *)title{
    CDNavigationController *navC = [[CDNavigationController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = selectimage;
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    CDNavigationController *navC = [[CDNavigationController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage=image;
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
