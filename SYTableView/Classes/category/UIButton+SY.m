//
//  UIButton+SY.m
//  SYTableView
//
//  Created by Apple on 2019/6/15.
//  Copyright © 2019 songyu. All rights reserved.
//

#import "UIButton+SY.h"
#import <objc/message.h>

@implementation UIButton (SY)
- (void)clickButtonWithEvent:(UIControlEvents)event action:(void (^)(UIButton * _Nonnull))action {
    if (action) {
        objc_setAssociatedObject(self, _cmd, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addTarget:self action:@selector(buttonClick) forControlEvents:event];
}

- (void)buttonClick {
    void (^block)(UIButton *button);
    block = objc_getAssociatedObject(self, @selector(clickButtonWithEvent:action:));
    block(self);
}
@end
