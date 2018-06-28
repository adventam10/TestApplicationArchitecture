//
//  PrefectureListViewModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListViewModel.h"
@interface PrefectureListViewModel()<PrefectureListModelDelegate>

@property (nonatomic) PrefectureListModel *model;

@end

@implementation PrefectureListViewModel

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
        self.model.isFavoriteButtonCheck = NO;
        self.model.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
        [self setupOriginalTableDataList];
        [self setupTableDataList];
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
    [self requestWeatherWithPrefectureData:self.model.tableDataList[indexPath.row]];
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
    [self changedFavoriteCityId:prefectureInfo.cityId];
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
    model.isFavorite = [self isFavoriteWithCityId:model.prefectureData.cityId];
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
    [self setupTableDataList];
}


/**
 お気に入り一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateFavoriteCityIdsOfPrefectureListModel:(PrefectureListModel *)model
{
    [self setupTableDataList];
}


/**
 お気に入りのみ表示フラグ更新時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateIsFavoriteButtonCheckOfPrefectureListModel:(PrefectureListModel *)model
{
    [self.viewController displayIsFavoriteCheck:model.isFavoriteButtonCheck];
    [self setupTableDataList];
}


#pragma mark - Status
/**
 対象の都道府県がお気に入りか判定する
 
 @param cityId 対象cityId
 @return お気に入りフラグ
 */
- (BOOL)isFavoriteWithCityId:(NSString *)cityId
{
    NSInteger index = [self.model.favoriteCityIds indexOfObject:cityId];
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
    self.model.originalTableDataList = data.cityDataList;
}


/**
 テーブル表示用データの設定を行う
 */
- (void)setupTableDataList
{
    NSMutableArray *predicates = [NSMutableArray array];
    if (self.model.isFavoriteButtonCheck) {
        
        NSPredicate *pred1 = [self createFavoriteDataPredicateWithFavoriteCityIds:self.model.favoriteCityIds];
        if (pred1) {
            
            [predicates addObject:pred1];
        }
    }
    
    NSPredicate *pred2 = [self createAreaDataPredicateWithAreaTypes:self.model.selectedAreaTypes];
    if (pred2) {
        
        [predicates addObject:pred2];
    }
    
    if (predicates.count == 0) {
        
        self.model.tableDataList = self.model.originalTableDataList;
        return;
    }
        
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    self.model.tableDataList = [self.model.originalTableDataList filteredArrayUsingPredicate:predicate];
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
    
    NSMutableArray *favoriteCityIds = [self.model.favoriteCityIds mutableCopy];
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
    self.model.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
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


#pragma mark - Request
/**
 天気情報の取得処理
 
 @param prefectureData 対象都道府県データ
 */
- (void)requestWeatherWithPrefectureData:(CityDataList *)prefectureData
{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [weakSelf requestWeatherWithCityId:prefectureData.cityId
                               success:^(NSDictionary *jsonData)
    {
        [SVProgressHUD dismiss];
        WeatherModel *model = [WeatherModel new];
        model.prefectureInfo = prefectureData;
        model.weatherResponse = [[WeatherResponse alloc] initWithDictionary:jsonData];
        [weakSelf.viewController showWeatherViewControllerWithModel:model];
    }
                               failure:^(NSString *message, NSError *error)
     {
         [SVProgressHUD dismiss];
         [weakSelf.viewController showAlertYesOnlyWithTitle:@""
                                                    message:message
                                                   yesBlock:nil];
     }];
}


#pragma mark - Request
/**
 天気情報取得処理
 
 @param cityId 対象都道府県ID
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
- (NSURLSessionDataTask *)requestWeatherWithCityId:(NSString *)cityId
                                           success:(void (^)(NSDictionary *jsonData))success
                                           failure:(void (^)(NSString *message, NSError *error))failure
{
    NSURLSessionDataTask *task =
    [self requestWithURL:[self createRequestURLWithCityId:cityId]
                 success:success
                 failure:failure];
    
    return task;
}


/**
 通信処理
 
 @param url URL
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
- (NSURLSessionDataTask *)requestWithURL:(NSURL *)url
                                 success:(void (^)(NSDictionary *jsonData))success
                                 failure:(void (^)(NSString *message, NSError *error))failure
{
    NSURLSession *session = [self createURLSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         [session invalidateAndCancel];
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (error) {
                 
                 if (failure) {
                     
                     failure(error.localizedDescription, error);
                     return;
                 }
             }
             
             if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                 
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                 if (httpResponse.statusCode == 200) {
                     
                     NSError *err;
                     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&err];
                     if (err) {
                         
                         if (failure) {
                             
                             failure(err.localizedDescription, err);
                             return;
                         }
                     }
                     
                     if (success) {
                         
                         success(dic);
                         return;
                     }
                 }
             }
             
             if (failure) {
                 
                 failure(@"データの取得に失敗しました", nil);
                 return;
             }
         });
     }];
    
    [task resume];
    
    return task;
}


/**
 URLセッションを作成する
 
 @return URLセッション
 */
- (NSURLSession *)createURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 60;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return session;
}


/**
 天気情報取得URLを作成する
 
 @param cityId 対象都道府県ID
 @return 天気情報取得URL
 */
- (NSURL *)createRequestURLWithCityId:(NSString *)cityId
{
    NSString *urlText = [NSString stringWithFormat:@"%@?city=%@",
                         NWKBaseUrlString, cityId];
    return [NSURL URLWithString:urlText];
}
@end
