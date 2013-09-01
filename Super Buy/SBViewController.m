//
//  SBViewController.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBViewController.h"
#import "WorklightAPI/include/WLClient.h"
#import "WorklightAPI/include/WLDelegate.h"
#import "WorklightAPI/include/WLProcedureInvocationData.h"
#import "SBWebAPI.h"


@interface MyInvocationListener : NSObject <WLDelegate>

@end

@implementation MyInvocationListener

- (void)onSuccess:(WLResponse *)response
{
    NSLog(@"%@", [response getResponseJson]);
}

- (void)onFailure:(WLFailResponse *)response
{
    NSLog(@"%@", response.responseText);
}

@end


@interface SBViewController () <WLDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;

@end


@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [[WLClient sharedInstance] wlConnectWithDelegate:self];
    
    self.webAPI = [[SBWebAPI alloc] init];
    self.webAPI.delegate = self;
    [self.webAPI connectToBackend];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSuccess:(WLResponse *)response
{
    NSLog(@"%@", response.responseText);
    
    WLProcedureInvocationData *invocation = [[WLProcedureInvocationData alloc] initWithAdapterName:@"SOAPCRMMobileLoyalty" procedureName:@"getMembership"];
    invocation.parameters = @[@"1"];
    
    MyInvocationListener *listener = [[MyInvocationListener alloc] init];
    
    [[WLClient sharedInstance] invokeProcedure:invocation withDelegate:listener];
}

- (void)onFailure:(WLFailResponse *)response
{
    NSLog(@"%@", response.responseText);
}

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBGetMembershipInput *input = [[SBGetMembershipInput alloc] init];
    input.membershipID = @"1";
    [self.webAPI getMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didGetMembershipWithOutput:(SBGetMembershipOutput *)output
{
    
}

@end
