//
//  CDAboutUsController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAboutUsController.h"
#import "CDAboutUsItem.h"
#import "CDAboutUsModel.h"
#import "CDAboutUsCell.h"
#import "CDBaseWKWebViewController.h"
#import "CDButtonTableFooterView.h"

@interface CDAboutUsController ()

@property (nonatomic, strong) CDAboutUsModel *aboutUsModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;

@end

@implementation CDAboutUsController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"关于我们";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView=self.footerView;
}

- (CDAboutUsModel *)aboutUsModel{
    if (_aboutUsModel==nil) {
        _aboutUsModel=[[CDAboutUsModel alloc]init];
    }
    return _aboutUsModel;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"登录"];
        _footerView.buttonClickBlock=^(UIButton *sender){
            
        };
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aboutUsModel.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[self.aboutUsModel.arrData cd_safeObjectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDAboutUsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDAboutUsCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellidentifier];
    }
    NSArray *arr=[self.aboutUsModel.arrData cd_safeObjectAtIndex:indexPath.section];
    CDAboutUsItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [self pushToWKWebViewControllerWithTitle:@"隐私声明" URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=yssm")];
                }
                    break;
                case 1:{
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 1:
                    [self showCallTelephoneAlert];
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    NSString *strUrl=@"http://m.weibo.cn/u/3547969482";
                    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
                    [self pushToWKWebViewControllerWithTitle:@"上海公积金微博" URLString:strUrl];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Events
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)showCallTelephoneAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"客服工作时间:周一至周六9:00-17:00(除法定假日外)\n现在是否拨打电话?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *actionCall=[UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self callThePhoneNum:@"12329"];
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionCall];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)callThePhoneNum:(NSString *)phoneNum{
    if ([CDDeviceModel isEqualToString:@"iPhone"]){
        NSURL *telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
        if ([[UIApplication sharedApplication]canOpenURL:telUrl]) {
            [[UIApplication sharedApplication] openURL:telUrl];
        }else{
            [self showAlertControllerWithTitle:@"提示" message:@"号码有误"];
        }
    }else {
        NSString *strAlert=[NSString stringWithFormat:@"您的设备 %@ 不支持电话功能！",CDDeviceModel];
        [self showAlertControllerWithTitle:@"提示" message:strAlert];
    }
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:actionCancel];
    [CDKeyWindow.rootViewController presentViewController:alert animated:YES completion:NULL];
}

@end
