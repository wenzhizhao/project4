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
@property (strong, nonatomic) NSMutableArray *ticketArray;
@property (strong, nonatomic) NSMutableArray *pendingArray;
@property (strong, nonatomic) NSMutableArray *idYesArray;
@property (strong, nonatomic) NSMutableArray *idNoArray;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatior;

@end

@implementation cCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidden:YES];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.idYesArray = [[NSMutableArray alloc]init];
    self.idNoArray = [[NSMutableArray alloc]init];
    PFQuery *pwdQuery3 = [PFQuery queryWithClassName:@"Billboard"];
    [pwdQuery3 whereKey:@"patientNo" equalTo:self.patientNo];
    [pwdQuery3 whereKey:@"confirmedByDoc" equalTo:[NSNumber numberWithBool:YES]];

    [pwdQuery3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i<objects.count; i++) {
                [self.idYesArray addObject:[[objects objectAtIndex:i] valueForKey:@"objectId"]];
            }
        }
    }];
    PFQuery *pwdQuery4 = [PFQuery queryWithClassName:@"Billboard"];
    [pwdQuery4 whereKey:@"patientNo" equalTo:self.patientNo];
    [pwdQuery4 whereKey:@"confirmedByDoc" equalTo:[NSNumber numberWithBool:NO]];
    
    [pwdQuery4 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i<objects.count; i++) {
                [self.idNoArray addObject:[[objects objectAtIndex:i] valueForKey:@"objectId"]];
            }
        }
    }];

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
    if (indexPath.section == 0) {
        PFObject *obj = [self.ticketArray objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"Time:%@ %@",[obj valueForKey:@"AppointmentDate"],[obj valueForKey:@"period"]];
        cell.textLabel.text = str;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Tel: %@",[obj valueForKey:@"docNo"]];
    }
    else{
        PFObject *obj = [self.pendingArray objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"Time:%@ %@",[obj valueForKey:@"AppointmentDate"],[obj valueForKey:@"period"]];
        cell.textLabel.text = str;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Tel: %@",[obj valueForKey:@"docNo"]];
    }

    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Confirmed";
    }
    return @"Pending";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    sleep(1.3);

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [self.indicatorView setHidden:NO];

            [self.activityIndicatior startAnimating];

            [_ticketArray removeObjectAtIndex:indexPath.row];
            PFQuery *pwdQuery1 = [PFQuery queryWithClassName:@"Billboard"];
            [pwdQuery1 whereKey:@"objectId" equalTo:[self.idYesArray objectAtIndex:indexPath.row]];
//            PFObject *obj = [[pwdQuery1 findObjects] lastObject];
            [pwdQuery1 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                PFObject *obj = [objects lastObject];
                [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [self.tableView reloadData];
                        [self.activityIndicatior stopAnimating];
                        [self.indicatorView setHidden:YES];
                    });
                }];
            }];


        }
        else{
            [self.indicatorView setHidden:NO];

            [self.activityIndicatior startAnimating];
            PFQuery *pwdQuery1 = [PFQuery queryWithClassName:@"Billboard"];
            [pwdQuery1 whereKey:@"objectId" equalTo:[self.idNoArray objectAtIndex:indexPath.row]];
            [pwdQuery1 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                PFObject *obj = [objects lastObject];
                [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_pendingArray removeObjectAtIndex:indexPath.row];

                            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                            [self.tableView reloadData];
                            sleep(1.3);
                            [self.activityIndicatior stopAnimating];
                            [self.indicatorView setHidden:YES];
                        });
                    }else {
                        
                    NSLog(@"NOT SUCCESSFUL DELETE: %@",error);
                    }
                }];
            }];
            
        }
    }
}

@end
