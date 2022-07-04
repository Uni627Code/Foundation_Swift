//
//  SocketManager.m
//  UFoundation
//
//  Created by dong on 7.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "SocketManager.h"

@interface SocketManager ()<SocketProtocol>

@end

@implementation SocketManager

@synthesize protocolName;

- (void)protocolMethod {
    [_delegate protocolMethod];
}

@end

