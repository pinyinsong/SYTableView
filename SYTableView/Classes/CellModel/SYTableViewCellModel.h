//
//  SYTableViewCellModel.h
//  futures
//
//  Created by 宋玉 on 2018/12/26.
//  Copyright © 2018 拼音. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellRenderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYTableViewCellModel<__covariant Object> : NSObject <CellRenderProtocol>
- (instancetype)initWithEnity:(Object)enity;

@property (nonatomic, readonly) Object enity;
@end

NS_ASSUME_NONNULL_END
