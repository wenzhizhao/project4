//
//  cloginViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cloginViewController.h"
#import "cPickingViewController.h"

#import <Parse/Parse.h>

@interface cloginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
- (IBAction)loginBtn:(id)sender;


@end

@implementation cloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginBtn:(id)sender {
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Patients"];
    [pwdQuery whereKey:@"Mobile" equalTo:self.mobileField.text];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([self.passField.text isEqualToString:[[objects lastObject] valueForKey:@"Password"]]) {
                //pop to cpick vc
                cPickingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cPickingViewController"];
//                [self presentViewController:vc  animated:YES completion:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }

        }
    }];
    
}
@end
