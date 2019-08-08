//
//  ResighViewController.h
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  ResighViewControllerDelegate<NSObject>
- (void)pass:(NSString *)str pass1:(NSString *)str1 andpassArray:(NSMutableArray *)array;

@end
@interface ResighViewController : UIViewController

@property NSMutableArray *resighMutableArray;
//这里用assign而不用retain是为了防止引起循环引用。
@property (nonatomic, weak)id<ResighViewControllerDelegate>resighDelegate;
@end

NS_ASSUME_NONNULL_END
