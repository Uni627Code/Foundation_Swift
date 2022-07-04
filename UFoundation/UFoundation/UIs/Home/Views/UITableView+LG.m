//
//  UITableView+LG.m
//  UFoundation
//  黑魔法
//  Created by dong on 9.11.21.
//

#import "UITableView+LG.h"
#import <objc/runtime.h>

const char *LGDefaultView;

@implementation UITableView (LG)

+ (void)load {
//    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
//    
//    Method currentMethod = class_getInstanceMethod(self, @selector(lg_reloadData));
//    
//    method_exchangeImplementations(originMethod, currentMethod);
}


- (void)lg_reloadData {
    [self lg_reloadData];
    [self fillDefaultView];
}

- (void)fillDefaultView {
    
    id<UITableViewDataSource> dataSource = self.dataSource;
    
    NSInteger section =([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]? [dataSource numberOfSectionsInTableView:self] : 1) ;
    
    NSInteger rows = 0;
    for (NSInteger i = 0; i < section; i++) {
        rows = [dataSource tableView:self numberOfRowsInSection:i];
    }
    
    if (!rows) {
        
        [self addSubview:self.LgDefaultView];
    } else {
        self.LgDefaultView.hidden = YES;
    }
    
}


#pragma  mark -- 分类添加属性

- (void) setLgDefaultView:(UIView *)LgDefaultView {
    objc_setAssociatedObject(self, &LGDefaultView, LgDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *) LgDefaultView {
    UIView *_defaultView = objc_getAssociatedObject(self, &LGDefaultView);
    if (!_defaultView) {
        _defaultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _defaultView.backgroundColor = [UIColor redColor];
    }
    return _defaultView;
}

@end
