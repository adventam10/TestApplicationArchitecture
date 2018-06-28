//
//  PrefectureListModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityData.h"

@interface PrefectureListModel : NSObject

@property (nonatomic) NSArray <CityDataList *> *tableDataList;
@property (nonatomic) NSArray <CityDataList *> *originalTableDataList;
@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;
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

@end
