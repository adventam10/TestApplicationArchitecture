//
//  AreaFilterViewController.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AFVAreaType) {
    AFVAreaTypeHokkaido = 0,
    AFVAreaTypeTohoku,
    AFVAreaTypeKanto,
    AFVAreaTypeChubu,
    AFVAreaTypeKinki,
    AFVAreaTypeChugoku,
    AFVAreaTypeShikoku,
    AFVAreaTypeKyushu,
};

@class AreaFilterViewController;
@protocol AreaFilterViewControllerDelegate<NSObject>

/**
 チェックボタン押下時に呼ばれる
 
 @param areaFilterViewController 対象ViewController
 @param selectedAreaTypes 選択地方タイプ一覧
 */
- (void)areaFilterViewController:(AreaFilterViewController *)areaFilterViewController
     didChangeSelectedAreaTypes:(NSArray <NSNumber *> *)selectedAreaTypes;

@end

@interface AreaFilterViewController : UIViewController

@property (nonatomic, weak) id<AreaFilterViewControllerDelegate> delegate;

@property (nonatomic) NSMutableArray <NSNumber *> *selectedAreaTypes;

@end
