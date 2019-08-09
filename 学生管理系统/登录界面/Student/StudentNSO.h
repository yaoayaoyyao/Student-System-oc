//
//  StudentNSO.h
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/7.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentNSO : NSObject

@property (nonatomic, copy) NSString *nameStu;
@property (nonatomic,copy) NSString *numberStu;
@property (nonatomic,copy) NSString *classStu;
@property (nonatomic,copy) NSString *ageStu;
@property (nonatomic,copy) NSString *gradeStu;

- (BOOL)judgeOfName:(NSString *)string;
- (BOOL)judgeOfClass:(NSString *)string;
- (BOOL)judgeOfNumber:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
