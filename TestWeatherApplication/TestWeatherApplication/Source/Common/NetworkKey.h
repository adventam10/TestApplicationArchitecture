//
//  NetworkKey.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/27.
//  Copyright © 2018年 am10. All rights reserved.
//

#ifndef NetworkKey_h
#define NetworkKey_h

//=======================================================
// 通信関連の定数
//=======================================================

/// 天気取得のURL
static NSString *const NWKBaseUrlString = @"http://weather.livedoor.com/forecast/webservice/json/v1";

///地域
static NSString * const NWKLocation = @"location";

///地方名
static NSString * const NWKArea = @"area";

///都道府県名
static NSString * const NWKPrefecture = @"prefecture";

///1次細分区名
static NSString * const NWKCity = @"city";

///タイトル・見出し
static NSString * const NWKTitle = @"title";

///天気情報リンク
static NSString * const NWKLink = @"link";

///予報の発表日時
static NSString * const NWKPublicTime = @"publicTime";

///天気概況文
static NSString * const NWKDescription = @"description";

///天気概況文
static NSString * const NWKText = @"text";

///府県天気予報の予報日毎の配列
static NSString * const NWKForecasts = @"forecasts";

///予報日
static NSString * const NWKDate = @"date";

///予報日（今日、明日、明後日のいずれか）
static NSString * const NWKDateLabel = @"dateLabel";

///天気（晴れ、曇り、雨など）
static NSString * const NWKTelop = @"telop";

///アイコン
static NSString * const NWKImage = @"image";

///天気アイコンのURL
static NSString * const NWKUrl = @"url";

///天気アイコンの幅
static NSString * const NWKWidth = @"width";

///天気アイコンの高さ
static NSString * const NWKHeight = @"height";

///気温
static NSString * const NWKTemperature = @"temperature";

///最高気温
static NSString * const NWKMax = @"max";

///最低気温
static NSString * const NWKMin = @"min";

///摂氏
static NSString * const NWKCelsius = @"celsius";

///華氏
static NSString * const NWKFahrenheit = @"fahrenheit";

///ピンポイント予報の発表地点の配列
static NSString * const NWKPinpointLocation = @"pinpointLocation";

///市区町村名
static NSString * const NWKName = @"name";

///コピーライト
static NSString * const NWKCopyright = @"copyright";

///livedoor 天気情報で使用している気象データの配信
static NSString * const NWKProvider = @"provider";

#endif /* NetworkKey_h */
