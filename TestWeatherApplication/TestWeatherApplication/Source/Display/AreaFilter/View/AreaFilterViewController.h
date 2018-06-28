//
//  AreaFilterViewController.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaFilterModel.h"

@class AreaFilterViewController;
@protocol AreaFilterViewControllerDelegate<NSObject>

/**
 チェックボタン押下時に呼ばれる
 
 @param areaFilterViewController 対象ViewController
 @param selectedAreaTypes 選択地方タイプ一覧
 */
- (void)areaFilterViewController:(AreaFilterViewController *)areaFilterViewController
     didChangeSelectedAreaTypes:(NSArray <NSNumber *> *)selectedAreaTypes;

@end

@interface AreaFilterViewController : UIViewController

@property (nonatomic, weak) id<AreaFilterViewControllerDelegate> delegate;

/**
 ViewModelの設定
 
 @param model モデル
 */
- (void)setupViewModelWithModel:(AreaFilterModel *)model;

#pragma mark - Display Data
/**
 テーブルの表示を更新する
 */
- (void)reloadTableView;

/**
 全選択ボタンの表示設定
 
 @param isAllCheck 全選択フラグ
 */
- (void)displayIsAllCheck:(BOOL)isAllCheck;

@end
