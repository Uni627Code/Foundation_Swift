//
//  NSObject+KVO.h
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/12.
//  Copyright © 2022 Uni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PP_ObserverInfo.h"

NS_ASSUME_NONNULL_BEGIN


@interface NSObject (KVO)

-(void)pp_addObserver:(NSObject *)object forKey:(NSString *)key withObservingHandler:(PPObservingHandler)observerHandler;

-(void)pp_removeObserver:(NSObject *)object forKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
