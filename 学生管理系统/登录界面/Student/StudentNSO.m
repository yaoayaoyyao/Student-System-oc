//
//  StudentNSO.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/7.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "StudentNSO.h"

@implementation StudentNSO

- (BOOL)judgeOfClass:(NSString *)string{
    NSCharacterSet *non = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    int value = [[string stringByTrimmingCharactersInSet:non]intValue];
    if (value == 0) {
        return NO;
    }
    if (value / 1000 == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)judgeOfName:(NSString *)string{
    NSCharacterSet *non = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    int value = [[string stringByTrimmingCharactersInSet:non]intValue];
    if (value == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)judgeOfNumber:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (void)setNameStu:(NSString *)nameStu{
    if ([self judgeOfName:nameStu]) {
        _nameStu = nameStu;
    } else {
        return;
    }
}

- (void)setNumberStu:(NSString *)numberStu{
    if ([self judgeOfNumber:numberStu]) {
        _numberStu = numberStu;
    } else {
        return;
    }
}

- (void)setClassStu:(NSString *)classStu{
    if ([self judgeOfClass:classStu]) {
        _classStu = classStu;
    } else {
        return;
    }
}

- (void)setAgeStu:(NSString *)ageStu{
    if ([self judgeOfNumber:ageStu]) {
        _ageStu = ageStu;
    } else {
        return;
    }
}

- (void)setGradeStu:(NSString *)gradeStu{
    if ([self judgeOfNumber:gradeStu]) {
        _gradeStu = gradeStu;
    } else {
        return;
    }
}


@end
