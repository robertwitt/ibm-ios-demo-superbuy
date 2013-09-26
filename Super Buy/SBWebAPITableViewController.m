//
//  SBWebAPITableViewController.m
//  Super Buy
//
//  Created by Robert Witt on 26.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBWebAPITableViewController.h"


@implementation SBWebAPITableViewController

@synthesize webAPI = _webAPI;


#pragma mark Properties

- (SBWebAPI *)webAPI
{
    if (!_webAPI) {
        _webAPI = [[SBWebAPI alloc] init];
        _webAPI.delegate = self;
    }
    return _webAPI;
}


#pragma mark Managing the View

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    _webAPI = nil;
}


#pragma mark Web API Delegate

- (void)backendConnectionEstablished
{
    // Will be redefined by sub classes
}

- (void)backendConnectionFailedWithError:(NSError *)error
{
    NSString *message = @"A connection to the server couldn't be established. Check your internet connection.";
    [self showSimpleAlertWithTitle:[self localizedString:@"Error"] message:message];
}

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    [self backendConnectionEstablished];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    [self backendConnectionFailedWithError:error];
}

@end
