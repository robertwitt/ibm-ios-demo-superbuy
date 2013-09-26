//
//  SBBonusCodeViewController.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBBonusCodeViewController.h"
#import "SBPersistenceAPI.h"


const NSInteger SBBonusCodeLength = 6;


@interface SBBonusCodeViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *loadingAlert;

@property (weak, nonatomic) IBOutlet UITextField *bonusCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (void)startEnteringBonusCode;
- (void)stopEnteringBonusCode;

- (IBAction)onScan:(id)sender;
- (IBAction)onSend:(id)sender;
- (IBAction)onCancel:(id)sender;

@end


#pragma mark -

@implementation SBBonusCodeViewController


#pragma mark Managing the View

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.bonusCodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.bonusCodeTextField = nil;
    self.sendButton = nil;
}

- (IBAction)onScan:(id)sender
{
    [self showSimpleAlertWithTitle:[self localizedString:@"Sorry"]
                           message:[self localizedString:@"Scanning a bonus code with the camera is currently not supported."]];
}

- (IBAction)onSend:(id)sender
{
    [self.bonusCodeTextField resignFirstResponder];
    [self startEnteringBonusCode];
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

- (void)startEnteringBonusCode
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Processing ..."] delegate:self];
    [self.webAPI connectToBackend];
}

- (void)stopEnteringBonusCode
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)backendConnectionEstablished
{
    SBEnterBonusCodeInput *input = [[SBEnterBonusCodeInput alloc] init];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    input.bonusCode = [numberFormatter numberFromString:self.bonusCodeTextField.text];
    
    SBMembershipCredentials *credentials = [[SBPersistenceAPI sharedInstance] readMembershipCredentials];
    input.membershipID = credentials.membershipID;
    
    if (input.membershipID) {
        [self.webAPI enterBonusCodeWithInput:input];
    }
    else {
        // TODO Implement fail case
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didEnterBonusCodeWithOutput:(SBEnterBonusCodeOutput *)output
{
    [self stopEnteringBonusCode];
    
    SBPointTransaction *transaction = output.transactions.lastObject;
    
    if (transaction) {
        NSString *message = [self localizedString:@"We credited to your account %@ points."];
        [self showSimpleAlertWithTitle:[self localizedString:@"Thank you"]
                               message:[NSString stringWithFormat:message, transaction.actualPoints]];
    }
    else {
        [self showSimpleAlertWithTitle:[self localizedString:@"Error"]
                               message:output.messages.firstImportantMessage.text];
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailEnteringBonusCodeWithInput:(SBEnterBonusCodeInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
