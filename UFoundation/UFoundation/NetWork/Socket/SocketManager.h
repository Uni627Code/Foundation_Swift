//
//  SocketManager.h
//  UFoundation
//
//  Created by dong on 7.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocketManager : NSObject

@property (nonatomic, weak) id<SocketProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
