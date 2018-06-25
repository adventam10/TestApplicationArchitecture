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

static NSString *const WNMBaseUrlString = @"http://weather.livedoor.com/forecast/webservice/json/v1";

@interface PrefectureListViewController ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, PrefectureListTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIButton *favoriteCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *areaFilterButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray <NSDictionary *> *tableDataList;
@property (nonatomic) NSArray <NSDictionary *> *originalTableDataList;
@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;
@property (nonatomic) NSArray <NSString *> *favoriteCityIds;

@property (nonatomic) NSInteger activityCount;

@end

@implementation PrefectureListViewController

#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *cellName = NSStringFromClass([PrefectureListTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
}


- (void)setupOriginalTableDataList
{
    NSDictionary *cityData = [self loadJsonFileWithFileName:@"CityData"];
    self.originalTableDataList = cityData[@"cityDataList"];
}


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


- (NSPredicate *)createFavoriteDataPredicateWithFavoriteCityIds:(NSArray <NSString *> *)favoriteCityIds
{
    if (favoriteCityIds.count == 0) {
        
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:@"%K IN %@",
            @"cityId", favoriteCityIds];
}


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
            @"area", areaList];
}


/**
 一覧情報を検索してIndexを返します。
 
 @param list 対象一覧
 @param key 検索Key
 @param value 検索値
 @return 検索結果Index
 */
- (NSInteger)foundListIndexWithList:(NSArray *)list
                                key:(NSString *)key
                              value:(NSString *)value
{
    if (list.count > 0) {
        
        NSInteger index = [[list valueForKey:key] indexOfObject:value];
        return index;
    }
    
    return NSNotFound;
}


#pragma mark - Button Action
- (IBAction)tappedFavoriteCheckButton:(UIButton *)button
{
    button.selected = !button.selected;
}


- (IBAction)tappedAreaFilterButton:(UIButton *)button
{
    [self showAreaFilterViewControllerWithButton:button];
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.tableDataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = NSStringFromClass([PrefectureListTableViewCell class]);
    PrefectureListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName
                                                                        forIndexPath:indexPath];
    cell.delegate = self;
    cell.prefectureInfo = self.tableDataList[indexPath.row];
    NSInteger index = [self foundListIndexWithList:self.favoriteCityIds
                                               key:@"cityId"
                                             value:cell.prefectureInfo[@"cityId"]];
    cell.isFavorite = (index == NSNotFound)? NO : YES;
    return cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD show];
    NSDictionary *prefectureInfo = self.tableDataList[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [self requestWeatherWithCityId:prefectureInfo[@"cityId"]
                           success:^(NSDictionary *jsonData)
    {
        [SVProgressHUD dismiss];
        [weakSelf showWeatherViewControllerWithResponseData:jsonData];
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
    
}


#pragma mark - Show
- (void)showAreaFilterViewControllerWithButton:(UIButton *)button
{
    AreaFilterViewController *vc = [AreaFilterViewController new];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = vc.view.frame.size;
    
    UIPopoverPresentationController *presentationController = vc.popoverPresentationController;
    presentationController.delegate = self;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    presentationController.sourceView = button;
    presentationController.sourceRect = button.bounds;
    [self presentViewController:vc animated: YES completion: nil];
}


- (void)showWeatherViewControllerWithResponseData:(NSDictionary *)responseData
{
    WeatherViewController *vc = [WeatherViewController new];
    vc.responseData = responseData;
    [self.navigationController pushViewController:vc animated:YES];
}


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


- (NSURLSession *)createURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 60;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return session;
}


- (NSURL *)createRequestURLWithCityId:(NSString *)cityId
{
    NSString *urlText = [NSString stringWithFormat:@"%@?city=%@",
                         WNMBaseUrlString, cityId];
    return [NSURL URLWithString:urlText];
}

@end
