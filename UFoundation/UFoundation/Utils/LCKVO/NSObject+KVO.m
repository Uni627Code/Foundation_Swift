//
//  NSObject+KVO.m
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/12.
//  Copyright © 2022 Uni. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString *kPPKVOClassPrefix = @"PPObserverPrefix_";
static NSString *kPPKVOAssociateObserver = @"PPAssociateObserver";

#pragma mark - Debug Method
static NSArray *ClassMethodName(Class class){
    NSMutableArray *methodArr = [NSMutableArray array];
    unsigned methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        [methodArr addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    return methodArr;
}


#pragma mark - Tranfrom setter or getter each other Methods
static NSString *setterForGetter(NSString *getter){
    if (getter.length <= 0) { return nil; }
    NSString * firstString = [[getter substringToIndex: 1] uppercaseString];
    NSString * leaveString = [getter substringFromIndex: 1];

    return [NSString stringWithFormat: @"set%@%@:", firstString, leaveString];
}


static NSString * getterForSetter(NSString *setter) {
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"]) {
        return  nil;
    }
    
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *getter = [setter substringWithRange:range];
    
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    
    return getter;
}


#pragma mark -- Override setter and getter Methods

// 实现了 kvoClass 中的 setter 的内容.
static void KVO_setter(id self, SEL _cmd, id newValue) {
    
    /*
       前置条件, 这个方法是 kvoClass 中的的setter, 而kvoClass的superClass是 originalClass

       基本功能:

       保存oldValue
       [self willChangeValueForKey:getterName];
       [super setXXX:xxx];
       [self didChangeValueForKey:getterName];
       保存newValue
       获取observerInfo, 并将 oldValue newValue当做参数, 然后执行handler

       */
    
    // 1. 获取 setter 和 getter的 name str
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    if (!getterName) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat: @"unrecognized selector sent to instance %p", self] userInfo:nil];
        return;
    }
    
    // 2. 保存oldValue
    id oldValue = [self valueForKey:getterName];
    
    // 3. 获取到super对象
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // 4. 手动触发KVO -> 1
    [self willChangeValueForKey:getterName];
    
    // 5. 调用 super 的setter 方法(即 originalClass 的setter方法)
    void(*objc_msgSendSuperKVO)(void *, SEL, id) = (void *)objc_msgSendSuper;
    objc_msgSendSuperKVO(&superClass, _cmd, newValue);
    
    // 6. 手动触发KVO -> 2
    [self didChangeValueForKey:getterName];
    
    // 7. 从关联对象中获取 observer array. 找到对于current key进行观察的 observerInfo对象, 然后将 oldValue newValue,作为参数,执行对应的handler

    // 7. 从关联对象中获取 observer array. 找到对于current key进行观察的 observerInfo对象, 然后将 oldValue newValue,作为参数,执行对应的handler
       NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)kPPKVOAssociateObserver);
       for (PP_ObserverInfo *info in observers) {
           if ([info.key isEqualToString:getterName]) {
               dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   info.handler(self, getterName, oldValue, newValue);
               });
           }
       }
    
    
}

static Class kvo_Class(id self) {
    return  class_getSuperclass(object_getClass(self));
}


@implementation NSObject (KVO)


- (void)pp_addObserver:(NSObject *)observer forKey:(NSString *)key withObservingHandler:(PPObservingHandler)observerHandler {
    
    //1.获取 setter method 如果没有找到就抛出异常
    SEL setterSelector = NSSelectorFromString(setterForGetter(key)); // 通过 getter方法获取setter方法的名称
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);

    if (!setterMethod) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %@", self] userInfo: nil];
               return;
    }
    
    // 2. 检查对象 isa 指向的类是不是一个 KVO 类。如果不是，新建一个继承原来类的子类，并把 isa 指向这个新建的子类
    // object_getClass 实际返回的是 class_object 的isa 指针指向的类
    Class observedClass = object_getClass(self);
    NSString *className = NSStringFromClass(observedClass);
    
    // 2.1 判断这个类是否我们自己创建的类, 如果不是, 那么创建一个类, 继承原来的class, 然后设置isa指针指向这个新建的类
    if (![className hasPrefix:kPPKVOClassPrefix]) {
        observedClass = [self createKVOClassWithOriginalClassName:className];
        
        // 改变self object对象的isa 指针
        object_setClass(self, observedClass);
    }
    
    // 3. 此时 self object的isa指向我们创建的 class, 然后需要检查该类是否重写过没有这个 setter 方法。如果没有，添加重写的 setter 方法；
    if (![self hasSelector:setterSelector]) {
        const char *type = method_getTypeEncoding(setterMethod);
        // 给新类添加setter方法时, 添加 willChangeValueForKey: didChangeValueForKey:, 具体实现在 KVO_setter 中
        class_addMethod(observedClass, setterSelector, (IMP)KVO_setter, type);
    }
    
    // 4. 将这个 observer 信息封装成 PP_ObserverInfo 对象. 通过runtime关联对象, 关联到self object中, 用一个数组将所有的observerInfo 保存起来
    PP_ObserverInfo * newInfo = [[PP_ObserverInfo alloc] initWithObserver:observer forKey:key observerHandler:observerHandler];

    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge void *)kPPKVOAssociateObserver);

    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kPPKVOAssociateObserver), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [observers addObject:newInfo];
    
}

- (void)pp_removeObserver:(NSObject *)object forKey:(NSString *)key {
    // 1. 获取 object 的关联对象, 所有的 observerInfo 的 array
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kPPKVOAssociateObserver));
    
    // 2. 遍历 observerArray, 找到observerInfo 中 observer 和 key 匹配的 info object, 然后将info对象从array中移除
    PP_ObserverInfo * observerRemoved = nil;
    for (PP_ObserverInfo *observerInfo in observers) {
        if (observerInfo.observer == object && [observerInfo.key isEqualToString:key]) {
            observerRemoved = observerInfo;
            break;
        }
    }
    [observers removeObject:observerRemoved];
}


- (Class)createKVOClassWithOriginalClassName: (NSString *)className {
    // 1. 我们自己创建的中间类对象名称 -- kvoClassName
    NSString *kvoClassName = [kPPKVOClassPrefix stringByAppendingString:className];
    //NSClassFromString是一个很有用的东西，用此函数进行动态加载尝试，如果返回nil，则不能加载此类的实例
    
    // 2. 在系统中查找, 该中间类是否被注册到runtime中, 如果找到, 直接返回.
    Class observedClass = NSClassFromString(kvoClassName);
    if (observedClass) {
        return  observedClass;
    }
    
    // 3. 如果系统中没有找到中间类, 那么创建这个类.
    // 3.1 获取原始isa指针指向的Class
    Class originalClass = object_getClass(self);
    // 3.2 给原始类创建一个子类, 暂时称为 kvoClassName, 或者 kvoClass
    Class kvoClass = objc_allocateClassPair(originalClass, kvoClassName.UTF8String, 0);
    // 3.3 获取原始类的 class 方法(isa指针)的 Method对象相关信息
    Method classMethod = class_getInstanceMethod(originalClass, @selector(class));
    const char *type = method_getTypeEncoding(classMethod);
    
    // 3.4 将原始类的class方法(isa指针),的实现修改成 kvo_Class. 或者说将kvoClass 的 isa 指针指向 原始类.
    // 解释: kvo_Class 的实现:  class_getSuperclass(object_getClass(self)), 其中这个self实际是 kvoClass, 因此 superClass, 是 originalClass.
    class_addMethod(kvoClass, @selector(class), (IMP)kvo_Class, type);
    
    // 3.5 最后将kvoClass 注册到runtime
    objc_registerClassPair(kvoClass);
    return  kvoClass;

}

- (BOOL)hasSelector: (SEL) selector {
    
    Class observedClass = object_getClass(self);
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(observedClass, &methodCount);
    
    for (int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (selector == thisSelector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

@end



