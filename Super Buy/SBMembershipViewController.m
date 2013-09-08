//
//  SBMembershipViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipViewController.h"
#import "SBLoginViewController.h"
#import "SBMemberViewController.h"
#import "SBPointAccountViewController.h"
#import "SBWebAPI.h"
#import "SBPersistenceAPI.h"


const NSInteger SBSectionGeneral = 0;
const NSInteger SBRowMembershipID = 0;
const NSInteger SBRowMembershipStatus = 1;
const NSInteger SBRowMember = 2;
const NSInteger SBSectionTiers = 1;
const NSInteger SBSectionPointAccounts = 2;

static NSString *SBCellDefault = @"DefaultCell";
static NSString *SBCellMember = @"MemberCell";
static NSString *SBCellPointAccount = @"PointAccountCell";

static NSString *SBSegueLogin = @"LoginSegue";
static NSString *SBSegueMember = @"MemberSegue";
static NSString *SBSeguePointAccount = @"PointAccountSegue";


@interface SBMembershipViewController () <SBLoginViewControllerDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;
@property (strong, nonatomic) SBMembershipCredentials *credentials;
@property (strong, nonatomic) SBMembership *membership;

- (UITableViewCell *)generalCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tierCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)pointAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)prepareForLoginSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForMemberSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForPointAccountSegue:(UIStoryboardSegue *)segue sender:(id)sender;

- (IBAction)onReload:(id)sender;

@end


#pragma mark -

@implementation SBMembershipViewController

@synthesize credentials = _credentials;


#pragma mark Properties

- (SBWebAPI *)webAPI
{
    if (!_webAPI) {
        _webAPI = [[SBWebAPI alloc] init];
        _webAPI.delegate = self;
    }
    return _webAPI;
}

- (SBMembershipCredentials *)credentials
{
    if (!_credentials) {
        _credentials = [[SBPersistenceAPI sharedInstance] readMembershipCredentials];
    }
    return _credentials;
}

- (void)setCredentials:(SBMembershipCredentials *)credentials
{
    if (![credentials isEqual:_credentials]) {
        _credentials = credentials;
        [[SBPersistenceAPI sharedInstance] writeMembershipCredentials:credentials];
        self.membership = nil;
    }
}


#pragma mark Managing the View

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.credentials && !self.membership) {
        [self.webAPI connectToBackend];
    }
    else if (!self.credentials) {
        [self performSegueWithIdentifier:SBSegueLogin sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SBSegueLogin]) {
        [self prepareForLoginSegue:segue sender:sender];
    }
    else if ([segue.identifier isEqualToString:SBSegueMember]) {
        [self prepareForMemberSegue:segue sender:sender];
    }
    else if ([segue.identifier isEqualToString:SBSeguePointAccount]) {
        [self prepareForPointAccountSegue:segue sender:sender];
    }
}

- (void)prepareForLoginSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SBLoginViewController *controller = (SBLoginViewController *)[segue.destinationViewController topViewController];
    controller.delegate = self;
}

- (void)prepareForMemberSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SBMemberViewController *controller = (SBMemberViewController *)segue.destinationViewController;
    controller.memberID = self.membership.memberID;
}

- (void)prepareForPointAccountSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    SBMshPointAccount *pointAccount = [self.membership.pointAccounts objectAtIndex:indexPath.row];
    
    SBPointAccountViewController *controller = (SBPointAccountViewController *)segue.destinationViewController;
    controller.pointAccountID = pointAccount.ID;
}

- (IBAction)onReload:(id)sender
{
    [self.webAPI connectToBackend];
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = 0;
    if (self.membership) {
        section = 3;
    }
    
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (section) {
        case SBSectionGeneral:
            rows = 3;
            break;
        case SBSectionTiers:
            rows = self.membership.tiers.count;
            break;
        case SBSectionPointAccounts:
            rows = self.membership.pointAccounts.count;
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
        case SBSectionGeneral:
            cell = [self generalCellForRowAtIndexPath:indexPath];
            break;
        case SBSectionTiers:
            cell = [self tierCellForRowAtIndexPath:indexPath];
            break;
        case SBSectionPointAccounts:
            cell = [self pointAccountCellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    return cell;
}

- (UITableViewCell *)generalCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    NSString *text;
    NSString *detailText;
    
    switch (indexPath.row) {
        case SBRowMembershipID:
            cellIdentifier = SBCellDefault;
            text = [self localizedString:@"Membership ID"];
            detailText = self.membership.ID;
            break;
            
        case SBRowMembershipStatus:
            cellIdentifier = SBCellDefault;
            text = [self localizedString:@"Status"];
            detailText = self.membership.statusText;
            break;
            
        case SBRowMember:
            cellIdentifier = SBCellMember;
            text = [self localizedString:@"Member"];
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;

    return cell;
}

- (UITableViewCell *)tierCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBMshTier *tier = [self.membership.tiers objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SBCellDefault forIndexPath:indexPath];
    cell.textLabel.text = tier.tierLevelText;
    cell.detailTextLabel.text = tier.statusText;
    
    return cell;
}

- (UITableViewCell *)pointAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBMshPointAccount *pointAccount = [self.membership.pointAccounts objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SBCellPointAccount forIndexPath:indexPath];
    cell.textLabel.text = pointAccount.pointTypeText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", pointAccount.pointBalance];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    
    switch (section) {
        case SBSectionGeneral:
            title = [self localizedString:@"General"];
            break;
        case SBSectionTiers:
            title = [self localizedString:@"Tiers"];
            break;
        case SBSectionPointAccounts:
            title = [self localizedString:@"Point Accounts"];
            break;
        default:
            break;
    }
    return title;
}


#pragma mark Login View Controller Delegate

- (void)loginViewControllerdidCancelLogin:(SBLoginViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)loginViewController:(SBLoginViewController *)controller didLoginWithCredentials:(SBMembershipCredentials *)credentials
{
    self.credentials = credentials;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.webAPI connectToBackend];
    }];
}

- (void)loginViewController:(SBLoginViewController *)controller didLoginWithRegisteredMembership:(SBMembership *)membership
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.membership = membership;
        [self.tableView reloadData];
    }];
}


#pragma mark Web API Delegate

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBGetMembershipInput *input = [[SBGetMembershipInput alloc] init];
    input.membershipID = self.credentials.membershipID;
    [self.webAPI getMembershipWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didGetMembershipWithOutput:(SBGetMembershipOutput *)output
{
    if (output.membership) {
        self.membership = output.membership;
        [self.tableView reloadData];
    }
    else {
        // TODO Implement fail
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailGettingMembershipWithInput:(SBGetMembershipInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
