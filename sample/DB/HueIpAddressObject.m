//
//  HueIpAddressObject.m
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import "HueIpAddressObject.h"

@implementation HueIpAddressObject

/**
 * HueIpAddress オブジェクトを 初期化
 * @param hueId hueブリッジのid
 * @param hueId hueブリッジに割り当てられた IPアドレス
 */
-(id) initialize:(NSString*) hueId internalipaddress:(NSString*)ipaddress{
    _hueId = hueId;
    _internalipaddress = ipaddress;
    return self;
}

-(NSDictionary*) toDictionary{
    NSDictionary* result = @{
                             @"hueId":self.hueId,
                             @"internalipaddress":self.internalipaddress};
    return result;
}

@end
