//
//  PrefectureListTableViewCell.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PrefectureListTableViewCell;
@protocol PrefectureListTableViewCellDelegate<NSObject>

/**
 お気に入りボタン押下時に呼ばれる

 @param cell 対象セル
 @param button 対象ボタン
 */
- (void)prefectureListTableViewCell:(PrefectureListTableViewCell *)cell
               didTapFavoriteButton:(UIButton *)button;

@end

@interface PrefectureListTableViewCell : UITableViewCell

@property (nonatomic) NSDictionary *prefectureInfo;

@property (nonatomic) BOOL isFavorite;

@property (nonatomic, weak) id<PrefectureListTableViewCellDelegate> delegate;

@end
