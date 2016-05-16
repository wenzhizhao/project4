//
//  MyAppointmentsViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "MyAppointmentsViewController.h"
#import "AppDelegate.h"
@interface MyAppointmentsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (strong,nonatomic) NSMutableArray *appointmentsList;
@end

@implementation MyAppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _appointmentsList = [[NSMutableArray alloc] init];
    PFQuery *patients = [PFQuery queryWithClassName:@"Patients"];
    [patients findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            _appointmentsList = [objects mutableCopy];
            NSLog(@"%@",_appointmentsList);
        }else{
            NSLog(@"%@",[error description]);
        }
        
        [self.mytableView reloadData];
        
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _appointmentsList.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 10, 0, 20); // top, left, bottom, right
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:_appointmentsList[indexPath.row]];
    NSLog(@"%@",_appointmentsList[indexPath.row]);
    cell.textLabel.text = [_appointmentsList[indexPath.row] valueForKey:@"Name"];
    cell.detailTextLabel.text = [_appointmentsList[indexPath.row] valueForKey:@"Mobile"];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"superman.jpg",@"Naruto.jpg",@"Sasuke.jpg",@"Bleach.jpg",@"Itachi.jpg", nil];
    cell.imageView.image = [UIImage imageNamed:arr[indexPath.row%5]];
    return cell;
}
@end
