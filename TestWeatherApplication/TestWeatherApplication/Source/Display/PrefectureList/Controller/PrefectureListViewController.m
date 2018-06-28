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
#import "PrefectureListModel.h"
#import "PrefectureListView.h"

//=======================================================
// 都道府県一覧画面
//=======================================================

@interface PrefectureListViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UIPopoverPresentationControllerDelegate,
PrefectureListTableViewCellDelegate,
AreaFilterViewControllerDelegate,
PrefectureListViewDelegate>

@property (nonatomic) PrefectureListModel *model;

@property (nonatomic) PrefectureListView *prefectureListView;

@end

@implementation PrefectureListViewController

#pragma mark - Override
- (void)loadView
{
    self.prefectureListView = [PrefectureListView new];
    self.prefectureListView.delegate = self;
    self.view = self.prefectureListView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.model = [PrefectureListModel new];
    [self setupTableView];
    [self.model setupTableDataList];
    
    [self.prefectureListView displayIsFavoriteCheck:self.model.isFavoriteButtonCheck];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.model.tableDataList.count;
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
    NSDictionary *prefectureInfo = self.model.tableDataList[indexPath.row];
    [cell displayPrefectureInfo:prefectureInfo
                     isFavorite:[self.model isFavoriteWithCityId:prefectureInfo[TWACityId]]];
    
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
    NSDictionary *prefectureInfo = self.model.tableDataList[indexPath.row];
    WeatherModel *model = [WeatherModel new];
    model.prefectureInfo = prefectureInfo;
    __weak typeof(self) weakSelf = self;
    [model requestWeatherWithCityId:prefectureInfo[TWACityId]
                           success:^(NSDictionary *jsonData)
    {
        [SVProgressHUD dismiss];
        model.responseData = jsonData;
        [weakSelf showWeatherViewControllerWithModel:model];
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
    NSIndexPath *indexPath = [self.prefectureListView.tableView indexPathForCell:cell];
    if (!indexPath) {
        
        return;
    }
    
    NSDictionary *prefectureInfo = self.model.tableDataList[indexPath.row];
    [self.model changedFavoriteCityId:prefectureInfo[TWACityId]];
    [self.model setupTableDataList];
    [self.prefectureListView.tableView reloadData];
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
    self.model.selectedAreaTypes = [selectedAreaTypes mutableCopy];
    [self.model setupTableDataList];
    [self.prefectureListView.tableView reloadData];
}


#pragma mark - PrefectureListView Delegate
/**
 お気に入りのみ表示ボタン押下時に呼ばれる
 
 @param prefectureListView 対象View
 @param button 対象ボタン
 */
- (void)prefectureListView:(PrefectureListView *)prefectureListView
 didTapFavoriteCheckButton:(UIButton *)button
{
    self.model.isFavoriteButtonCheck = !self.model.isFavoriteButtonCheck;
    [self.prefectureListView displayIsFavoriteCheck:self.model.isFavoriteButtonCheck];
    [self.model setupTableDataList];
    [self.prefectureListView.tableView reloadData];
}


/**
 地方で絞込みボタン押下時に呼ばれる
 
 @param prefectureListView 対象View
 @param button 対象ボタン
 */
- (void)prefectureListView:(PrefectureListView *)prefectureListView
    didTapAreaFilterButton:(UIButton *)button
{
    [self showAreaFilterViewControllerWithButton:button];
}


#pragma mark - Set TableView
/**
 テーブルViewの設定を行う
 */
- (void)setupTableView
{
    self.prefectureListView.tableView.delegate = self;
    self.prefectureListView.tableView.dataSource = self;
    
    NSString *cellName = NSStringFromClass([PrefectureListTableViewCell class]);
    [self.prefectureListView.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
}


#pragma mark - Show
/**
 地方で絞込み画面表示処理

 @param button 呼び出し元ボタン
 */
- (void)showAreaFilterViewControllerWithButton:(UIButton *)button
{
    AreaFilterViewController *vc = [AreaFilterViewController new];
    vc.model = [AreaFilterModel new];
    vc.model.selectedAreaTypes = [self.model.selectedAreaTypes mutableCopy];
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

 @param model モデル
 */
- (void)showWeatherViewControllerWithModel:(WeatherModel *)model
{
    WeatherViewController *vc = [WeatherViewController new];
    vc.model = model;
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

@end
