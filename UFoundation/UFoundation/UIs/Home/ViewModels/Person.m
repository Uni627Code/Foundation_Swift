//
//  Person.m
//  UFoundation
//
//  Created by dong on 9.11.21.
//

#import "Person.h"
#import <objc/runtime.h>
//#import "UFoundation-Swift.h"
#import "OCBiridge.h"

@implementation Person


//MARK: - 动态方法解析
void sendMessage(id self, SEL _cmd, NSString *msg) {
    NSLog(@"动态方法解析 == %@", msg);

    
}

/// 对象方法进行决议
/// @param sel sel description
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    //1.匹配方法
    NSString *methodName = NSStringFromSelector(sel);

    if ([methodName isEqualToString:@"sendMessage:"]) {
        return class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
    }
    return  false;
}

/// 类方法进行决议
/// @param sel sel description
+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return  false;
}

//MARK: -  快速转发 - 直接指向方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *methodName = NSStringFromSelector(aSelector);
    
    if ([methodName isEqualToString:@"sendMessage:"]) {
//        HomeViewModel *objc = [[HomeViewModel alloc] init];
//
//        [objc sendMessage:@"快速转发"];

    }
    
    return  [super forwardingTargetForSelector:aSelector];
    
}




//MARK: - 慢速转发
//1.方法签名
//2.消息转发

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSString *methodName = NSStringFromSelector(aSelector);
    
    if ([methodName isEqualToString:@"sendMessage:"]) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    
    return  [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL sel = [anInvocation selector];
    
//    HomeViewModel *tempObj = [[HomeViewModel alloc] init];
//    if ([tempObj respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:tempObj];
//    } else {
//        [super forwardInvocation:anInvocation];
//    }
    [super forwardInvocation:anInvocation];

}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"找不到方法");
}


@end
