//
//  AreaFilterModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterModel.h"

//=======================================================
// 地方で絞込み画面用Model
//=======================================================

@implementation AreaFilterModel

#pragma mark - Initialize
/**
 初期設定を行う
 
 @return インスタンス
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        [self setupTableDataList];
    }
    return self;
}


#pragma mark - Setter
/**
 選択済みデータの設定を行う
 */
- (void)setSelectedAreaTypes:(NSMutableArray<NSNumber *> *)selectedAreaTypes
{
    if (selectedAreaTypes.count > 0) {
        
        // 選択済みデータがある場合何もしない
        _selectedAreaTypes = selectedAreaTypes;
        return;
    }
    
    // 選択済みデータがない場合全選択状態にする
    _selectedAreaTypes = [NSMutableArray array];
    for (NSNumber *num in self.tableDataList) {
        
        [self.selectedAreaTypes addObject:num];
    }
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
    [self.selectedAreaTypes removeAllObjects];
    if (isAllCheck) {
        
        for (NSNumber *num in self.tableDataList) {
            
            [self.selectedAreaTypes addObject:num];
        }
    }
}


/**
 地方の絞込みの選択状態変更処理
 
 @param areaType 対象地方
 */
- (void)changedSelectedArreaType:(AFVAreaType)areaType
{
    NSNumber *num = @(areaType);
    if ([self.selectedAreaTypes containsObject:num]) {
        
        [self.selectedAreaTypes removeObject:num];
        
    } else {
        
        [self.selectedAreaTypes addObject:num];
    }
}

@end
