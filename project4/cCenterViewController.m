//
//  cCenterViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cCenterViewController.h"
#import <Parse/Parse.h>
@interface cCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *ticketArray;
@property (strong, nonatomic) NSArray *pendingArray;
@end

@implementation cCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Billboard"];
    [pwdQuery whereKey:@"patientNo" equalTo:self.patientNo];
    [pwdQuery whereKey:@"confirmedByDoc" equalTo:[NSNumber numberWithBool:YES]];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.ticketArray = [objects mutableCopy];
                [self.tableView reloadData];
            });
        }
    }];
    PFQuery *pwdQuery1 = [PFQuery queryWithClassName:@"Billboard"];
    [pwdQuery1 whereKey:@"patientNo" equalTo:self.patientNo];
    [pwdQuery1 whereKey:@"confirmedByDoc" equalTo:[NSNumber numberWithBool:NO]];
    [pwdQuery1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.pendingArray = [objects mutableCopy];
                [self.tableView reloadData];
            });
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.ticketArray.count;
    }
    return self.pendingArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = [self.ticketArray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"Time:%@ %@",[obj valueForKey:@"AppointmentDate"],[obj valueForKey:@"period"]];
    cell.textLabel.text = str;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Tel: %@",[obj valueForKey:@"docNo"]];
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Confirmed";
    }
    return @"Pending";
}


@end
