//
//  SBMemberViewController.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMemberViewController.h"
#import "SBWebAPI.h"


const NSInteger SBSectionMemberGeneral = 0;
const NSInteger SBRowMemberID = 0;
const NSInteger SBRowName = 1;
const NSInteger SBSectionAddress = 1;
const NSInteger SBRowCountry = 0;
const NSInteger SBRowRegion = 1;
const NSInteger SBRowCity = 2;
const NSInteger SBRowPostalCode = 3;
const NSInteger SBRowStreet = 4;
const NSInteger SBRowHouseNumber = 5;
const NSInteger SBRowEmailAddress = 6;

static NSString *SBCellMember = @"MemberCell";


@interface SBMemberViewController () <UIAlertViewDelegate, SBWebAPIDelegate>

@property (strong, nonatomic) SBWebAPI *webAPI;
@property (strong, nonatomic) SBMember *member;
@property (strong, nonatomic) UIAlertView *loadingAlert;

- (void)startGettingMember;
- (void)stopGettingMember;

@end


#pragma mark -

@implementation SBMemberViewController


#pragma mark Properties

- (void)setMemberID:(NSString *)memberID
{
    if (![memberID isEqualToString:_memberID]) {
        _memberID = memberID;
        self.member = nil;
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
    
    if (!self.member) {
        [self startGettingMember];
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
    NSInteger section = 0;
    if (self.member) {
        section = 2;
    }
    
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (section) {
        case SBSectionMemberGeneral:
            rows = 2;
            break;
        case SBSectionAddress:
            rows = 7;
            break;
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text;
    NSString *detailText;
    
    switch (indexPath.section) {
        case SBSectionMemberGeneral:
            switch (indexPath.row) {
                case SBRowMemberID:
                    text = [self localizedString:@"Member ID"];
                    detailText = self.member.ID;
                    break;
                case SBRowName:
                    text = [self localizedString:@"Name"];
                    detailText = self.member.name;
                    break;
                default:
                    break;
            }
            break;
            
        case SBSectionAddress:
            switch (indexPath.row) {
                case SBRowCountry:
                    text = [self localizedString:@"Country"];
                    detailText = self.member.address.countryText;
                    break;
                case SBRowRegion:
                    text = [self localizedString:@"Region"];
                    detailText = self.member.address.regionText;
                    break;
                case SBRowCity:
                    text = [self localizedString:@"City"];
                    detailText = self.member.address.city;
                    break;
                case SBRowPostalCode:
                    text = [self localizedString:@"Zipcode"];
                    detailText = self.member.address.postalCode;
                    break;
                case SBRowStreet:
                    text = [self localizedString:@"Street"];
                    detailText = self.member.address.street;
                    break;
                case SBRowHouseNumber:
                    text = [self localizedString:@"House no"];
                    detailText = self.member.address.houseNumber;
                    break;
                case SBRowEmailAddress:
                    text = [self localizedString:@"Email"];
                    detailText = self.member.address.emailAddress;
                    break;
                default:
                    break;
            }
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBCellMember forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    
    return cell;
}


#pragma mark Web API Delegate

- (void)startGettingMember
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Loading ..."] delegate:self];
    [self.webAPI connectToBackend];
}

- (void)stopGettingMember
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI
{
    SBGetMemberInput *input = [[SBGetMemberInput alloc] init];
    input.memberID = self.memberID;
    [self.webAPI getMemberWithInput:input];
}

- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didGetMemberWithOutput:(SBGetMemberOutput *)output
{
    [self stopGettingMember];
    
    if (output.member) {
        self.member = output.member;
        [self.tableView reloadData];
    }
    else {
        // TODO Implement fail
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailGettingMemberWithInput:(SBGetMemberInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
