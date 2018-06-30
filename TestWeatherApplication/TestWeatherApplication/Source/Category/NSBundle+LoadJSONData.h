//
//  NSBundle+LoadJSONData.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle(LoadJSONData)

/**
 プロジェクト内のJSONファイルからデータをDictinary型にして取得する
 
 @param fileName JSONファイル名（拡張子なし）
 @return JSONデータ（Dictinary型）
 */
- (NSDictionary *)loadJSONDataWithFileName:(NSString *)fileName;

@end
