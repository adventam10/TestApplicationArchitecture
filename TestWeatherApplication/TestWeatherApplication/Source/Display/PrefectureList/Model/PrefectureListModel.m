//
//  PrefectureListModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListModel.h"

//=======================================================
// 都道府県一覧画面用Model
//=======================================================

@implementation PrefectureListModel

#pragma mark - Setter
- (void)setTableDataList:(NSArray<CityDataList *> *)tableDataList
{
    _tableDataList = tableDataList;
    if ([self.delegate respondsToSelector:@selector(didUpdateTableDataListOfPrefectureListModel:)]) {
        
        [self.delegate didUpdateTableDataListOfPrefectureListModel:self];
    }
}


/**
 絞込み地方の設定

 @param selectedAreaTypes 絞込み地方一覧
 */
- (void)setSelectedAreaTypes:(NSArray<NSNumber *> *)selectedAreaTypes
{
    _selectedAreaTypes = selectedAreaTypes;
    if ([self.delegate respondsToSelector:@selector(didUpdateSelectedAreaTypesOfPrefectureListModel:)]) {
        
        [self.delegate didUpdateSelectedAreaTypesOfPrefectureListModel:self];
    }
}


/**
 お気に入りのみ表示フラグの設定

 @param isFavoriteButtonCheck お気に入りのみ表示フラグ
 */
- (void)setIsFavoriteButtonCheck:(BOOL)isFavoriteButtonCheck
{
    _isFavoriteButtonCheck = isFavoriteButtonCheck;
    if ([self.delegate respondsToSelector:@selector(didUpdateIsFavoriteButtonCheckOfPrefectureListModel:)]) {
        
        [self.delegate didUpdateIsFavoriteButtonCheckOfPrefectureListModel:self];
    }
}


/**
 お気に入り一覧の設定
 
 @param favoriteCityIds お気に入り一覧
 */
- (void)setFavoriteCityIds:(NSArray<NSString *> *)favoriteCityIds
{
    _favoriteCityIds = favoriteCityIds;
    if ([self.delegate respondsToSelector:@selector(didUpdateFavoriteCityIdsOfPrefectureListModel:)]) {
        
        [self.delegate didUpdateFavoriteCityIdsOfPrefectureListModel:self];
    }
}



@end
