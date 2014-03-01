//
//  SNProgressNavigationController.h
//  SNProgressNavigationController
//
//  Created by Sinoru on 2014. 3. 2..
//  Copyright (c) 2014년 Sinoru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SNProgressNavigationController/SNProgressNavigationBar.h>
#import <SNProgressNavigationController/SNProgressNavigationItem.h>

@interface SNProgressNavigationController : UINavigationController

@end

@interface UIViewController (SNProgressNavigationController)

@property(nonatomic,readonly,retain) SNProgressNavigationItem *navigationItem;
@property(nonatomic,readonly,retain) SNProgressNavigationController *navigationController;

@end
