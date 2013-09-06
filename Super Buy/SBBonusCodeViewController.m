//
//  SBBonusCodeViewController.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBBonusCodeViewController.h"
#import "SBWebAPI.h"
#import "SBPersistenceCoordinator.h"


const NSInteger SBBonusCodeLength = 6;


@interface SBBonusCodeViewController () <UITextFieldDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;

@property (weak, nonatomic) IBOutlet UITextField *bonusCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)onScan:(id)sender;
- (IBAction)onSend:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


#pragma mark -

@implementation SBBonusCodeViewController


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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.bonusCodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScan:(id)sender
{
    [self showSimpleAlertWithTitle:[self localizedString:@"Sorry"]
                           message:[self localizedString:@"Scanning a bonus code with the camera is currently not supported."]];
}

- (IBAction)onSend:(id)sender
{
    [self.webAPI connectToBackend];
}

- (IBAction)onCancel:(id)sender
{
    self.bonusCodeTextField.text = nil;
    [self.bonusCodeTextField resignFirstResponder];
}


#pragma mark Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.sendButton.enabled = (newText.length >= SBBonusCodeLength);
    
    return newText.length <= SBBonusCodeLength;
}


#pragma mark Web API delegate

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBEnterBonusCodeInput *input = [[SBEnterBonusCodeInput alloc] init];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    input.bonusCode = [numberFormatter numberFromString:self.bonusCodeTextField.text];
    
    SBMembershipCredentials *credentials = [[SBPersistenceCoordinator sharedInstance] readMembershipCredentials];
    input.membershipID = credentials.membershipID;
    
    if (input.membershipID) {
        [self.webAPI enterBonusCodeWithInput:input];
    }
    else {
        // TODO Implement fail case
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didEnterBonusCodeWithOutput:(SBEnterBonusCodeOutput *)output
{
    SBPointTransaction *transaction = output.transactions.lastObject;
    
    if (transaction) {
        NSString *message = [self localizedString:@"We credited to your account %@ points."];
        [self showSimpleAlertWithTitle:[self localizedString:@"Thank you"]
                               message:[NSString stringWithFormat:message, transaction.actualPoints]];
    }
    else {
        // TODO Implement fail case
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailEnteringBonusCodeWithInput:(SBEnterBonusCodeInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
