//
//  CellRenderProtocol.h
//  MyTreasure
//
//  Created by 11151221040532 on 2017/11/1.
//  Copyright © 2017年 宋玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellRenderProtocol <NSObject>

@required
/**
 Cell对应的重用标识

 @return cell重用字符串
 */
- (NSString *)cellIdentifier;
@end
