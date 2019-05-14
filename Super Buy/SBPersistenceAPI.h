//
//  SBPersistenceAPI.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipCredentials.h"


@interface SBPersistenceAPI : NSObject

- (SBMembershipCredentials *)readMembershipCredentials;
- (void)writeMembershipCredentials:(SBMembershipCredentials *)credentials;

+ (SBPersistenceAPI *)sharedInstance;

@end
