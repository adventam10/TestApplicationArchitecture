//
//  AreaFilterTableViewCell.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaFilterTableViewCell : UITableViewCell

/**
 表示処理
 
 @param area 地方名
 @param isCheck チェック状態
 */
- (void)displayArea:(NSString *)area
            isCheck:(BOOL)isCheck;

@end
