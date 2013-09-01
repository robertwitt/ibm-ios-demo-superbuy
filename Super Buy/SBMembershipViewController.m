//
//  SBMembershipViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipViewController.h"
#import "SBLoginViewController.h"
#import "SBWebAPI.h"


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


@interface SBMembershipViewController () <SBLoginViewControllerDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;
@property (strong, nonatomic) SBMembershipCredentials *credentials;
@property (strong, nonatomic) SBMembership *membership;

- (UITableViewCell *)generalCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tierCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)pointAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)prepareForLoginSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation SBMembershipViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
}

- (void)prepareForLoginSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SBLoginViewController *controller = (SBLoginViewController *)[segue.destinationViewController topViewController];
    controller.delegate = self;
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
