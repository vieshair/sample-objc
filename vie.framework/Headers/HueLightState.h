//
//  HueLightState.h
//  vie
//
//  Created by 古川信行 on 2015/09/30.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 "on": false,
 "bri": 254,
 "hue": 14922,
 "sat": 144,
 "xy": [
 0.4595,
 0.4105
 ],
 "ct": 369,
 "alert": "none",
 "effect": "none",
 "colormode": "ct",
 "reachable": true
 */
@interface HueLightState : NSObject

//ライトのID
@property NSString* lightId;

//電源のON,OFF
@property BOOL on;

//明度 0〜255
@property int bri;

//色相 0〜65535
@property int hue;

//彩度 0〜255
@property int sat;

//イニシャライザ
-(id) initialize:(NSString*) lightId on:(BOOL)on;

/** UIColorでhueカラーを設定する
 * @param color 設定したい UIColor の値
 */
- (void)setRGBColor:(UIColor *)color;

@end
