//
//  HueIpAddressObject.h
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"

@interface HueIpAddressObject : RLMObject
@property NSString* hueId;
@property NSString* internalipaddress;

/**
 * HueIpAddress オブジェクトを 初期化
 * @param hueId hueブリッジのid
 * @param hueId hueブリッジに割り当てられた IPアドレス
 */
-(id) initialize:(NSString*) hueId internalipaddress:(NSString*)ipaddress;

-(NSDictionary*) toDictionary;

@end
