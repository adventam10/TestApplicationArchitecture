//
//  AreaFilterViewModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaFilterModel.h"
#import "AreaFilterViewController.h"
#import "AreaFilterCellModel.h"

@interface AreaFilterViewModel : NSObject

@property (nonatomic) AreaFilterModel *model;

@property (nonatomic, weak) AreaFilterViewController *viewController;

/**
 画面初期表示時の処理
 */
- (void)setupData;

#pragma mark - User Action
/**
 全選択ボタン押した時の処理
 */
- (void)didTapAllSelectButton;

#pragma mark - UITableView DataSource
/**
 セル選択時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTablebleViewSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 セクション内行数を設定する
 
 @param section 対象セクション
 @return セクション内行数
 */
- (NSInteger)tableViewNumberOfRowsInSection:(NSInteger)section;

/**
 セルを設定する
 
 @param indexPath 対象インデックスパス
 @return セルの表示情報
 */
- (AreaFilterCellModel *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
