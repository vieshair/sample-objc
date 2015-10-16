//
//  HueLightObject.h
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"

@interface HueLightObject : RLMObject
@property NSString* hueLightId;
@property NSString* name;
@property BOOL vieLink;

-(id) initialize:(NSString*) hueLightId name:(NSString*)name;

@end
