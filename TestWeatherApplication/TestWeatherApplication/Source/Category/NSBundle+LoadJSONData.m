//
//  NSBundle+LoadJSONData.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "NSBundle+LoadJSONData.h"

@implementation NSBundle(LoadJSONData)

/**
 プロジェクト内のJSONファイルからデータをDictinary型にして取得する

 @param fileName JSONファイル名（拡張子なし）
 @return JSONデータ（Dictinary型）
 */
- (NSDictionary *)loadJSONDataWithFileName:(NSString *)fileName
{
    NSString *filePath = [self pathForResource:fileName ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
    return dic;
}

@end
