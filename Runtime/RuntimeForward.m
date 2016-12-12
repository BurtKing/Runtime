//
//  RuntimeForward.m
//  Runtime
//
//  Created by Burt on 2016/11/21.
//  Copyright © 2016年 Burt. All rights reserved.
//

#import "RuntimeForward.h"

@implementation RuntimeForward
+(void)load
{
    NSLog(@"NoneClass _cmd: %@", NSStringFromSelector(_cmd));
}

- (void) noneClassMethod
{
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
}
@end
