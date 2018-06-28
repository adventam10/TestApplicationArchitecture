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
        self.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
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
    NSDictionary *cityData = [self loadJsonFileWithFileName:@"CityData"];
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
    
    [self userDefaultsSaveObject:favoriteCityIds key:TWAUserDefaultsFavorites];
    self.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
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
        switch (areaType) {
            case AFVAreaTypeHokkaido:
                [areaList addObject:@"北海道"];
                break;
            case AFVAreaTypeTohoku:
                [areaList addObject:@"東北"];
                break;
            case AFVAreaTypeKanto:
                [areaList addObject:@"関東"];
                break;
            case AFVAreaTypeChubu:
                [areaList addObject:@"中部"];
                break;
            case AFVAreaTypeKinki:
                [areaList addObject:@"近畿"];
                break;
            case AFVAreaTypeChugoku:
                [areaList addObject:@"中国"];
                break;
            case AFVAreaTypeShikoku:
                [areaList addObject:@"四国"];
                break;
                
            case AFVAreaTypeKyushu:
                [areaList addObject:@"九州"];
                break;
        }
    }
    
    if (areaList.count == 0) {
        
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:@"%K IN %@",
            TWAArea, areaList];
}


/**
 プロジェクト内のJSONファイルを読み込む。
 
 @param fileName ファイル名（拡張子なし）
 @return JSONデータ
 */
- (NSDictionary *)loadJsonFileWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments error:nil];
    return dic;
}


#pragma mark - UserDefaults
/**
 端末内にKeyを元にオブジェクトを保存します。
 
 @param object 対象オブジェクト
 @param key 指定のキー
 @return 保存成功フラグ
 */
- (BOOL)userDefaultsSaveObject:(id)object
                           key:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
    BOOL isSucceed = [userDefaults synchronize];
    if (!isSucceed) {
        
    }
    return isSucceed;
}


/**
 端末内に保存されたオブジェクトをKeyを元に取り出します。
 
 @param key 指定のキー
 @return 対象オブジェクト
 */
- (id)userDefaultsLoadDataWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults dataForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}

@end
