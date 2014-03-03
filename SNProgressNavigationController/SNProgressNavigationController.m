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

- (id)init
{
    self = [super initWithNavigationBarClass:[SNProgressNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        [self swizzlingNavigationItem];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self swizzlingNavigationItem];
    }
    return self;
}

- (id)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        [self swizzlingNavigationItem];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:[SNProgressNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        [self swizzlingNavigationItem];
        [self setViewControllers:@[ rootViewController ] animated:NO];
    }
    return self;
}

- (void)swizzlingNavigationItem
{
    IMP originalViewControllerNavigationItemIMP = class_getMethodImplementation([UIViewController class], @selector(navigationItem));
    UINavigationItem *(^customViewControllerNavigationItem)(UIViewController *self) = ^(UIViewController *self) {
        if (![self.navigationController isKindOfClass:[SNProgressNavigationController class]])
            return (UINavigationItem *)originalViewControllerNavigationItemIMP(self, @selector(navigationItem));
        
        UINavigationItem *navigationItem = originalViewControllerNavigationItemIMP(self, @selector(navigationItem));
        
        object_setClass(navigationItem, [SNProgressNavigationItem class]);
        
        return navigationItem;
    };
    method_setImplementation(class_getInstanceMethod([UIViewController class], @selector(navigationItem)), imp_implementationWithBlock(customViewControllerNavigationItem));
}

@end
