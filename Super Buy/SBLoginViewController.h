//
//  SBLoginViewController.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipCredentials.h"
#import "SBMessageArray.h"


@protocol SBLoginViewControllerDelegate;

@interface SBLoginViewController : UIViewController

@property (nonatomic) id<SBLoginViewControllerDelegate> delegate;

@end


@protocol SBLoginViewControllerDelegate <NSObject>

- (void)loginViewControllerdidCancelLogin:(SBLoginViewController *)controller;
- (void)loginViewController:(SBLoginViewController *)controller didLoginWithCredentials:(SBMembershipCredentials *)credentials;

@end