//
//  PrefectureListPresenter.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListPresenter.h"


@interface PrefectureListPresenter()<PrefectureListModelDelegate>

@property (nonatomic) PrefectureListModel *model;

@end

@implementation PrefectureListPresenter

/**
 画面初期表示時の処理
 */
- (void)setupData
{
    self.model.isFavoriteButtonCheck = self.model.isFavoriteButtonCheck;
}


#pragma mark - Initialize
/**
 初期設定を行う
 
 @return インスタンス
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        self.model = [PrefectureListModel new];
        self.model.delegate = self;
    }
    
    return self;
}


#pragma mark - User Action
/**
 セル選択時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTablebleViewSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD show];
    [self.model requestWeatherWithPrefectureData:self.model.tableDataList[indexPath.row]];
}


/**
 地方絞込み変更時の処理
 
 @param selectedAreaTypes 絞込み地方一覧
 */
- (void)didChangeSelectedAreaTypes:(NSArray <NSNumber *> *)selectedAreaTypes
{
    self.model.selectedAreaTypes = [selectedAreaTypes copy];
}


/**
 お気に入りのみ表示ボタン押下時の処理
 */
- (void)didTapFavoriteCheckButton
{
    self.model.isFavoriteButtonCheck = !self.model.isFavoriteButtonCheck;
}


/**
 お気に入りボタン押した時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTapFavoriteCheckButtonAtIndexPath:(NSIndexPath *)indexPath
{
    CityDataList *prefectureInfo = self.model.tableDataList[indexPath.row];
    [self.model changedFavoriteCityId:prefectureInfo.cityId];
}


#pragma mark - UITableView DataSource
/**
 セクション内行数を設定する
 
 @param section 対象セクション
 @return セクション内行数
 */
- (NSInteger)tableViewNumberOfRowsInSection:(NSInteger)section
{
    return self.model.tableDataList.count;
}


/**
 セルを設定する
 
 @param indexPath 対象インデックスパス
 @return セルの表示情報
 */
- (PrefectureListCellModel *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrefectureListCellModel *model = [PrefectureListCellModel new];
    model.prefectureData = self.model.tableDataList[indexPath.row];
    model.isFavorite = [self.model isFavoriteWithCityId:model.prefectureData.cityId];
    return model;
}


#pragma mark - Create Data
/**
 地方絞込み画面のモデル作成
 
 @return 地方絞込み画面のモデル
 */
- (AreaFilterModel *)createAreaFilterModel
{
    AreaFilterModel *model = [AreaFilterModel new];
    model.selectedAreaTypes = [self.model.selectedAreaTypes mutableCopy];
    
    return model;
}


#pragma mark - PrefectureListModel Delegate
/**
 テーブルのデータ一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateTableDataListOfPrefectureListModel:(PrefectureListModel *)model
{
    [self.viewController reloadTableView];
}


/**
 選択地方一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateSelectedAreaTypesOfPrefectureListModel:(PrefectureListModel *)model
{
    [self.model setupTableDataList];
}


/**
 お気に入り一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateFavoriteCityIdsOfPrefectureListModel:(PrefectureListModel *)model
{
    [self.model setupTableDataList];
}


/**
 お気に入りのみ表示フラグ更新時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateIsFavoriteButtonCheckOfPrefectureListModel:(PrefectureListModel *)model
{
    [self.viewController displayIsFavoriteCheck:model.isFavoriteButtonCheck];
    [self.model setupTableDataList];
}


/**
 天気情報の取得通信終了時に呼ばれる

 @param model 対象Model
 @param weatherModel 天気画面のモデル
 @param errorMessage エラーメッセージ
 @param isSuccess 通信成功フラグ
 */
- (void)prefectureListModel:(PrefectureListModel *)model
didCompleteWeatherRequestWithModel:(WeatherModel *)weatherModel
               errorMessage:(NSString *)errorMessage
                  isSuccess:(BOOL)isSuccess
{
    [SVProgressHUD dismiss];
    if (isSuccess) {
        
        [self.viewController showWeatherViewControllerWithModel:weatherModel];
        return;
    }
    
    [self.viewController showAlertYesOnlyWithTitle:@""
                                           message:errorMessage
                                          yesBlock:nil];
}

@end
