//
//  HueIpAddress.h
//  vie
//
//  Created by 古川信行 on 2015/09/30.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HueIpAddress : NSObject
@property (readonly,retain) NSString* hueId;
@property (readonly,retain) NSString* internalipaddress;

/**
 * HueIpAddress オブジェクトを 初期化
 * @param hueId hueブリッジのid
 * @param hueId hueブリッジに割り当てられた IPアドレス
 */
-(id) initialize:(NSString*) hueId internalipaddress:(NSString*)ipaddress;

@end
