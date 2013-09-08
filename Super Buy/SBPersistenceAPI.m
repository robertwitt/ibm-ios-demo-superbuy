//
//  SBPersistenceAPI.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPersistenceAPI.h"


static SBPersistenceAPI *Singleton;
static NSString *SBKeyMemberID = @"SBKeyMemberID";
static NSString *SBKeyMembershipID = @"SBKeyMembershipID";


@implementation SBPersistenceAPI

- (SBMembershipCredentials *)readMembershipCredentials
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    SBMembershipCredentials *credentials = [[SBMembershipCredentials alloc] init];
    credentials.memberID = [userDefaults objectForKey:SBKeyMemberID];
    credentials.membershipID = [userDefaults objectForKey:SBKeyMembershipID];
    
    if (!credentials.memberID && !credentials.membershipID) {
        credentials = nil;
    }
    
    return credentials;
}

- (void)writeMembershipCredentials:(SBMembershipCredentials *)credentials
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:credentials.memberID forKey:SBKeyMemberID];
    [userDefaults setObject:credentials.membershipID forKey:SBKeyMembershipID];
    [userDefaults synchronize];
}

+ (SBPersistenceAPI *)sharedInstance
{
    if (!Singleton) {
        Singleton = [[SBPersistenceAPI alloc] init];
    }
    return Singleton;
}

@end
