//
//  SBPersistenceCoordinator.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipCredentials.h"


@interface SBPersistenceCoordinator : NSObject

- (SBMembershipCredentials *)readMembershipCredentials;
- (void)writeMembershipCredentials:(SBMembershipCredentials *)credentials;

+ (SBPersistenceCoordinator *)sharedInstance;

@end
