//
//  DetailViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentStatus;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn_outlet;
- (IBAction)confirmBtn_pressed:(UIButton *)sender;

@end

@implementation DetailViewController
- (IBAction)backBtn_pressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _profileImage.layer.cornerRadius = 3;
    _profileImage.layer.borderWidth = 3;
    _profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _profileImage.layer.masksToBounds = YES;
    _NumberLabel.text = [NSString stringWithFormat:@"Patient No: %@",[_dict valueForKey:@"patientNo"]];
    _periodLabel.text = [NSString stringWithFormat:@"Time period: %@",[_dict valueForKey:@"period"]];
    _DateLabel.text = [NSString stringWithFormat:@"Date: %@",[_dict valueForKey:@"AppointmentDate"]];
    
    _appointmentStatus.text = [[_dict valueForKey:@"confirmedByDoc"] isEqual:@(1)]? @"Status: Confirmed":@"Status: Waiting for confirmation";
    _confirmBtn_outlet.hidden = [[_dict valueForKey:@"confirmedByDoc"] isEqual:@(1)]? true:false;
    
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

- (IBAction)confirmBtn_pressed:(UIButton *)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Billboard"];
    [query getObjectInBackgroundWithId:[_dict valueForKey:@"objectId"]
                                 block:^(PFObject *confirmation, NSError *error) {
                                     confirmation[@"confirmedByDoc"] = [NSNumber numberWithBool:YES];
                                     [confirmation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                         if (!error) {
                                             UIAlertController *confirmation = [UIAlertController alertControllerWithTitle:@"" message:@"The appointment has been confirmed!" preferredStyle:UIAlertControllerStyleAlert];
                                             UIAlertAction *OK = [UIAlertAction actionWithTitle:@"Send Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                    sender.hidden = true;
                                                 
                                                 if ([MFMailComposeViewController canSendMail]) {
                                                     MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
                                                     mailController.mailComposeDelegate = self;
                                                     [mailController setSubject:@"Appointment Confirmation"];
                                                     [mailController setToRecipients:[NSArray arrayWithObject:@"yzhou088@gmail.com"]];
                                                     [mailController setMessageBody:@"Hi your Appointment has been confirmed." isHTML:NO];
                                                     [self presentViewController:mailController animated:YES completion:nil];
                                                 }

                                                 [self.navigationController popViewControllerAnimated:YES];

                                             }];
                                             UIAlertAction *Message = [UIAlertAction actionWithTitle:@"Send Message" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                 sender.hidden = true;
                                                 
                                                 if ([MFMessageComposeViewController canSendText]) {
                                                     MFMessageComposeViewController *msgController = [[MFMessageComposeViewController alloc]init];
                                                     msgController.messageComposeDelegate = self;
                                                     [msgController setBody:@"Hi your appointment has been confirmed."];
                                                     [msgController setRecipients:[NSArray arrayWithObject:[_dict valueForKey:@"patientNo"]]];
                                                     [self presentViewController:msgController animated:YES completion:nil];
                                                     
                                                 }
                                                 
                                                 [self.navigationController popViewControllerAnimated:YES];
                                                 
                                             }];
                                             [confirmation addAction:OK];
                                             [confirmation addAction:Message];
                                             [self presentViewController:confirmation animated:YES completion:nil];
                                            
                                         }
                                     }];
                                 }];
    
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    NSLog(@"%u",result);
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error{
    if (error) {
        NSLog(@"%@",[error description]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
