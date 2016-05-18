//
//  cTimeTableViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cTimeTableViewController.h"
#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"


@interface cTimeTableViewController ()
@property (strong, nonatomic) NSMutableDictionary *unavailableTime;
@property (strong, nonatomic) NSMutableArray *availableArray;
@property (strong, nonatomic) NSMutableArray *stringArray;
@end

@implementation cTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.availableArray = [[NSMutableArray alloc]initWithCapacity:3];
    self.unavailableTime = [[NSMutableDictionary alloc]initWithCapacity:3];
    self.stringArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    if ([self.period isEqualToString:@"Morning"]) {
        self.unavailableTime = [NSMutableDictionary
                                dictionaryWithDictionary:@{
                                 @"9-10":[NSNumber numberWithInt:0],
                                 @"10-11":[NSNumber numberWithInt:0],
                                 @"11-12":[NSNumber numberWithInt:0]}];
        self.stringArray = [NSMutableArray arrayWithArray:@[@"9-10",@"10-11",@"11-12"]];
    }
    else if ([self.period isEqualToString:@"Afternoon"]){
        self.unavailableTime = [NSMutableDictionary
                                dictionaryWithDictionary:@{
                               @"13-14":[NSNumber numberWithInt:0],
                               @"14-15":[NSNumber numberWithInt:0],
                               @"15-16":[NSNumber numberWithInt:0]}];
        self.stringArray = [NSMutableArray arrayWithArray:@[@"13-14",@"14-15",@"15-16"]];

    }
    else if ([self.period isEqualToString:@"Evening"]){
        self.unavailableTime = [NSMutableDictionary
                                dictionaryWithDictionary:@{
                               @"17-18":[NSNumber numberWithInt:0],
                               @"18-19":[NSNumber numberWithInt:0],
                               @"19-20":[NSNumber numberWithInt:0]}];
        self.stringArray = [NSMutableArray arrayWithArray:@[@"17-18",@"18-19",@"19-20"]];

    }
    
    NSLog(@"%@",self.ticketArray);
    NSLog(@"%@",self.docNumber);
    NSLog(@"%@",self.period);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    for (int i = 0; i<self.ticketArray.count; i++) {
        if ([[_ticketArray[i] valueForKey:@"confirmedByDoc"] boolValue] == YES) {
            [self.unavailableTime setValue:[NSNumber numberWithInt:[[self.unavailableTime valueForKey:[_ticketArray[i] valueForKey:@"period"]] intValue]+1] forKey:[_ticketArray[i] valueForKey:@"period"]];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.period isEqualToString:@"Morning"]) {
        if (indexPath.row == 0) {
            NSNumber *num = [self.unavailableTime valueForKey:@"9-10"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"9-10";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[0] = available;
                
            }
            else{
                cell.textLabel.text = @"9-10";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[0] = [NSNumber numberWithInt:0];

            }
        }
        if (indexPath.row == 1) {
            NSNumber *num = [self.unavailableTime valueForKey:@"10-11"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"10-11";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[1] = available;

            }
            else{
                cell.textLabel.text = @"10-11";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[1] = [NSNumber numberWithInt:0];

            }
        }
        if (indexPath.row == 2) {
            NSNumber *num = [self.unavailableTime valueForKey:@"11-12"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"11-12";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[2] = available;

            }
            else{
                cell.textLabel.text = @"11-12";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[2] = [NSNumber numberWithInt:0];

            }
        }
    }
    if ([self.period isEqualToString:@"Afternoon"]) {
        if (indexPath.row == 0) {
            NSNumber *num = [self.unavailableTime valueForKey:@"13-14"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"13-14";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[0] = available;

            }
            else{
                cell.textLabel.text = @"13-14";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[0] = [NSNumber numberWithInt:0];

            }
        }
        if (indexPath.row == 1) {
            NSNumber *num = [self.unavailableTime valueForKey:@"14-15"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"14-15";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[1] = available;

            }
            else{
                cell.textLabel.text = @"14-15";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[1] = [NSNumber numberWithInt:0];

            }        }
        if (indexPath.row == 2) {
            NSNumber *num = [self.unavailableTime valueForKey:@"15-16"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"15-16";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[2] = available;

            }
            else{
                cell.textLabel.text = @"15-16";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[2] = [NSNumber numberWithInt:0];

            }
        }
    }
    if ([self.period isEqualToString:@"Evening"]) {
        if (indexPath.row == 0) {
            NSNumber *num = [self.unavailableTime valueForKey:@"17-18"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"17-18";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[0] = available;

            }
            else{
                cell.textLabel.text = @"17-18";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[0] = [NSNumber numberWithInt:0];

            }
        }
        if (indexPath.row == 1) {
            NSNumber *num = [self.unavailableTime valueForKey:@"18-19"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"18-19";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[1] = available;

            }
            else{
                cell.textLabel.text = @"18-19";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[1] = [NSNumber numberWithInt:0];

            }
        }
        if (indexPath.row == 2) {
            NSNumber *num = [self.unavailableTime valueForKey:@"19-20"];
            if ([num intValue]<=2) {
                NSNumber *available = [NSNumber numberWithInt:2-[num intValue]];
                cell.textLabel.text = @"19-20";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",[available intValue]];
                self.availableArray[2] = available;

            }
            else{
                cell.textLabel.text = @"19-20";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"available:%d",0];
                self.availableArray[2] = [NSNumber numberWithInt:0];

            }
        }
    }

    // Configure the cell...
    
    return cell;
}
-(NSArray*)mergeArrays:(NSArray*)a joinArg2:(NSArray*)b{
    int aCount = (int)a.count;
    int bCount = (int)b.count;
    NSMutableArray *result = [[NSMutableArray alloc]init];
    while(aCount>0 && bCount>0){
        if(a[aCount-1]>b[bCount-1]){
            result[aCount+bCount-1] = a[aCount-1];
            aCount--;
        }
        else{
            result[aCount+bCount-1] = b[bCount-1];
            bCount--;
        }
    }
    while(bCount>0){
        result[aCount+bCount-1]=b[bCount-1];
    }
    
    return result;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"the available time:%@",self.availableArray);
    if ([self.availableArray[indexPath.row] intValue] == 0) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Not Available" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [vc addAction:action];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
            detailViewController.dataString = [NSString stringWithFormat:@"%@",self.dateStr];
        detailViewController.patientNo = [self.patientNo mutableCopy];
        detailViewController.docNo = [self.docNumber mutableCopy];
        detailViewController.period = [self.stringArray[indexPath.row] mutableCopy];
        [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
    }
}


@end
