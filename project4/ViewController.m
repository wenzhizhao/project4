//
//  ViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "ViewController.h"
#import "customerViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"haha");
    NSLog(@"michael ");
    NSLog(@"wenzi");
    
    
    int i = 443 ;
    NSLog(@"%d",i);
}

- (IBAction)nextStoryBoard:(id)sender {
    
    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    customerViewController *contrller =  [storyboard instantiateViewControllerWithIdentifier:@"customerViewController"];
    
    [self presentViewController:contrller animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
