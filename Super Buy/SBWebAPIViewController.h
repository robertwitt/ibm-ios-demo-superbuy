//
//  SBWebAPIViewController.h
//  Super Buy
//
//  Created by Robert Witt on 26.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBWebAPI.h"


@interface SBWebAPIViewController : UIViewController <SBWebAPIDelegate>

@property (strong, nonatomic, readonly) SBWebAPI *webAPI;

- (void)backendConnectionEstablished;
- (void)backendConnectionFailedWithError:(NSError *)error;

@end
