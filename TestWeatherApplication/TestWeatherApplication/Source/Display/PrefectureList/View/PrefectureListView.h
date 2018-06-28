//
//  PrefectureListView.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PrefectureListView;
@protocol PrefectureListViewDelegate<NSObject>

/**
 お気に入りのみ表示ボタン押下時に呼ばれる
 
 @param prefectureListView 対象View
 @param button 対象ボタン
 */
- (void)prefectureListView:(PrefectureListView *)prefectureListView
 didTapFavoriteCheckButton:(UIButton *)button;

/**
 地方で絞込みボタン押下時に呼ばれる
 
 @param prefectureListView 対象View
 @param button 対象ボタン
 */
- (void)prefectureListView:(PrefectureListView *)prefectureListView
 didTapAreaFilterButton:(UIButton *)button;

@end

@interface PrefectureListView : UIView

@property (nonatomic, weak) id<PrefectureListViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *favoriteCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *areaFilterButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - Display Data
/**
 お気に入りのみ表示ボタンの表示設定
 
 @param isFavoriteCheck お気に入りのみ表示フラグ
 */
- (void)displayIsFavoriteCheck:(BOOL)isFavoriteCheck;

@end
