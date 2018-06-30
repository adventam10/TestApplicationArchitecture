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

#pragma mark - Initialize
/**
 初期設定を行う

 @return インスタンス
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        self.isFavoriteButtonCheck = NO;
        [self setupOriginalTableDataList];
        self.favoriteCityIds = [NSUserDefaults readObjectWithKey:TWAUserDefaultsFavorites];
    }
    
    return self;
}


#pragma mark - Status
/**
 対象の都道府県がお気に入りか判定する

 @param cityId 対象cityId
 @return お気に入りフラグ
 */
- (BOOL)isFavoriteWithCityId:(NSString *)cityId
{
    NSInteger index = [self.favoriteCityIds indexOfObject:cityId];
    return (index == NSNotFound)? NO : YES;
}


#pragma mark - Set Data
/**
 テーブル表示用データ（全データ）の設定を行う
 */
- (void)setupOriginalTableDataList
{
    NSDictionary *cityData = [[NSBundle mainBundle] loadJSONDataWithFileName:@"CityData"];
    CityData *data = [[CityData alloc] initWithDictionary:cityData];
    self.originalTableDataList = data.cityDataList;
}


/**
 テーブル表示用データの設定を行う
 */
- (void)setupTableDataList
{
    NSMutableArray *predicates = [NSMutableArray array];
    if (self.isFavoriteButtonCheck) {
        
        NSPredicate *pred1 = [self createFavoriteDataPredicateWithFavoriteCityIds:self.favoriteCityIds];
        if (pred1) {
            
            [predicates addObject:pred1];
        }
    }
    
    NSPredicate *pred2 = [self createAreaDataPredicateWithAreaTypes:self.selectedAreaTypes];
    if (pred2) {
        
        [predicates addObject:pred2];
    }
    
    if (predicates.count == 0) {
        
        self.tableDataList = self.originalTableDataList;
        return;
    }
    
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    self.tableDataList = [self.originalTableDataList filteredArrayUsingPredicate:predicate];
}


/**
 お気に入りの登録・削除処理

 @param cityId 対象cityId
 */
- (void)changedFavoriteCityId:(NSString *)cityId
{
    if (!cityId) {
        
        return;
    }
    
    NSMutableArray *favoriteCityIds = [self.favoriteCityIds mutableCopy];
    if (!favoriteCityIds) {
        
        favoriteCityIds = [NSMutableArray array];
    }
    
    NSInteger index = [favoriteCityIds indexOfObject:cityId];
    // お気に入り削除
    if (index != NSNotFound) {
        
        [favoriteCityIds  removeObjectAtIndex:index];
        
    } else {
        
        [favoriteCityIds  addObject:cityId];
    }
    
    [NSUserDefaults writeObject:favoriteCityIds key:TWAUserDefaultsFavorites];
    self.favoriteCityIds = [NSUserDefaults readObjectWithKey:TWAUserDefaultsFavorites];
}


#pragma mark - Create Predicate
/**
 お気に入りの絞込み条件を作成する
 
 @param favoriteCityIds お気に入りID一覧
 @return お気に入りの絞込み条件
 */
- (NSPredicate *)createFavoriteDataPredicateWithFavoriteCityIds:(NSArray <NSString *> *)favoriteCityIds
{
    if (favoriteCityIds.count == 0) {
        
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:@"%K IN %@",
            TWACityId, favoriteCityIds];
}


/**
 地方の絞込み条件を作成する
 
 @param areaTypes 絞込み地方一覧
 @return 地方の絞込み条件
 */
- (NSPredicate *)createAreaDataPredicateWithAreaTypes:(NSArray <NSNumber *> *)areaTypes
{
    if (areaTypes.count == 0) {
        
        return nil;
    }
    
    NSMutableArray *areaList = [NSMutableArray array];
    for (NSNumber *areaTypeNum in areaTypes) {
        
        AFVAreaType areaType = [areaTypeNum integerValue];
        NSString *area = [self getAreaNameFromAreaType:areaType];
        if (area) {
            
            [areaList addObject:area];
        }
    }
    
    if (areaList.count == 0) {
        
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:@"%K IN %@",
            TWAArea, areaList];
}


/**
 地方タイプからデータ絞込み用の地方文字列を取得する

 @param areaType 地方タイプ
 @return データ絞込み用の地方文字列
 */
- (NSString *)getAreaNameFromAreaType:(AFVAreaType)areaType
{
    switch (areaType) {
        case AFVAreaTypeHokkaido:
            return @"北海道";
        case AFVAreaTypeTohoku:
            return @"東北";
        case AFVAreaTypeKanto:
            return @"関東";
        case AFVAreaTypeChubu:
            return @"中部";
        case AFVAreaTypeKinki:
            return @"近畿";
        case AFVAreaTypeChugoku:
            return @"中国";
        case AFVAreaTypeShikoku:
            return @"四国";
        case AFVAreaTypeKyushu:
            return @"九州";
    }
    
    return nil;
}

@end
