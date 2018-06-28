//
//  AreaFilterModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AreaFilterModel;
@protocol AreaFilterModelDelegate<NSObject>

/**
 選択地方一覧が更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateSelectedAreaTypesOfAreaFilterModel:(AreaFilterModel *)model;

/**
 全選択フラグが更新された時に呼ばれる
 
 @param model 対象Model
 */
- (void)didUpdateIsAllCheckOfAreaFilterModel:(AreaFilterModel *)model;

@end


@interface AreaFilterModel : NSObject

@property (nonatomic, weak) id<AreaFilterModelDelegate> delegate;

@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;

@property (nonatomic) NSArray <NSNumber *> *tableDataList;

@property (nonatomic) BOOL isAllCheck;

@end
