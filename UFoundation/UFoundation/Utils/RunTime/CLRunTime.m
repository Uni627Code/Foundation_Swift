//
//  CLRunTime.m
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/23.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "CLRunTime.h"
#import <objc/runtime.h>

@implementation CLRunTime

- (void)createClass:(NSString *)className {
    
    Class testClass = objc_allocateClassPair([NSObject class], "className", 0);
    
    BOOL isAdded = class_addIvar(testClass, "password", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    
    objc_registerClassPair(testClass);
    
    if (isAdded) {
        id object = [[testClass alloc] init];
        [object setValue:@"mima" forKey:@"password"];
    }
    
}

@end
