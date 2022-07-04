//
//  CLRunTime.h
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/23.
//  Copyright © 2022 Uni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLRunTime : NSObject

/// 动态创建一个类
/// @param className className description
- (void)createClass:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
