//
//  SNProgressNavigationController.m
//  SNProgressNavigationController
//
//  Created by Sinoru on 2014. 3. 2..
//  Copyright (c) 2014년 Sinoru. All rights reserved.
//

#import "SNProgressNavigationController.h"

#import <objc/runtime.h>

@implementation SNProgressNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IMP originalViewControllerNavigationItemIMP = class_getMethodImplementation([UIViewController class], @selector(navigationItem));
    UINavigationItem *(^customViewControllerNavigationItem)(UIViewController *self) = ^(UIViewController *self) {
        if (![self.navigationController isKindOfClass:[SNProgressNavigationController class]])
            return (UINavigationItem *)originalViewControllerNavigationItemIMP(self, @selector(navigationItem));
        
        UINavigationItem *navigationItem = originalViewControllerNavigationItemIMP(self, @selector(navigationItem));
        
        object_setClass(navigationItem, [SNProgressNavigationItem class]);
        
        return navigationItem;
    };
    method_setImplementation(class_getInstanceMethod([UIViewController class], @selector(navigationItem)), imp_implementationWithBlock(customViewControllerNavigationItem));
    
    [self setValue:[[SNProgressNavigationBar alloc] init] forKeyPath:@"navigationBar"];
}

@end
