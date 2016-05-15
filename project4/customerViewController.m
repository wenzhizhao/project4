//
//  customerViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "customerViewController.h"
#import "customerregisterViewController.h"
@interface customerViewController ()

@end

@implementation customerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)tempJump:(id)sender {
//    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    customerregisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"customerregisterViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
