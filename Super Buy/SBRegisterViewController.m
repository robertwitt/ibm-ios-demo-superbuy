//
//  SBRegisterViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBRegisterViewController.h"
#import "SBWebAPI.h"


@interface SBRegisterViewController () <UITextFieldDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (void)registerMember;

- (IBAction)onRegister:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


#pragma mark -

@implementation SBRegisterViewController


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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.firstNameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRegister:(id)sender
{
    [self registerMember];
}

- (IBAction)onCancel:(id)sender
{
    [self.delegate registerViewControllerDidCancelRegistration:self];
}

- (void)registerMember
{
    [self.webAPI connectToBackend];
}


#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    if (nextTag > 8) {
        nextTag = 1;
    }
    
    [[self.view viewWithTag:nextTag] becomeFirstResponder];
    
    return YES;
}


#pragma mark Web API Delegate

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBRegisterMembershipInput *input = [[SBRegisterMembershipInput alloc] init];
    input.firstName = self.firstNameTextField.text;
    input.lastName = self.lastNameTextField.text;
    input.street = self.streetTextField.text;
    input.houseNumber = self.houseNumberTextField.text;
    input.country = self.countryTextField.text;
    input.postalCode = self.postalCodeTextField.text;
    input.city = self.cityTextField.text;
    input.emailAddress = self.emailTextField.text;
    
    [self.webAPI registerMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didRegisterMembershipWithOutput:(SBRegisterMembershipOutput *)output
{
    if (output.member && output.membership) {
        [self.delegate registerViewController:self didRegisterMember:output.member membership:output.membership];
    }
    else {
        // TODO Implement fail case
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailRegisteringMembershipWithInput:(SBRegisterMembershipInput *)input error:(NSError *)error
{
    // TODO Implement fail case
}

@end
