//
//  MyProfileViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppDelegate.h"
@interface MyProfileViewController ()
@property(nonatomic,strong) NSDictionary *doctorInfo;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *EmailtextFild;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    PFQuery *docInfo = [PFQuery queryWithClassName:@"Docotors"];
    [docInfo whereKey:@"Mobile" equalTo:[defaults objectForKey:@"CurrentMobile"]];
    [docInfo findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            _doctorInfo = objects.lastObject;
            if (_doctorInfo!=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _PhoneNumber.text = [NSString stringWithFormat:@"Mobile: %@",[defaults objectForKey:@"CurrentMobile"]];
                    
                    _textView.text = _doctorInfo[@"Description"];
                    
                    _EmailtextFild.text = _doctorInfo[@"Email"];
                    
                    _addressLabel.text = _doctorInfo[@"Address"];
                    
                    _nameLabel.text = [NSString stringWithFormat:@"%@ %@",_doctorInfo[@"FirstName"],_doctorInfo[@"LastName"]];
                    
                });

            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaveBtn_pressed:(id)sender {
    PFQuery *docInfo = [PFQuery queryWithClassName:@"Docotors"];
    [docInfo getObjectInBackgroundWithId:[_doctorInfo valueForKey:@"objectId"]
                                 block:^(PFObject *confirmation, NSError *error) {
                                     
                                  confirmation[@"Description"] = _textView.text;
                                     
                                  confirmation[@"Email"] = _EmailtextFild.text;
                                     
                                  confirmation[@"Address"] = _addressLabel.text;
                                     
                                     
                                     
                                     
                                     [confirmation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                         if (!error) {
                                             UIAlertController *confirmation = [UIAlertController alertControllerWithTitle:@"" message:@"Your Information has been updated" preferredStyle:UIAlertControllerStyleAlert];
                                             UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                 
                                                 [self.navigationController popViewControllerAnimated:YES];
                                                 
                                             }];
                                             [confirmation addAction:OK];
                                             [self presentViewController:confirmation animated:YES completion:nil];
                                             
                                         }
                                     }];
                                 }];
    
}















@end
