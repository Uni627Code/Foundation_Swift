//
//  SocketManager+Category.h
//  UFoundation
//
//  Created by dong on 7.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "SocketManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocketManager (Category)

@property (nonatomic, strong) NSString *categoryName;

- (void)categoryMethod;

@end

NS_ASSUME_NONNULL_END
