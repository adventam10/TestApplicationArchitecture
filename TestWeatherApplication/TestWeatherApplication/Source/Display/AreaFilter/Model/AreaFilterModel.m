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
 
 @param selectedAreaTypes 選択地方一覧
 */
- (void)setSelectedAreaTypes:(NSMutableArray<NSNumber *> *)selectedAreaTypes
{
    if (selectedAreaTypes.count > 0) {
        
        // 選択済みデータがある場合何もしない
        _selectedAreaTypes = selectedAreaTypes;
        
    } else {
        
        // 選択済みデータがない場合全選択状態にする
        _selectedAreaTypes = [NSMutableArray array];
        for (NSNumber *num in self.tableDataList) {
            
            [self.selectedAreaTypes addObject:num];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(didUpdateSelectedAreaTypesOfAreaFilterModel:)]) {
        
        [self.delegate didUpdateSelectedAreaTypesOfAreaFilterModel:self];
    }
}


/**
 全選択の状態を設定する

 @param isAllCheck 全選択フラグ
 */
- (void)setIsAllCheck:(BOOL)isAllCheck
{
    _isAllCheck = isAllCheck;
    
    if ([self.delegate respondsToSelector:@selector(didUpdateIsAllCheckOfAreaFilterModel:)]) {
        
        [self.delegate didUpdateIsAllCheckOfAreaFilterModel:self];
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

@end
