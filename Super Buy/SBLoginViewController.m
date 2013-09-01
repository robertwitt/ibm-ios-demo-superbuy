//
//  SBLoginViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBLoginViewController.h"
#import "SBWebAPI.h"


@interface SBLoginViewController () <SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;

@property (weak, nonatomic) IBOutlet UITextField *membershipIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *memberIDTextField;

- (void)login;

- (IBAction)onLogin:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


@implementation SBLoginViewController

- (SBWebAPI *)webAPI
{
    if (!_webAPI) {
        _webAPI = [[SBWebAPI alloc] init];
        _webAPI.delegate = self;
    }
    return _webAPI;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender
{
    [self login];
}

- (IBAction)onCancel:(id)sender
{
    [self.delegate loginViewControllerdidCancelLogin:self];
}

- (void)login
{
    [self.webAPI connectToBackend];
}


#pragma mark Web API Delegate

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBValidateMembershipInput *input = [[SBValidateMembershipInput alloc] init];
    input.memberID = self.memberIDTextField.text;
    input.membershipID = self.membershipIDTextField.text;
    
    [self.webAPI validateMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didValidateMembershipWithOutput:(SBValidateMembershipOutput *)output
{
    if (output.membershipValid) {
        SBMembershipCredentials *credentials = [[SBMembershipCredentials alloc] init];
        credentials.memberID = self.memberIDTextField.text;
        credentials.membershipID = self.membershipIDTextField.text;
        [self.delegate loginViewController:self didLoginWithCredentials:credentials];
    }
    else {
        // TODO Implement fail
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailValidatingMembershipWithInput:(SBValidateMembershipInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
