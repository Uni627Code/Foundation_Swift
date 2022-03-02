//
//  OCBiridge.m
//  UFoundation
//
//  Created by dong on 9.11.21.
//

#import "OCBiridge.h"
#import "Person.h"
#import <objc/message.h>


@implementation OCBiridge

- (void)testMethod {
//    Person *objc = [[Person alloc] init];
//    [objc sendMessage:@"hello"];
    
    ((void (*) (id, SEL, id))objc_msgSend)([Person new], @selector(sendMessage:), @"login");

    
}



@end
