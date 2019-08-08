//
//  AddViewController.h
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddViewControllerDelegate <NSObject>
- (void)addArray:(NSMutableArray *)array;

@end
@interface AddViewController : UIViewController

@property NSMutableArray *addMutableArray;

@property id<AddViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
