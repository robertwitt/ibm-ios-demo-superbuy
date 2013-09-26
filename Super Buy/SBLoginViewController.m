//
//  SBLoginViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBLoginViewController.h"
#import "SBRegisterViewController.h"


static NSString *SBSegueRegister = @"RegisterSegue";


@interface SBLoginViewController () <UIAlertViewDelegate, SBRegisterViewControllerDelegate>

@property (strong, nonatomic) UIAlertView *loadingAlert;

@property (weak, nonatomic) IBOutlet UITextField *membershipIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *memberIDTextField;

- (void)prepareForRegisterSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)startLogin;
- (void)stopLogin;

- (IBAction)onLogin:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


#pragma mark -

@implementation SBLoginViewController


#pragma mark Managing the View

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.membershipIDTextField = nil;
    self.memberIDTextField = nil;
}

- (IBAction)onLogin:(id)sender
{
    [self startLogin];
}

- (IBAction)onCancel:(id)sender
{
    [self.delegate loginViewControllerdidCancelLogin:self];
}

- (void)startLogin
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Logging in ..."] delegate:self];
    [self.webAPI connectToBackend];
}

- (void)stopLogin
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
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

- (void)backendConnectionEstablished
{
    SBValidateMembershipInput *input = [[SBValidateMembershipInput alloc] init];
    input.memberID = self.memberIDTextField.text;
    input.membershipID = self.membershipIDTextField.text;
    
    [self.webAPI validateMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didValidateMembershipWithOutput:(SBValidateMembershipOutput *)output
{
    [self stopLogin];
    
    if (output.membershipValid) {
        SBMembershipCredentials *credentials = [[SBMembershipCredentials alloc] init];
        credentials.memberID = self.memberIDTextField.text;
        credentials.membershipID = self.membershipIDTextField.text;
        [self.delegate loginViewController:self didLoginWithCredentials:credentials];
    }
    
    else {
        [self showSimpleAlertWithTitle:[self localizedString:@"Membership invalid"]
                               message:output.messages.firstImportantMessage.text];
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailValidatingMembershipWithInput:(SBValidateMembershipInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
