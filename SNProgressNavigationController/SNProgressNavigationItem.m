//
//  SNProgressNavigationItem.m
//  SNProgressNavigationController
//
//  Created by Sinoru on 2014. 3. 2..
//  Copyright (c) 2014년 Sinoru. All rights reserved.
//

#import "SNProgressNavigationItem.h"

@interface SNProgressNavigationItem ()

@property (nonatomic, strong) NSNumber *progressValue;
@property (nonatomic, strong) NSNumber *hidesProgressValue;

@end

@implementation SNProgressNavigationItem

- (void)setProgress:(float)progress
{
    self.progressValue = @(progress);
}

- (float)progress
{
    return self.progressValue ? self.progressValue.floatValue : 0;
}

- (void)setProgressValue:(NSNumber *)progressValue
{
    [self willChangeValueForKey:@"progressValue"];
    _progressValue = progressValue;
    [self didChangeValueForKey:@"progressValue"];
}

- (void)setHidesProgress:(BOOL)hidesProgress
{
    self.hidesProgressValue = @(hidesProgress);
}

- (BOOL)hidesProgress
{
    return self.hidesProgressValue ? self.hidesProgressValue.floatValue : NO;
}

- (void)setHidesProgressValue:(NSNumber *)hidesProgressValue
{
    [self willChangeValueForKey:@"hidesProgressValue"];
    _hidesProgressValue = hidesProgressValue;
    [self didChangeValueForKey:@"hidesProgressValue"];
}

@end
