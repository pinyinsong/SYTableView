//
//  SYTableViewCellModel.m
//  futures
//
//  Created by 宋玉 on 2018/12/26.
//  Copyright © 2018 拼音. All rights reserved.
//

#import "SYTableViewCellModel.h"

@implementation SYTableViewCellModel
@class Object;
- (instancetype)initWithEnity:(Object *)enity {
    self = [super init];
    if (self) {
        _enity = enity;
    }
    return self;
}

- (NSString *)cellIdentifier {
    return @"";
}
@end
