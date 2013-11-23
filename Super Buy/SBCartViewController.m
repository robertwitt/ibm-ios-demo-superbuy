//
//  SBCartViewController.m
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//  Version 1.1
//

#import "SBCartViewController.h"


@interface SBCartViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pointsItem;

- (void)updatePointsItem;
- (void)onCartDidChangeNotification:(NSNotification *)notification;

@end


#pragma mark -

@implementation SBCartViewController


#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
    self.tableView.editing = YES;
    [self updatePointsItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCartDidChangeNotification:)
                                                 name:SBCartDidChangeNotification
                                               object:self.cart];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cart.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBRewardProduct *product = [self.cart.products objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartItemCell"];
    cell.textLabel.text = product.productDescription;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%.2f", product.points.floatValue];
    
    return cell;
}


#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SBRewardProduct *product = [self.cart.products objectAtIndex:indexPath.row];
        [self.cart removeProduct:product];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark Actions

- (IBAction)onCancel:(id)sender
{
    
}

- (IBAction)onClear:(id)sender
{
    [self.cart clear];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)onOrder:(id)sender
{
    
}

- (void)updatePointsItem
{
    self.pointsItem.title = [[NSString alloc] initWithFormat:@"%.2f points", self.cart.sumOfPoints];
}

- (void)onCartDidChangeNotification:(NSNotification *)notification
{
    [self updatePointsItem];
}

@end
