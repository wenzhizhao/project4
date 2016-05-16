//
//  SignInViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "DocotorMainViewController.h"
#import "AppDelegate.h"
@interface SignInViewController ()
- (IBAction)signInBtn_pressed:(UIButton *)sender;
- (IBAction)SignUp_pressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFied;

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


- (IBAction)textDidchangeInField:(UITextField *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _passwordTextFied.text = [defaults valueForKey:_mobileNumberTextfield.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _mobileNumberTextfield) {
        [_passwordTextFied becomeFirstResponder];
    }else{
        [_passwordTextFied resignFirstResponder];
    }
    return YES;
}

- (IBAction)signInBtn_pressed:(UIButton *)sender {    
    
    PFQuery *passwordQuery = [PFQuery queryWithClassName:@"Docotors"];
    [passwordQuery whereKey:@"Mobile" equalTo:_mobileNumberTextfield.text];
[passwordQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    if (!error) {
        
        if ([_passwordTextFied.text isEqualToString:[objects.lastObject valueForKey:@"Password"]]) {
            DocotorMainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DocotorMainViewController"];
            
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            UIAlertController *password = [UIAlertController alertControllerWithTitle:@"" message:@"Mobile number and password are not match" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [password addAction:OK];
            [self presentViewController:password animated:YES completion:nil];
            
            
        }
        
    }
}];
    
    
    
    

}
- (IBAction)forgotPasswordBtn_Pressed:(UIButton *)sender {
    PFQuery *passwordQuery = [PFQuery queryWithClassName:@"Docotors"];
    [passwordQuery whereKey:@"Mobile" equalTo:_mobileNumberTextfield.text];
    [passwordQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            

    UIAlertController *password = [UIAlertController alertControllerWithTitle:@"Your Password" message:[objects.lastObject valueForKey:@"Password"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [password addAction:OK];
    [self presentViewController:password animated:YES completion:nil];

        }
    }];
}

- (IBAction)SignUp_pressed:(UIButton *)sender {

    SignUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
