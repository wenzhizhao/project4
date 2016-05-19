//
//  customerregisterViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "customerregisterViewController.h"

@interface customerregisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)submitBtn:(id)sender;


@end

@implementation customerregisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"customerregisterViewController.h is here");
}



- (IBAction)cancelBtn:(id)sender {
    //pop the vc
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitBtn:(id)sender {
    //check if all the field are filled
    if (self.nameField.text.length>0 && self.passField.text.length>0 && self.mobileField.text.length>0 && self.emailField.text.length>0 && [self checkEmail:self.emailField.text]) {
        //check if the user is alrealdy register
        PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Patients"];
        [pwdQuery whereKey:@"Mobile" equalTo:self.mobileField.text];
        [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if ([objects count]>0) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"password" message:[NSString stringWithFormat:@"Customer is already exsist"] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
                            
                        }];
                        [alert addAction:ok];
                        [self presentViewController:alert animated:YES completion:nil];
                    
                }
                else{
                    PFObject *patients = [PFObject objectWithClassName:@"Patients"];
                    [patients setObject:self.nameField.text forKey:@"Name"];
                    [patients setObject:self.passField.text forKey:@"Password"];
                    [patients setObject:self.mobileField.text forKey:@"Mobile"];
                    [patients setObject:self.emailField.text forKey:@"Email"];
                    
                    [patients saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"congratulation" message:[NSString stringWithFormat:@"you just enrolled in the awesome program"] preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
                                [self.navigationController popViewControllerAnimated:YES];

                            }];
                            [alert addAction:ok];
                            [self presentViewController:alert animated:YES completion:nil];
                            //pop the vc here
//                            sleep(1);
                        });

                    }];
                    

                }
            }
        }];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"some field missed or email is not in good format" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
-(BOOL) checkEmail:(NSString *) email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(BOOL) isPasswordValid:(NSString *)pwd {
//    if ( [pwd length]<5 || [pwd length]>8 ) return NO;  // too long or too short
//    NSRange rang;
//    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
//    if ( !rang.length ) return NO;  // no lower letter
//    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
//    if ( !rang.length ) return NO;  // no upper letter
//    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if ( !rang.length )  return NO;  // no number;
    return YES;
}@end
