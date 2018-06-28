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

@end

@interface PrefectureListModel : NSObject

@property (nonatomic, weak) id<PrefectureListModelDelegate> delegate;

@property (nonatomic) NSArray <CityDataList *> *tableDataList;
@property (nonatomic) NSArray <CityDataList *> *originalTableDataList;
@property (nonatomic) NSArray <NSNumber *> *selectedAreaTypes;
@property (nonatomic) NSArray <NSString *> *favoriteCityIds;

@property (nonatomic) BOOL isFavoriteButtonCheck;

@end
