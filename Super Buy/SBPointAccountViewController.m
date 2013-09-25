//
//  SBPointAccountViewController.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPointAccountViewController.h"
#import "SBWebAPI.h"


const NSInteger SBSectionPAGeneral = 0;
const NSInteger SBRowPointsEarned = 0;
const NSInteger SBRowPointsConsumed = 1;
const NSInteger SBRowPointsExpired = 2;
const NSInteger SBRowPointBalance = 3;
const NSInteger SBSectionTransactions = 1;

static NSString *SBCellDefault = @"DefaultCell";
static NSString *SBCellTransaction = @"TransactionCell";


@interface SBPointAccountViewController () <UIAlertViewDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;
@property (strong, nonatomic) SBPointAccount *pointAccount;
@property (strong, nonatomic) UIAlertView *loadingAlert;

- (UITableViewCell *)generalCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)transactionCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)startGettingPointAccount;
- (void)stopGettingPointAccount;

@end


#pragma mark -

@implementation SBPointAccountViewController


#pragma mark Properties

- (void)setPointAccountID:(NSString *)pointAccountID
{
    if (![pointAccountID isEqualToString:_pointAccountID]) {
        _pointAccountID = pointAccountID;
        self.pointAccount = nil;
    }
}

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
    
    if (!self.pointAccount) {
        [self startGettingPointAccount];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 0;
    if (self.pointAccount) {
        sections = 2;
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (section) {
        case SBSectionPAGeneral:
            rows = 4;
            break;
        case SBSectionTransactions:
            rows = self.pointAccount.transactions.count;
            break;
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case SBSectionPAGeneral:
            cell = [self generalCellForRowAtIndexPath:indexPath];
            break;
        case SBSectionTransactions:
            cell = [self transactionCellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return cell;
}

- (UITableViewCell *)generalCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text;
    NSString *detailText;
    
    switch (indexPath.row) {
        case SBRowPointsEarned:
            text = [self localizedString:@"Points earned"];
            detailText = [NSString stringWithFormat:@"%@", self.pointAccount.pointsEarned];
            break;
        case SBRowPointsConsumed:
            text = [self localizedString:@"Points consumed"];
            detailText = [NSString stringWithFormat:@"%@", self.pointAccount.pointsConsumed];
            break;
        case SBRowPointsExpired:
            text = [self localizedString:@"Points expired"];
            detailText = [NSString stringWithFormat:@"%@", self.pointAccount.pointsExpired];
            break;
        case SBRowPointBalance:
            text = [self localizedString:@"Point balance"];
            detailText = [NSString stringWithFormat:@"%@", self.pointAccount.pointBalance];
            break;
        default:
            break;
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SBCellDefault forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    
    return cell;
}

- (UITableViewCell *)transactionCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBPointTransaction *transaction = [self.pointAccount.transactions objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SBCellTransaction forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", transaction.transactionTypeText, transaction.transactionReasonText, transaction.actualPoints];
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:transaction.postingDate
                                                               dateStyle:NSDateFormatterFullStyle
                                                               timeStyle:NSDateFormatterMediumStyle];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    
    switch (section) {
        case SBSectionPAGeneral:
            title = [self localizedString:@"General"];
            break;
        case SBSectionTransactions:
            title = [self localizedString:@"Transactions"];
            break;
        default:
            break;
    }
    return title;
}


#pragma mark Web API Delegate

- (void)startGettingPointAccount
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Loading ..."] delegate:self];
    [self.webAPI connectToBackend];
}

- (void)stopGettingPointAccount
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBGetPointAccountInput *input = [[SBGetPointAccountInput alloc] init];
    input.pointAccountID = self.pointAccountID;
    [self.webAPI getPointAccountWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didGetPointAccountWithOutput:(SBGetPointAccountOutput *)output
{
    [self stopGettingPointAccount];
    
    if (output.pointAccount) {
        self.pointAccount = output.pointAccount;
        [self.tableView reloadData];
    }
    else {
        // TODO Implement fail
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailGettingPointAccountWithInput:(SBGetPointAccountInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
