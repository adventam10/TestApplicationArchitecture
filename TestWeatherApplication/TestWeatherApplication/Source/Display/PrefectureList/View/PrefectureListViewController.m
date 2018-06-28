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
#import "PrefectureListPresenter.h"
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

@property (nonatomic) PrefectureListPresenter *presenter;

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
    self.presenter = [PrefectureListPresenter new];
    self.presenter.viewController = self;
    
    [self setupTableView];

    [self.presenter setupData];
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
    return [self.presenter tableViewNumberOfRowsInSection:section];
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
    [cell displayInfo:[self.presenter tableViewCellForRowAtIndexPath:indexPath]];
    
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
    [self.presenter didTablebleViewSelectRowAtIndexPath:indexPath];
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
    
    [self.presenter didTapFavoriteCheckButtonAtIndexPath:indexPath];
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
    [self.presenter didChangeSelectedAreaTypes:selectedAreaTypes];
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
    [self.presenter didTapFavoriteCheckButton];
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


#pragma mark - Display Data
/**
 テーブルの表示を更新する
 */
- (void)reloadTableView
{
    [self.prefectureListView.tableView reloadData];
}


/**
 お気に入りのみ表示ボタンの表示設定
 
 @param isFavoriteCheck お気に入りのみ表示フラグ
 */
- (void)displayIsFavoriteCheck:(BOOL)isFavoriteCheck
{
    [self.prefectureListView displayIsFavoriteCheck:isFavoriteCheck];
}


#pragma mark - Show
/**
 地方で絞込み画面表示処理

 @param button 呼び出し元ボタン
 */
- (void)showAreaFilterViewControllerWithButton:(UIButton *)button
{
    AreaFilterViewController *vc = [AreaFilterViewController new];
    [vc setupPresenterWithModel:[self.presenter createAreaFilterModel]];
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
    [vc setupPresenterWithModel:model];
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
