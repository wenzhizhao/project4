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
    
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Patients"];
    [pwdQuery whereKey:@"Mobile" equalTo:@"3126477415"];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            
            
            
            
            
            if ([objects count]>0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"password" message:[NSString stringWithFormat:@"Customer is already exsist"] preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
                    
                    
                    
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                PFObject *patients = [PFObject objectWithClassName:@"Patients"];
                [patients setObject:@"Michael"forKey:@"Name"];
                [patients setObject:@"Chou" forKey:@"Password"];
                [patients setObject:@"3126477415" forKey:@"Mobile"];
                [patients setObject:@"yzhou088@gmail.com" forKey:@"Email"];
                
                [patients saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    
                    
                    
                    
                    
                    
                }];
                
            }
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
    
    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    customerViewController *contrller =  [storyboard instantiateViewControllerWithIdentifier:@"customerViewController"];
    [self presentViewController:contrller animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
