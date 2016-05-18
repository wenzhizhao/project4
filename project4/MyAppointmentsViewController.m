//
//  MyAppointmentsViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "MyAppointmentsViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
@interface MyAppointmentsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@end

@implementation MyAppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _patientList.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 10, 0, 20); // top, left, bottom, right
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:_appointmentsList[indexPath.row]];
    NSLog(@"%@",_patientList[indexPath.row]);
    cell.textLabel.text = [_patientList[indexPath.row] valueForKey:@"patientNo"];
    cell.detailTextLabel.text =  [[_patientList[indexPath.row] valueForKey:@"confirmedByDoc"] isEqual:@(1)]? @"Confirmed":@"Waiting for congirmation";
//    NSLog(@"%@",[_patientList[indexPath.row] valueForKey:@"confirmedByDoc"]);
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    controller.dict = _patientList[indexPath.row];
//    [self.navigationController pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
