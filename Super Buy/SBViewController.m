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


@interface SBViewController () <WLDelegate>

@end


@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[WLClient sharedInstance] wlConnectWithDelegate:self];
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

@end
