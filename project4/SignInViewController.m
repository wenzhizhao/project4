//
//  SignInViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
@interface SignInViewController ()
- (IBAction)signInBtn_pressed:(UIButton *)sender;
- (IBAction)SignUp_pressed:(UIButton *)sender;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signInBtn_pressed:(UIButton *)sender {


}

- (IBAction)SignUp_pressed:(UIButton *)sender {
//    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Docotors"];
//    [pwdQuery whereKey:@"Mobile" equalTo:@"3126477415"];
//    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        if (!error) {
//            if ([objects count]>0) {
//                
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"password" message:[NSString stringWithFormat:@"Customer is already exsist"] preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
//                }];
//                [alert addAction:ok];
//                [self presentViewController:alert animated:YES completion:nil];
//                
//            }else{
//                
//                
//                PFObject *patients = [PFObject objectWithClassName:@"Docotors"];
//                [patients setObject:@"Michael"forKey:@"Name"];
//                [patients setObject:@"Chou" forKey:@"Password"];
//                [patients setObject:@"3126477415" forKey:@"Mobile"];
//                [patients setObject:@"yzhou088@gmail.com" forKey:@"Email"];
//                [patients saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
//                
//            }
//            
//        } else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];

    SignUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:controller animated:YES completion:nil];
    
}
@end
