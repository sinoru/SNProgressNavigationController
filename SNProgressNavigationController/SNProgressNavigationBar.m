//
//  SNProgressNavigationBar.m
//  SNProgressNavigationController
//
//  Created by Sinoru on 2014. 3. 2..
//  Copyright (c) 2014년 Sinoru. All rights reserved.
//

#import "SNProgressNavigationBar.h"

@interface UINavigationBar (private)

- (void)pushNavigationItem:(SNProgressNavigationItem *)item;

@end

@interface SNProgressNavigationBar ()

@property (nonatomic, strong) UIProgressView *progressView;

@end

static int const PrivateKVOContext;

@implementation SNProgressNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Initialization code
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.progressView.progress = self.topItem.progress;
        self.progressView.frame = CGRectMake(0, self.bounds.size.height - 2.f, self.bounds.size.width, 3.f);
        self.progressView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
        
        [self addSubview:self.progressView];
    });
}

- (void)pushNavigationItem:(SNProgressNavigationItem *)item
{
    [super pushNavigationItem:item];
    
    [self.progressView setProgress:item.progress animated:NO];
    
    if (item.hidesProgress != !self.progressView.alpha) {
        [UIView animateWithDuration:0.3f animations:^{
            self.progressView.alpha = !item.hidesProgress;
        }];
    }
    
    [item addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
    [item addObserver:self forKeyPath:@"hidesProgressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
}

- (void)pushNavigationItem:(SNProgressNavigationItem *)item animated:(BOOL)animated
{
    [super pushNavigationItem:item animated:animated];
    
    [self.progressView setProgress:item.progress animated:animated];
    
    if (item.hidesProgress != !self.progressView.alpha) {
        [UIView animateWithDuration:0.3f animations:^{
            self.progressView.alpha = !item.hidesProgress;
        }];
    }
    
    [item addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
    [item addObserver:self forKeyPath:@"hidesProgressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
}

- (SNProgressNavigationItem *)popNavigationItemAnimated:(BOOL)animated
{
    SNProgressNavigationItem *oldItem = (SNProgressNavigationItem *)[super popNavigationItemAnimated:animated];
    
    [oldItem removeObserver:self forKeyPath:@"progressValue"];
    [oldItem removeObserver:self forKeyPath:@"hidesProgressValue"];
    
    SNProgressNavigationItem *item = self.topItem;
    
    [self.progressView setProgress:item.progress animated:animated];
    
    if (item.hidesProgress != !self.progressView.alpha) {
        [UIView animateWithDuration:0.3f animations:^{
            self.progressView.alpha = !item.hidesProgress;
        }];
    }
    
    return oldItem;
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated
{
    [super setItems:items animated:animated];
    
    SNProgressNavigationItem *topItem = items.lastObject;
    
    [self.progressView setProgress:topItem.progress animated:animated];
    
    if (topItem.hidesProgress != !self.progressView.alpha) {
        [UIView animateWithDuration:0.3f animations:^{
            self.progressView.alpha = !topItem.hidesProgress;
        }];
    }
    
    [topItem addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
    [topItem addObserver:self forKeyPath:@"hidesProgressValue" options:NSKeyValueObservingOptionNew context:(void *)&PrivateKVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &PrivateKVOContext) {
        if (![object isEqual:self.topItem])
            return;
        
        if ([keyPath isEqualToString:@"progressValue"]) {
            NSNumber *progressValue = change[NSKeyValueChangeNewKey];
            
            [self.progressView setProgress:progressValue.floatValue animated:YES];
        }
        else if ([keyPath isEqualToString:@"hidesProgressValue"]) {
            NSNumber *hidesProgressValue = change[NSKeyValueChangeNewKey];
            
            if (hidesProgressValue.boolValue != !self.progressView.alpha) {
                [UIView animateWithDuration:0.3f animations:^{
                    self.progressView.alpha = !hidesProgressValue.boolValue;
                }];
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
