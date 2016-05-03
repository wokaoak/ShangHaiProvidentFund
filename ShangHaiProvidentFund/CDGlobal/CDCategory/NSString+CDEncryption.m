//
//  NSString+CDEncryption.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "NSString+CDEncryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CDEncryption)

- (NSString *)cd_md5HexDigest{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return [ret lowercaseString];
}

- (NSString *)cd_sha1HexDigest
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        //        [output appendFormat:@"%02x", digest[i]];
        //定制加密规则
        NSString *strtemp=[NSString stringWithFormat:@"%02x",((digest[i] & 0xff) + 0x918)];
        strtemp = [strtemp substringFromIndex:1];
        [output appendString:strtemp];
    }
    return output;
}

@end

@implementation NSString (CDDateTransform)

- (NSDate *)cd_transformToDateWithDateFormat:(NSString *)dateFormat {
    if (!dateFormat) {
        dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    if (self.length<=0){
        return nil;
    }
    NSDateFormatter *tempFormat = [[NSDateFormatter alloc] init];
    [tempFormat setDateFormat:dateFormat];
    NSDate *date = [tempFormat dateFromString:self];
    return date;
}

- (NSMutableString*) cd_detleteCharacter:(NSString*) character{
    NSMutableString* oldString = [NSMutableString stringWithString:self];
    NSRange subRange = [oldString rangeOfString:character];
    while (subRange.location!=NSNotFound) {
        [oldString deleteCharactersInRange:subRange];
        subRange = [oldString rangeOfString:character];
    }
    return oldString;
}

- (NSDictionary *) cd_transformToDictionary {
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray* arr = [self componentsSeparatedByString:@"&"];
    for (__strong NSString * subString in arr) {
        subString = [subString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [subString rangeOfString:@"="];
        NSString* key = [subString substringToIndex:range.location];
        NSString* value = [subString substringWithRange:NSMakeRange(range.location+range.length, subString.length-(range.location+range.length))];
        [dic setObject:value forKey:key];
    }
    return dic;
}

@end

@implementation NSString (CDMatch)

- (BOOL)cd_isNonEmpty{
    return (self!=nil && self.length!=0);
}

- (BOOL)cd_matchingWithRules:(NSString *)rules{
    NSCharacterSet*cs = [[NSCharacterSet characterSetWithCharactersInString:rules] invertedSet];
    NSString*filtered =[[self componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

- (NSInteger)cd_matchingNumWithRegex:(NSString *)regex{
    NSRegularExpression *tRegularExpression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    //符合条件的有几个字符
    NSInteger tMatchCount = [tRegularExpression numberOfMatchesInString:self
                                                                options:NSMatchingReportProgress
                                                                  range:NSMakeRange(0, self.length)];
    return tMatchCount;
}

@end

@implementation NSString (NumberStringFormat)

-(NSString *)cd_numberStringFormat{
    if (self.length>0) {
        if ([self doubleValue]>=1000) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
            //            numberFormatter.locale = [NSLocale currentLocale];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            numberFormatter.usesGroupingSeparator = YES;
            NSNumber *number = [numberFormatter numberFromString:self];
            return [numberFormatter stringFromNumber:number];
        }
    }
    return self;
}

@end
