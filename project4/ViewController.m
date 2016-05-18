//
//  ViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "ViewController.h"
#import "customerViewController.h"
#import <Parse/Parse.h>
#import "SignInViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (IBAction)docotorEntrece:(id)sender {
    SignInViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)nextStoryBoard:(id)sender {
    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    customerViewController *contrller =  [storyboard instantiateViewControllerWithIdentifier:@"customerViewController"];
//    [self presentViewController:contrller animated:YES completion:nil];
    [self.navigationController pushViewController:contrller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
