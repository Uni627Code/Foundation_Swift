//
//  PP_ObserverInfo.m
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/12.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "PP_ObserverInfo.h"

#import "NSObject+KVO.h"


@implementation PP_ObserverInfo

-(instancetype)initWithObserver:(NSObject *)observer forKey:(NSString *)key observerHandler:(PPObservingHandler)handler{
    if (self = [super init]) {
        _observer = observer;
        self.key = key;
        self.handler = handler;
    }
    return self;
}

@end


