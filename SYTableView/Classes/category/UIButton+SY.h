//
//  UIButton+SY.h
//  SYTableView
//
//  Created by Apple on 2019/6/15.
//  Copyright © 2019 songyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SY)
- (void)clickButtonWithEvent:(UIControlEvents)event action:(void(^)(UIButton *sender))action;
@end

NS_ASSUME_NONNULL_END
