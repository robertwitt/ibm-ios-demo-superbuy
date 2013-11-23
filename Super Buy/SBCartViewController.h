//
//  SBCartViewController.h
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//  Version 1.1
//

#import "SBWebAPITableViewController.h"
#import "SBCart.h"


@protocol SBCartViewControllerDelegate;

@interface SBCartViewController : SBWebAPITableViewController

@property (strong, nonatomic) SBCart *cart;
@property (nonatomic) id<SBCartViewControllerDelegate> delegate;

@end


@protocol SBCartViewControllerDelegate <NSObject>

@optional
- (void)cartViewControllerDidCancel:(SBCartViewController *)controller;
- (void)cartViewController:(SBCartViewController *)controller didClearCart:(SBCart *)cart;
- (void)cartViewController:(SBCartViewController *)controller didOrderCart:(SBCart *)cart;

@end
