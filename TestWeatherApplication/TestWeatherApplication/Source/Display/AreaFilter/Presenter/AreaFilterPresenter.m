//
//  AreaFilterPresenter.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterPresenter.h"

@interface AreaFilterPresenter()<AreaFilterModelDelegate>

@end

@implementation AreaFilterPresenter

/**
 画面初期表示時の処理
 */
- (void)setupData
{
    self.model.isAllCheck = [self.model checkIsAllCheck];
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


#pragma mark - User Action
/**
 全選択ボタン押した時の処理
 */
- (void)didTapAllSelectButton
{
    self.model.isAllCheck = !self.model.isAllCheck;
    [self.model setupIsAllCheck:self.model.isAllCheck];
}


#pragma mark - UITableView DataSource
/**
 セル選択時の処理

 @param indexPath 対象インデックスパス
 */
- (void)didTablebleViewSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = self.model.tableDataList[indexPath.row];
    [self.model changedSelectedArreaType:num.integerValue];
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
    model.area = [self.model getTitleFromAreaType:num.integerValue];
    model.isCheck = [self.model isCheckWithAreaType:num.integerValue];
    
    return model;
}


#pragma mark - AreaFilterModel Delegate
/**
 選択地方一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateSelectedAreaTypesOfAreaFilterModel:(AreaFilterModel *)model
{
    if (self.model.isAllCheck != [self.model checkIsAllCheck]) {
        
        self.model.isAllCheck = [self.model checkIsAllCheck];
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
