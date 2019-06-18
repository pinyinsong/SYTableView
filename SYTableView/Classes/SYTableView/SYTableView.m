//
//  SYTableView.m
//  futures
//
//  Created by 宋玉 on 2018/12/26.
//  Copyright © 2018 拼音. All rights reserved.
//

#import "SYTableView.h"
#import "CellProtocol.h"
#import "CellRenderProtocol.h"
#import "SYTableViewCellModel.h"
#import "UIButton+SY.h"


@interface SYTableView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *allkeys;
@end

@implementation SYTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.data isKindOfClass:[NSArray class]]) {
        return 1;
    } else if ([self.data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dictionary = self.data;
        self.allkeys = dictionary.allKeys;
        self.allkeys = [self.allkeys sortedArrayUsingSelector:@selector(compare:)];
        return self.allkeys.count;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray *array = self.data;
        return array.count;
    } else {
        NSDictionary *dictionary = self.data;
        NSString *key = [self.allkeys objectAtIndex:section];
        return [[dictionary objectForKey:key] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray *array = self.data;
        SYTableViewCellModel *cellModel = array[indexPath.row];
        return [self configTableViewCellWithCellModel:cellModel inTableView:tableView atIndexPath:indexPath];
    } else {
        NSDictionary *dictionary = self.data;
        NSString *key = [self.allkeys objectAtIndex:indexPath.section];
        SYTableViewCellModel *cellModel = [dictionary objectForKey:key][indexPath.row];
        return [self configTableViewCellWithCellModel:cellModel inTableView:tableView atIndexPath:indexPath];
    }
}

- (UITableViewCell *)configTableViewCellWithCellModel:(SYTableViewCellModel *)cellModel inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([cellModel respondsToSelector:@selector(cellIdentifier)]) {
        NSString *cellClassStr = [cellModel cellIdentifier];
        id<CellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:cellClassStr];
        if (!cell) {
            cell = [[NSClassFromString(cellClassStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassStr];
        }
        [cell bindViewModel:cellModel inTableView:self atIndexPath:indexPath];
        [cell.cellControls enumerateObjectsUsingBlock:^(UIControl * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)obj;
                [button clickButtonWithEvent:UIControlEventTouchUpInside action:^(UIButton * _Nonnull sender) {
                    if ([self.controlDelegate respondsToSelector:@selector(sy_inTableview:buttonEvent:model:index:)]) {
                        [self.controlDelegate sy_inTableview:tableView buttonEvent:button model:cellModel.enity index:indexPath];
                    }
                }];
            } else {
                if ([self.controlDelegate respondsToSelector:@selector(sy_inTableView:hasKindOfControl:model:index:)]) {
                    [self.controlDelegate sy_inTableView:tableView hasKindOfControl:obj model:cellModel.enity index:indexPath];
                }
            }
        }];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray *array = self.data;
        id<CellRenderProtocol> cellModel = array[indexPath.row];
        Class cellClass = NSClassFromString([cellModel cellIdentifier]);
        if ([cellClass respondsToSelector:@selector(heightForCellRowTableView:indexPath:viewModel:)]) {
            return [cellClass heightForCellRowTableView:tableView indexPath:indexPath viewModel:cellModel];
        }
        return 44.f;
    } else {
        NSDictionary *dictionary = self.data;
        NSString *key = [self.allkeys objectAtIndex:indexPath.section];
        id<CellRenderProtocol> cellModel = [dictionary objectForKey:key][indexPath.row];
        Class cellClass = NSClassFromString([cellModel cellIdentifier]);
        if ([cellClass respondsToSelector:@selector(heightForCellRowTableView:indexPath:viewModel:)]) {
            return [cellClass heightForCellRowTableView:tableView indexPath:indexPath viewModel:cellModel];
        }
        return 44.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray *array = self.data;
        SYTableViewCellModel *cellModel = array[indexPath.row];
        if (cellModel.enity) {
            if ([self.syDelegate respondsToSelector:@selector(sy_tableView:didSelectRowAtIndexPath:model:)]) {
                [self.syDelegate sy_tableView:tableView
                      didSelectRowAtIndexPath:indexPath model:cellModel.enity];
            }
        }
    }
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = self.data;
        NSString *key = [self.allkeys objectAtIndex:indexPath.section];
        SYTableViewCellModel *cellModel = [dictionary objectForKey:key][indexPath.row];
        if (cellModel.enity) {
            if ([self.syDelegate respondsToSelector:@selector(sy_tableView:didSelectRowAtIndexPath:model:)]) {
                [self.syDelegate sy_tableView:tableView
                      didSelectRowAtIndexPath:indexPath model:cellModel.enity];
            }
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(sy_scrollViewWillBeginDecelerating:)]) {
        [self.scrollDelegate sy_scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(sy_scrollViewWillBeginDragging:)]) {
        [self.scrollDelegate sy_scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(sy_scrollViewDidScroll:)]) {
        [self.scrollDelegate sy_scrollViewDidScroll:scrollView];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.header_footerViewDelegate respondsToSelector:@selector(sy_tableView:viewForHeaderInSection:)]) {
        return [self.header_footerViewDelegate sy_tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.header_footerViewDelegate respondsToSelector:@selector(sy_tableView:heightForHeaderInSection:)]) {
        return [self.header_footerViewDelegate sy_tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.header_footerViewDelegate respondsToSelector:@selector(sy_tableView:viewForFooterInSection:)]) {
        return [self.header_footerViewDelegate sy_tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.header_footerViewDelegate respondsToSelector:@selector(sy_tableView:heightForFooterInSection:)]) {
        return [self.header_footerViewDelegate sy_tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.syDelegate respondsToSelector:@selector(sy_tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.syDelegate sy_tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing && [self.syDelegate respondsToSelector:@selector(sy_tableView:canMoveRowAtIndexPath:)]) {
        return [self.syDelegate sy_tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.editing && [self.syDelegate respondsToSelector:@selector(sy_tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.syDelegate sy_tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.syDelegate respondsToSelector:@selector(sy_tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.syDelegate sy_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.syDelegate respondsToSelector:@selector(sy_tableView:canEditRowAtIndexPath:)]) {
        return [self.syDelegate sy_tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.syDelegate respondsToSelector:@selector(sy_tableView:commitEditingStyle:forRowAtIndexPath:model:)]) {
        if ([self.data isKindOfClass:[NSArray class]]) {
            NSArray *array = self.data;
            SYTableViewCellModel *cellModel = array[indexPath.row];
            if (cellModel.enity) {
                [self.syDelegate sy_tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath model:cellModel.enity];
            }
        }
        if ([self.data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = self.data;
            NSString *key = [self.allkeys objectAtIndex:indexPath.section];
            SYTableViewCellModel *cellModel = [dictionary objectForKey:key][indexPath.row];
            if (cellModel.enity) {
                [self.syDelegate sy_tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath model:cellModel.enity];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.syDelegate respondsToSelector:@selector(sy_tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.syDelegate sy_tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"";
}
@end
