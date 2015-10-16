//
//  RLMUtil.h
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
#import "HueIpAddressObject.h"
#import "HueLightObject.h"
#import "CommonUtil.h"

@interface RLMUtil : NSObject

//hue ブリッジのIPアドレスを保存
+(void) saveHueBridge:(HueIpAddressObject*) hueObj;

//記録済みのhueブリッジ情報を削除する
+(void) resetHueBridge;

//ブリッジ一覧を取得
+(NSArray*) allHueBridge;

//hue ブリッジに繋がっているライトの設定を保存
+(void) saveHueLight:(HueLightObject*) hueLightObj;

//hueブリッジに繋がっているライト一覧を取得
+(NSArray*) allHueLight;

+(void) setHueLightVieLink:(HueLightObject*) hueLightObj islink:(BOOL) islink;

//ライト一覧削除
+(void) resetHueLight;

@end
