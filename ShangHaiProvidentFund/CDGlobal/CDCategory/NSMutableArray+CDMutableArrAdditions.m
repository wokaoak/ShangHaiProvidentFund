//
//  NSMutableArray+CDMutableArrAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "NSMutableArray+CDMutableArrAdditions.h"

@implementation NSMutableArray (CDMutableArrAdditions)

- (void)cd_reverse {
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
        i++;
        j--;
    }
}

- (void)cd_safeAddObject:(id)anObject{
    if(!anObject) {
        NSLog(@"--- addObject:object must not nil ---");
        return;
    }
    [self addObject:anObject];
}

- (void)cd_safeInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- insertObject:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- insertObject:atIndex: object must not nil ---");
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)cd_safeRemoveObjectAtIndex:(NSUInteger)index{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- removeObjectAtIndex: out of array range ---");
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)cd_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: object must not nil ---");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (id)cd_safeObjectAtIndex:(NSUInteger)index{
    if(self.count == 0) {
        NSLog(@"--- mutableArray have no objects ---");
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- index:%li out of mutableArray range ---", (long)index);
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

@end
