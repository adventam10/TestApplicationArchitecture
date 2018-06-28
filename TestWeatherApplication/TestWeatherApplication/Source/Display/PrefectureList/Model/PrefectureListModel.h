//
//  PrefectureListModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityData.h"
#import "WeatherModel.h"

@class PrefectureListModel;
@protocol PrefectureListModelDelegate<NSObject>

/**
 テーブルのデータ一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateTableDataListOfPrefectureListModel:(PrefectureListModel *)model;

/**
 選択地方一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateSelectedAreaTypesOfPrefectureListModel:(PrefectureListModel *)model;

/**
 お気に入り一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateFavoriteCityIdsOfPrefectureListModel:(PrefectureListModel *)model;

/**
 お気に入りのみ表示フラグ更新時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateIsFavoriteButtonCheckOfPrefectureListModel:(PrefectureListModel *)model;

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
                  isSuccess:(BOOL)isSuccess;
@end

@interface PrefectureListModel : NSObject

@property (nonatomic, weak) id<PrefectureListModelDelegate> delegate;

@property (nonatomic) NSArray <CityDataList *> *tableDataList;
@property (nonatomic) NSArray <CityDataList *> *originalTableDataList;
@property (nonatomic) NSArray <NSNumber *> *selectedAreaTypes;
@property (nonatomic) NSArray <NSString *> *favoriteCityIds;

@property (nonatomic) BOOL isFavoriteButtonCheck;

/**
 テーブル表示用データの設定を行う
 */
- (void)setupTableDataList;

/**
 お気に入りの登録・削除処理
 
 @param cityId 対象cityId
 */
- (void)changedFavoriteCityId:(NSString *)cityId;

/**
 対象の都道府県がお気に入りか判定する
 
 @param cityId 対象cityId
 @return お気に入りフラグ
 */
- (BOOL)isFavoriteWithCityId:(NSString *)cityId;

/**
 天気情報の取得処理

 @param prefectureData 対象都道府県データ
 */
- (void)requestWeatherWithPrefectureData:(CityDataList *)prefectureData;

@end
