//
//  PrefectureListViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListViewController.h"

#import "AreaFilterViewController.h"
#import "WeatherViewController.h"
#import "PrefectureListTableViewCell.h"

//=======================================================
// 都道府県一覧画面
//=======================================================

@interface PrefectureListViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UIPopoverPresentationControllerDelegate,
PrefectureListTableViewCellDelegate,
AreaFilterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *favoriteCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *areaFilterButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray <NSDictionary *> *tableDataList;
@property (nonatomic) NSArray <NSDictionary *> *originalTableDataList;
@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;
@property (nonatomic) NSArray <NSString *> *favoriteCityIds;

@end

@implementation PrefectureListViewController

#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
    self.favoriteCheckButton.selected = NO;
    [self setupOriginalTableDataList];
    [self setupTableDataList];
    
    [self setupTableView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Action
/**
 お気に入りのみ表示ボタン押した時の処理

 @param button 対象ボタン
 */
- (IBAction)tappedFavoriteCheckButton:(UIButton *)button
{
    button.selected = !button.selected;
    [self setupTableDataList];
    [self.tableView reloadData];
}


/**
 地方で絞込みボタン押した時の処理
 
 @param button 対象ボタン
 */
- (IBAction)tappedAreaFilterButton:(UIButton *)button
{
    [self showAreaFilterViewControllerWithButton:button];
}


#pragma mark - UITableView DataSource
/**
 セクション内行数を設定する

 @param tableView 対象テーブルView
 @param section 対象セクション
 @return セクション内行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.tableDataList.count;
}


/**
 セルを設定する

 @param tableView 対象テーブルView
 @param indexPath 対象インデックスパス
 @return セル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = NSStringFromClass([PrefectureListTableViewCell class]);
    PrefectureListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName
                                                                        forIndexPath:indexPath];
    cell.delegate = self;
    cell.prefectureInfo = self.tableDataList[indexPath.row];
    NSInteger index = [self.favoriteCityIds indexOfObject:cell.prefectureInfo[TWACityId]];
    cell.isFavorite = (index == NSNotFound)? NO : YES;
    return cell;
}


#pragma mark - UITableView Delegate
/**
 セル選択時の処理

 @param tableView 対象テーブルView
 @param indexPath 対象インデックスパス
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD show];
    NSDictionary *prefectureInfo = self.tableDataList[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [self requestWeatherWithCityId:prefectureInfo[TWACityId]
                           success:^(NSDictionary *jsonData)
    {
        [SVProgressHUD dismiss];
        [weakSelf showWeatherViewControllerWithResponseData:jsonData
                                             prefectureInfo:prefectureInfo];
    }
                           failure:^(NSString *message, NSError *error)
    {
        [SVProgressHUD dismiss];
        [weakSelf showAlertYesOnlyWithTitle:@""
                                    message:message
                                   yesBlock:nil];
    }];
}


#pragma mark - UIPopoverPresentationController Delegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}


#pragma mark - PrefectureListTableViewCell Delegate
/**
 お気に入りボタン押下時に呼ばれる
 
 @param cell 対象セル
 @param button 対象ボタン
 */
- (void)prefectureListTableViewCell:(PrefectureListTableViewCell *)cell
               didTapFavoriteButton:(UIButton *)button
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath) {
        
        return;
    }
    
    NSMutableArray *favoriteCityIds = [self.favoriteCityIds mutableCopy];
    if (!favoriteCityIds) {
        
        favoriteCityIds = [NSMutableArray array];
    }
    
    NSDictionary *prefectureInfo = self.tableDataList[indexPath.row];
    NSInteger index = [self.favoriteCityIds indexOfObject:cell.prefectureInfo[TWACityId]];
    
    if (cell.isFavorite) {
    
        // お気に入り削除
        if (index != NSNotFound) {
            
            [favoriteCityIds removeObjectAtIndex:index];
        }
        
    } else {
        
        if (index == NSNotFound) {
        
            [favoriteCityIds addObject:prefectureInfo[TWACityId]];
        }
    }
    
    [self userDefaultsSaveObject:favoriteCityIds key:TWAUserDefaultsFavorites];
    self.favoriteCityIds = [self userDefaultsLoadDataWithKey:TWAUserDefaultsFavorites];
    [self setupTableDataList];
    [self.tableView reloadData];
}


#pragma mark - AreaFilterViewController Delegate
/**
 チェックボタン押下時に呼ばれる
 
 @param areaFilterViewController 対象ViewController
 @param selectedAreaTypes 選択地方タイプ一覧
 */
- (void)areaFilterViewController:(AreaFilterViewController *)areaFilterViewController
      didChangeSelectedAreaTypes:(NSArray <NSNumber *> *)selectedAreaTypes
{
    self.selectedAreaTypes = [selectedAreaTypes mutableCopy];
    [self setupTableDataList];
    [self.tableView reloadData];
}


#pragma mark - Set TableView
/**
 テーブルViewの設定を行う
 */
- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *cellName = NSStringFromClass([PrefectureListTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
}


#pragma mark - Set Data
/**
 テーブル表示用データ（全データ）の設定を行う
 */
- (void)setupOriginalTableDataList
{
    NSDictionary *cityData = [self loadJsonFileWithFileName:@"CityData"];
    self.originalTableDataList = cityData[TWACityDataList];
}


/**
 テーブル表示用データの設定を行う
 */
- (void)setupTableDataList
{
    NSMutableArray *predicates = [NSMutableArray array];
    if (self.favoriteCheckButton.selected) {
        
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
- (BOOL)userDefaultsSaveObject:(id)object key:(NSString *)key
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


#pragma mark - Show
/**
 地方で絞込み画面表示処理

 @param button 呼び出し元ボタン
 */
- (void)showAreaFilterViewControllerWithButton:(UIButton *)button
{
    AreaFilterViewController *vc = [AreaFilterViewController new];
    vc.selectedAreaTypes = [self.selectedAreaTypes mutableCopy];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = vc.view.frame.size;
    
    UIPopoverPresentationController *presentationController = vc.popoverPresentationController;
    presentationController.delegate = self;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    presentationController.sourceView = button;
    presentationController.sourceRect = button.bounds;
    [self presentViewController:vc animated: YES completion: nil];
}


/**
 天気画面表示処理

 @param responseData 通信で取得したデータ
 @param prefectureInfo 選択都道府県情報
 */
- (void)showWeatherViewControllerWithResponseData:(NSDictionary *)responseData
                                   prefectureInfo:(NSDictionary *)prefectureInfo
{
    WeatherViewController *vc = [WeatherViewController new];
    vc.prefectureInfo = prefectureInfo;
    vc.responseData = responseData;
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 「確認」ボタンのみのアラートを表示する

 @param title タイトル
 @param message メッセージ
 @param yesBlock 「確認」押した時の処理
 */
- (void)showAlertYesOnlyWithTitle:(NSString *)title
                          message:(NSString *)message
                         yesBlock:(void (^)(void))yesBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(title)? title : @""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
    {
        if (yesBlock) {
            
            yesBlock();
        }
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    NSURLSession *session = [self createURLSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:[self createRequestURLWithCityId:cityId]
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
