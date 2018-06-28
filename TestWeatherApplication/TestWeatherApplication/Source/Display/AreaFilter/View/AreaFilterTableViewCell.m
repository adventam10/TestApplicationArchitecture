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

/**
 表示処理

 @param area 地方名
 @param isCheck チェック状態
 */
- (void)displayArea:(NSString *)area
            isCheck:(BOOL)isCheck
{
    self.areaLabel.text = area;
    self.checkImageView.highlighted = isCheck;
}

@end
