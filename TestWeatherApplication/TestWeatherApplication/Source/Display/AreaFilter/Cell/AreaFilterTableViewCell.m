//
//  AreaFilterTableViewCell.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterTableViewCell.h"

//=======================================================
// 地方で絞込みセル
//=======================================================

@interface AreaFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@end

@implementation AreaFilterTableViewCell

#pragma mark - Setter
/**
 地方のチェック状態の設定を行う
 
 @param isCheck 都道府県情報
 */
- (void)setIsCheck:(BOOL)isCheck
{
    _isCheck = isCheck;
    self.checkImageView.highlighted = isCheck;
}


/**
 地方ラベルの表示設定を行う
 
 @param title 地方の文字列
 */
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.areaLabel.text = title;
}

@end
