//
//  AreaFilterModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaFilterModel : NSObject

@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;

@property (nonatomic) NSArray <NSNumber *> *tableDataList;

#pragma mark - Status Check
/**
 すべて選択の選択状態を判定する
 
 @return すべて選択のチェック状態
 */
- (BOOL)isAllCheck;

/**
 対象の地方の選択状態を判定する
 
 @param areaType 対象地方
 @return 対象の地方の選択状態
 */
- (BOOL)isCheckWithAreaType:(AFVAreaType)areaType;

/**
 対象の地方の画面表示用文字列を取得する
 
 @param areaType 対象地方
 @return 画面表示用文字列
 */
- (NSString *)getTitleFromAreaType:(AFVAreaType)areaType;

/**
 すべて選択状態の変更処理
 
 @param isAllCheck すべて選択フラグ
 */
- (void)setupIsAllCheck:(BOOL)isAllCheck;

/**
 地方の絞込みの選択状態変更処理
 
 @param areaType 対象地方
 */
- (void)changedSelectedArreaType:(AFVAreaType)areaType;

@end
