//
//  CellProtocol.h
//  MyTreasure
//
//  Created by 11151221040532 on 2017/11/1.
//  Copyright © 2017年 宋玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellRenderProtocol;

@protocol CellProtocol <NSObject>

@required
/**
 绑定数据

 @param viewModel ViewModel
 */
- (void)bindViewModel:(id<CellRenderProtocol>)viewModel inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@optional
/** cell高度*/
+ (CGFloat)heightForCellRowTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(id<CellRenderProtocol>)viewModel;

/**
 所有继承UIControl的子类的集合
 */
- (NSArray<UIControl *> *)cellControls;
@end
