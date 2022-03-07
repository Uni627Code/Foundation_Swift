//
//  SocketProtocol.h
//  UFoundation
//
//  Created by dong on 7.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SocketProtocol <NSObject>


/// 协议方法
- (void) protocolMethod;


/// 协议属性
@property (nonatomic, strong) NSString *protocolName;

@end

NS_ASSUME_NONNULL_END
