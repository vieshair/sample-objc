//
//  RLMUtil.m
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import "RLMUtil.h"

@implementation RLMUtil

//hue ブリッジのIPアドレスを保存
+(void) saveHueBridge:(HueIpAddressObject*) hueObj{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    //hueIdで検索
    NSString* where = [NSString stringWithFormat:@"hueId='%@'",hueObj.hueId];
    RLMResults *hueList = [HueIpAddressObject objectsWhere:where];
    if(hueList.count == 0){
        //追加
        [realm addObject:hueObj];
    }
    else{
        //更新
        HueIpAddressObject* obj = [hueList objectAtIndex:0];
        obj.hueId = hueObj.hueId;
        obj.internalipaddress = hueObj.internalipaddress;
    }
    [realm commitWriteTransaction];
}

//記録済みのhueブリッジ情報を削除する
+(void) resetHueBridge{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //hueブリッジ一覧を削除
    RLMResults *results = [HueIpAddressObject allObjects];
    for (HueIpAddressObject *object in results) {
        [realm deleteObject:object];
    }
    [realm commitWriteTransaction];
    
    [self resetHueLight];
}

//ライト一覧削除
+(void) resetHueLight{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //ライト一覧
    RLMResults *results = [HueLightObject allObjects];
    for (HueLightObject *object in results) {
        [realm deleteObject:object];
    }
    [realm commitWriteTransaction];
}

//ブリッジ一覧を取得
+(NSArray*) allHueBridge{
    RLMResults *results = [HueIpAddressObject allObjects];
    NSMutableArray *array =  [NSMutableArray arrayWithCapacity:results.count];
    for (HueIpAddressObject *object in results) {
        [array addObject:object];
    }
    return array;
}

//hueブリッジに繋がっているライトの設定を保存
+(void) saveHueLight:(HueLightObject*) hueLightObj{
    DLog(@"saveHueLight:%@",hueLightObj);
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    //hueLightIdで検索
    NSString* where = [NSString stringWithFormat:@"hueLightId='%@'",hueLightObj.hueLightId];
    RLMResults *hueList = [HueLightObject objectsWhere:where];
    if(hueList.count == 0){
        //追加
        [realm addObject:hueLightObj];
    }
    else{
        //更新
        HueLightObject* obj = [hueList objectAtIndex:0];
        obj.hueLightId = hueLightObj.hueLightId;
        obj.name = hueLightObj.name;
        obj.vieLink = hueLightObj.vieLink;
    }
    [realm commitWriteTransaction];
}

+(void) setHueLightVieLink:(HueLightObject*) hueLightObj islink:(BOOL) islink{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    hueLightObj.vieLink = islink;
    [realm commitWriteTransaction];
}

//hueブリッジに繋がっているライト一覧を取得
+(NSArray*) allHueLight{
    RLMResults *results = [HueLightObject allObjects];
    NSMutableArray *array =  [NSMutableArray arrayWithCapacity:results.count];
    for (HueLightObject *object in results) {
        [array addObject:object];
    }
    return array;
}

@end
