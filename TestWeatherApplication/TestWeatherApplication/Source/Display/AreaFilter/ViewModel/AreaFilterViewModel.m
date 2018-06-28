//
//  AreaFilterViewModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterViewModel.h"

@interface AreaFilterViewModel()<AreaFilterModelDelegate>

@end

@implementation AreaFilterViewModel

/**
 画面初期表示時の処理
 */
- (void)setupData
{
    self.model.isAllCheck = [self checkIsAllCheck];
}


#pragma mark - Setter
/**
 モデルの設定
 
 @param model モデル
 */
- (void)setModel:(AreaFilterModel *)model
{
    _model = model;
    self.model.delegate = self;
}


#pragma mark - Status Check
/**
 すべて選択の選択状態を判定する
 
 @return すべて選択のチェック状態
 */
- (BOOL)checkIsAllCheck
{
    if (self.model.selectedAreaTypes.count == 0) {
        
        return NO;
    }
    
    for (NSNumber *areaTypeNum in self.model.tableDataList) {
        
        if (![self.model.selectedAreaTypes containsObject:areaTypeNum]) {
            
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
    if ([self.model.selectedAreaTypes containsObject:num]) {
        
        return YES;
    }
    
    if (self.model.isAllCheck) {
        
        return YES;
    }
    
    return NO;
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


/**
 すべて選択状態の変更処理
 
 @param isAllCheck すべて選択フラグ
 */
- (void)setupIsAllCheck:(BOOL)isAllCheck
{
    [self.model.selectedAreaTypes removeAllObjects];
    if (isAllCheck) {
        
        for (NSNumber *num in self.model.tableDataList) {
            
            [self.model.selectedAreaTypes addObject:num];
        }
    }
    
    self.model.selectedAreaTypes = self.model.selectedAreaTypes;
}


/**
 地方の絞込みの選択状態変更処理
 
 @param areaType 対象地方
 */
- (void)changedSelectedArreaType:(AFVAreaType)areaType
{
    NSNumber *num = @(areaType);
    if ([self.model.selectedAreaTypes containsObject:num]) {
        
        [self.model.selectedAreaTypes removeObject:num];
        
    } else {
        
        [self.model.selectedAreaTypes addObject:num];
    }
    
    self.model.selectedAreaTypes = self.model.selectedAreaTypes;
}


#pragma mark - User Action
/**
 全選択ボタン押した時の処理
 */
- (void)didTapAllSelectButton
{
    self.model.isAllCheck = !self.model.isAllCheck;
    [self setupIsAllCheck:self.model.isAllCheck];
}


#pragma mark - UITableView DataSource
/**
 セル選択時の処理
 
 @param indexPath 対象インデックスパス
 */
- (void)didTablebleViewSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = self.model.tableDataList[indexPath.row];
    [self changedSelectedArreaType:num.integerValue];
}


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
- (AreaFilterCellModel *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaFilterCellModel *model = [AreaFilterCellModel new];
    NSNumber *num = self.model.tableDataList[indexPath.row];
    model.area = [self getTitleFromAreaType:num.integerValue];
    model.isCheck = [self isCheckWithAreaType:num.integerValue];
    
    return model;
}


#pragma mark - AreaFilterModel Delegate
/**
 選択地方一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateSelectedAreaTypesOfAreaFilterModel:(AreaFilterModel *)model
{
    if (self.model.isAllCheck != [self checkIsAllCheck]) {
        
        self.model.isAllCheck = [self checkIsAllCheck];
    }
    
    [self.viewController reloadTableView];
    
    if ([self.viewController.delegate respondsToSelector:@selector(areaFilterViewController:didChangeSelectedAreaTypes:)]) {
        
        [self.viewController.delegate areaFilterViewController:self.viewController
                                    didChangeSelectedAreaTypes:self.model.selectedAreaTypes];
    }
}


/**
 全選択フラグが更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateIsAllCheckOfAreaFilterModel:(AreaFilterModel *)model
{
    [self.viewController displayIsAllCheck:self.model.isAllCheck];
}

@end
