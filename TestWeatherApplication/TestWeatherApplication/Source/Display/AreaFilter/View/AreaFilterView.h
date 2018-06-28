//
//  AreaFilterView.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaFilterView;
@protocol AreaFilterViewDelegate<NSObject>

/**
 すべてチェックボタン押下時に呼ばれる
 
 @param areaFilterView 対象View
 @param button 対象ボタン
 */
- (void)areaFilterView:(AreaFilterView *)areaFilterView
      didTapAllSelectButton:(UIButton *)button;

@end

@interface AreaFilterView : UIView

@property (nonatomic, weak) id<AreaFilterViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

#pragma mark - Display Data
/**
 全選択ボタンの表示設定
 
 @param isAllCheck 全選択フラグ
 */
- (void)displayIsAllCheck:(BOOL)isAllCheck;

@end
