//
//  CDOpinionsSuggestionsService.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDCommitMessageService : CDJSONBaseNetworkService

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show;

@end
