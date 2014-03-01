//
//  SNProgressNavigationBar.h
//  SNProgressNavigationController
//
//  Created by Sinoru on 2014. 3. 2..
//  Copyright (c) 2014년 Sinoru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNProgressNavigationItem;

@interface SNProgressNavigationBar : UINavigationBar

- (void)pushNavigationItem:(SNProgressNavigationItem *)item animated:(BOOL)animated;
- (SNProgressNavigationItem *)popNavigationItemAnimated:(BOOL)animated;

@property(nonatomic,readonly,retain) SNProgressNavigationItem *topItem;
@property(nonatomic,readonly,retain) SNProgressNavigationItem *backItem;

- (void)setItems:(NSArray *)items animated:(BOOL)animated;

@end
