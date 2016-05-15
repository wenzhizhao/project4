//
//  DocotorMainViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "DocotorMainViewController.h"

@interface DocotorMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *docotorTableView;

@end

@implementation DocotorMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *MyActivity = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Calendar-25.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Myactivities:)];
    MyActivity.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = MyActivity;
    self.docotorTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
}



-(void)Myactivities: (id)sender{
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text = @"My Appointments";
            break;
        case 2:
            cell.textLabel.text = @"My Profile";
            break;

        case 3:
            cell.textLabel.text = @"My Reminder";
            break;

        case 4:
            cell.textLabel.text = @"My SMS";
            break;

            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}







@end
