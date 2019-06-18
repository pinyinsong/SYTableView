//
//  SYTableView.h
//  futures
//
//  Created by 宋玉 on 2018/12/26.
//  Copyright © 2018 拼音. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol SYTableViewDelegate <NSObject>
@optional
- (void)sy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(id)model;
- (void)sy_tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
- (BOOL)sy_tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)sy_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)sy_tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)sy_tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)sy_tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath model:(id)model;
- (NSString *)sy_tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol SYTableViewScrollViewDelegate <NSObject>
@optional
- (void)sy_scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

- (void)sy_scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)sy_scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@protocol SYTableViewHeader_FooterViewDelegate <NSObject>
@optional
- (UIView *)sy_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (CGFloat)sy_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (UIView *)sy_tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (CGFloat)sy_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
@end

@protocol SYTableViewControlDelegate <NSObject>
- (void)sy_inTableview:(UITableView *)tableView buttonEvent:(UIButton *)button model:(id)model index:(NSIndexPath *)indexPath;
- (void)sy_inTableView:(UITableView *)tableView hasKindOfControl:(UIControl *)control model:(id)model index:(NSIndexPath *)indexPath;
@end

@interface SYTableView : UITableView 
@property (nonatomic, strong) id data;

@property (nonatomic, weak) id<SYTableViewDelegate> syDelegate;
@property (nonatomic, weak) id<SYTableViewScrollViewDelegate> scrollDelegate;
@property (nonatomic, weak) id<SYTableViewHeader_FooterViewDelegate> header_footerViewDelegate;
@property (nonatomic, weak) id<SYTableViewControlDelegate> controlDelegate;
@end

NS_ASSUME_NONNULL_END
