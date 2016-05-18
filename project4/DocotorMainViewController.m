//
//  DocotorMainViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "DocotorMainViewController.h"
#import "MyCalendarViewController.h"
#import "MyAppointmentsViewController.h"
#import "AppDelegate.h"
#import "MyProfileViewController.h"
@interface DocotorMainViewController (){
    UIActivityIndicatorView *ActivityIndicator;
}
@property (weak, nonatomic) IBOutlet UITableView *docotorTableView;
@property (strong,nonatomic) NSMutableArray *paitientsList;
@end

@implementation DocotorMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, self.view.frame.size.height/2, 30, 30)];
    [self.view addSubview:ActivityIndicator];
    ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [ActivityIndicator startAnimating];

    UIBarButtonItem *MyActivity = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Calendar-25.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Myactivities:)];
    MyActivity.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = MyActivity;
    self.docotorTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentMobile"];

    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Billboard"];
    [pwdQuery whereKey:@"docNo" equalTo:mobile];
    
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            _paitientsList = [[NSMutableArray alloc]initWithArray:objects];
            //            NSLog(@"%@",_paitientsList);
            [ActivityIndicator stopAnimating];
        }else{
            NSLog(@"%@",[error localizedDescription]);
        }
        
    }];

}


-(void)Myactivities: (id)sender{
    
    MyCalendarViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCalendarViewController"];
    if (self.paitientsList != nil) {
        controller.PatietList = self.paitientsList;
        [self presentViewController:controller animated:YES completion:nil];
    }
  
    
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
        case 0:
            cell.textLabel.text = @"My Appointments";
            break;
        case 1:
            cell.textLabel.text = @"My Profile";
            break;

        case 2:
            cell.textLabel.text = @"My Reminder";
            break;

        case 3:
            cell.textLabel.text = @"My SMS";
            break;

        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MyAppointmentsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAppointmentsViewController"];
        if (self.paitientsList != nil) {
            controller.patientList = self.paitientsList;
            [self.navigationController pushViewController:controller animated:YES];
            
        }

    }else if(indexPath.row == 1){
        MyProfileViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];        
        
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.row == 2){
        
        
    }
    
    
}

- (IBAction)logOut_pressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}






@end
