//
//  PrefectureListViewModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefectureListViewController.h"
#import "PrefectureListModel.h"
#import "PrefectureListCellModel.h"
#import "AreaFilterModel.h"

@interface PrefectureListViewModel : NSObject

@property (nonatomic, weak) PrefectureListViewController *viewController;

/**
 画面初期表示時の処理
 */
- (void)setupData;

#pragma mark - User Action
/**
 セル選択時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTablebleViewSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 地方絞込み変更時の処理
 
 @param selectedAreaTypes 絞込み地方一覧
 */
- (void)didChangeSelectedAreaTypes:(NSArray <NSNumber *> *)selectedAreaTypes;

/**
 お気に入りのみ表示ボタン押下時の処理
 */
- (void)didTapFavoriteCheckButton;

/**
 お気に入りボタン押した時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTapFavoriteCheckButtonAtIndexPath:(NSIndexPath *)indexPath;

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
- (PrefectureListCellModel *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Create Data
/**
 地方絞込み画面のモデル作成
 
 @return 地方絞込み画面のモデル
 */
- (AreaFilterModel *)createAreaFilterModel;

@end
