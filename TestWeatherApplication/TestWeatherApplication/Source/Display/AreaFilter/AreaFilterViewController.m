//
//  AreaFilterViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterViewController.h"
#import "AreaFilterTableViewCell.h"

//=======================================================
// 地方で絞込み画面
//=======================================================

@interface AreaFilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

@property (nonatomic) NSArray <NSNumber *> *tableDataList;

@end

@implementation AreaFilterViewController

#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableDataList];
    [self setupSelectedAreaTypes];
    [self setupTableView];
    self.allSelectButton.selected = [self isAllCheck];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Action
/**
 すべてボタン押した時の処理
 
 @param button 対象ボタン
 */
- (IBAction)tappedAllSelectButton:(UIButton *)button
{
    button.selected = !button.selected;
    [self setupIsAllCheck:button.selected];
    
    if ([self.delegate respondsToSelector:@selector(areaFilterViewController:didChangeSelectedAreaTypes:)]) {
        
        [self.delegate areaFilterViewController:self didChangeSelectedAreaTypes:self.selectedAreaTypes];
    }
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
    NSString *cellName = NSStringFromClass([AreaFilterTableViewCell class]);
    AreaFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName
                                                                        forIndexPath:indexPath];
    NSNumber *num = self.tableDataList[indexPath.row];
    cell.title = [self getTitleFromAreaType:num.integerValue];
    cell.isCheck = [self isCheckWithAreaType:num.integerValue];
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
    NSNumber *num = self.tableDataList[indexPath.row];
    if ([self.selectedAreaTypes containsObject:num]) {
        
        [self.selectedAreaTypes removeObject:num];
        
    } else {
        
        [self.selectedAreaTypes addObject:num];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.allSelectButton.selected = [self isAllCheck];
    
    if ([self.delegate respondsToSelector:@selector(areaFilterViewController:didChangeSelectedAreaTypes:)]) {
        
        [self.delegate areaFilterViewController:self didChangeSelectedAreaTypes:self.selectedAreaTypes];
    }
}


#pragma mark - Set TableView
/**
 テーブルViewの設定を行う
 */
- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *cellName = NSStringFromClass([AreaFilterTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
}


#pragma mark - Set Data
/**
 テーブル表示用データの設定を行う
 */
- (void)setupTableDataList
{
    self.tableDataList = @[@(AFVAreaTypeHokkaido), @(AFVAreaTypeTohoku), @(AFVAreaTypeKanto),
                           @(AFVAreaTypeChubu), @(AFVAreaTypeKinki), @(AFVAreaTypeChugoku),
                           @(AFVAreaTypeShikoku), @(AFVAreaTypeKyushu)];
}


/**
 選択済みデータの設定を行う
 */
- (void)setupSelectedAreaTypes
{
    if (self.selectedAreaTypes.count > 0) {
        
        // 選択済みデータがある場合何もしない
        return;
    }
    
    // 選択済みデータがない場合全選択状態にする
    self.selectedAreaTypes = [NSMutableArray array];
    for (NSNumber *num in self.tableDataList) {
        
        [self.selectedAreaTypes addObject:num];
    }
}


#pragma mark - Status Check
/**
 すべて選択の選択状態を判定する

 @return すべて選択のチェック状態
 */
- (BOOL)isAllCheck
{
    if (self.selectedAreaTypes.count == 0) {
        
        return NO;
    }
    
    for (NSNumber *areaTypeNum in self.tableDataList) {
        
        if (![self.selectedAreaTypes containsObject:areaTypeNum]) {
            
            return NO;
        }
    }
    
    return YES;
}


/**
 対象の地方の選択状態を判定する

 @param areaType 対象地方
 @return 対象の地方の選択状態
 */
- (BOOL)isCheckWithAreaType:(AFVAreaType)areaType
{
    NSNumber *num = @(areaType);
    if ([self.selectedAreaTypes containsObject:num]) {
        
        return YES;
    }
    
    if ([self isAllCheck]) {
        
        return YES;
    }
    
    return NO;
}


/**
 すべて選択状態の変更処理

 @param isAllCheck すべて選択フラグ
 */
- (void)setupIsAllCheck:(BOOL)isAllCheck
{
    [self.selectedAreaTypes removeAllObjects];
    if (isAllCheck) {
        
        for (NSNumber *num in self.tableDataList) {
            
            [self.selectedAreaTypes addObject:num];
        }
    }
    
    [self.tableView reloadData];
}


/**
 対象の地方の画面表示用文字列を取得する

 @param areaType 対象地方
 @return 画面表示用文字列
 */
- (NSString *)getTitleFromAreaType:(AFVAreaType)areaType
{
    switch (areaType) {
        case AFVAreaTypeHokkaido:
            return @"北海道";
            
        case AFVAreaTypeTohoku:
            return @"東北地方";
            
        case AFVAreaTypeChubu:
            return @"中部地方";
            
        case AFVAreaTypeKanto:
            return @"関東地方";
            
        case AFVAreaTypeKinki:
            return @"近畿地方";
            
        case AFVAreaTypeChugoku:
            return @"中国地方";
            
        case AFVAreaTypeShikoku:
            return @"四国地方";
            
        case AFVAreaTypeKyushu:
            return @"九州地方";
    }
}

@end
