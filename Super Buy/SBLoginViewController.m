//
//  SBLoginViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBLoginViewController.h"
#import "SBRegisterViewController.h"
#import "SBWebAPI.h"


static NSString *SBSegueRegister = @"RegisterSegue";


@interface SBLoginViewController () <SBRegisterViewControllerDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;

@property (weak, nonatomic) IBOutlet UITextField *membershipIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *memberIDTextField;

- (void)prepareForRegisterSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)login;

- (IBAction)onLogin:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


#pragma mark -

@implementation SBLoginViewController


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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SBSegueRegister]) {
        [self prepareForRegisterSegue:segue sender:sender];
    }
}

- (void)prepareForRegisterSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SBRegisterViewController *controller = (SBRegisterViewController *)[segue.destinationViewController topViewController];
    controller.delegate = self;
}


#pragma mark Register View Controller Delegate

- (void)registerViewControllerDidCancelRegistration:(SBRegisterViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)registerViewController:(SBRegisterViewController *)controller didRegisterMember:(SBMember *)member membership:(SBMembership *)membership
{
    if ([self.delegate respondsToSelector:@selector(loginViewController:didLoginWithRegisteredMembership:)]) {
        [self.delegate loginViewController:self didLoginWithRegisteredMembership:membership];
    }
}


#pragma mark Web API Delegate

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBValidateMembershipInput *input = [[SBValidateMembershipInput alloc] init];
    input.memberID = self.memberIDTextField.text;
    input.membershipID = self.membershipIDTextField.text;
    
    [self.webAPI validateMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
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
