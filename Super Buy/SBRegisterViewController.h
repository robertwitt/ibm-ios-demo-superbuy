//
//  SBRegisterViewController.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMember.h"
#import "SBMembership.h"


@protocol SBRegisterViewControllerDelegate;

@interface SBRegisterViewController : UIViewController

@property (nonatomic) id<SBRegisterViewControllerDelegate> delegate;

@end


@protocol SBRegisterViewControllerDelegate <NSObject>

- (void)registerViewControllerDidCancelRegistration:(SBRegisterViewController *)controller;
- (void)registerViewController:(SBRegisterViewController *)controller didRegisterMember:(SBMember *)member membership:(SBMembership *)membership;

@end