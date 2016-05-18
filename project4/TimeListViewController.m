//
//  TimeListViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "TimeListViewController.h"
#import "DetailViewController.h"
@interface TimeListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation TimeListViewController
- (IBAction)cancel_pressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _patientList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    
    cell.textLabel.text = [_patientList[indexPath.row] valueForKey:@"period"];
    cell.detailTextLabel.text = [_patientList[indexPath.row] valueForKey:@"patientNo"];
    return  cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    controller.dict = self.patientList[indexPath.row];
    [self presentViewController:controller animated:NO completion:nil];
    
}
@end
