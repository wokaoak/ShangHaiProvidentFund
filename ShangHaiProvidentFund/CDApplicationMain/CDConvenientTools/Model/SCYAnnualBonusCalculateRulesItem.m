//
//  SCYAnnualBonusCalculateRulesItem.m
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusCalculateRulesItem.h"

@interface SCYAnnualBonusCalculateRulesItem ()

@property (nonatomic, copy) NSString *left;
@property (nonatomic, copy) NSString *center;
@property (nonatomic, copy) NSString *right;

@end

@implementation SCYAnnualBonusCalculateRulesItem

+ (SCYAnnualBonusCalculateRulesItem *)itemWithLeft:(NSString *)left center:(NSString *)center right:(NSString *)right{
    SCYAnnualBonusCalculateRulesItem *item=[[self alloc]init];
    item.left=left;
    item.center=center;
    item.right=right;
    return item;
}

@end
