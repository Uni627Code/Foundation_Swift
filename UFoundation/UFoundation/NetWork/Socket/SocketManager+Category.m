//
//  SocketManager+Category.m
//  UFoundation
//
//  Created by dong on 7.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "SocketManager+Category.h"
#import <objc/runtime.h>

const NSString *socketKey;

@implementation SocketManager (Category)


- (void)setCategoryName:(NSString *)categoryName {
    objc_setAssociatedObject(self, &socketKey, categoryName,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)categoryName {
    
    return  objc_getAssociatedObject(self, &socketKey);
}

- (void)categoryMethod {
    
}

@end
