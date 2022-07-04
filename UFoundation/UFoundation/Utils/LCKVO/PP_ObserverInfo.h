//
//  PP_ObserverInfo.h
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/12.
//  Copyright © 2022 Uni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PPObservingHandler) (id observedObject, NSString * observedKey, id oldValue, id newValue);

@interface PP_ObserverInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) PPObservingHandler handler;


-(instancetype)initWithObserver:(NSObject *)observer forKey:(NSString *)key observerHandler:(PPObservingHandler)handler;


@end

NS_ASSUME_NONNULL_END
