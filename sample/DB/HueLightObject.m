//
//  HueLightObject.m
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import "HueLightObject.h"

@implementation HueLightObject

-(id) initialize:(NSString*) hueLightId name:(NSString*)name{
    _hueLightId = hueLightId;
    _name = name;
    return self;
}

@end
