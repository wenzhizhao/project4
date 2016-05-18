//
//  MJDetailViewController.m
//  CalendarSystem
//
//  Created by Matt Memmo on 8/19/15.
//  Copyright (c) 2015 RWS. All rights reserved.
//

#import "mmViewController.h"
#import "ViewController.h"
#import <Parse/Parse.h>
@interface mmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *warningLbl;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation mmViewController
@synthesize popDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    popDate.text=self.dataString;
    NSLog(@"docNo:%@",self.docNo);
    NSLog(@"patientNo:%@",self.patientNo);
    NSLog(@"period:%@",self.period);
    NSLog(@"appoint%@",self.dataString);
}
- (IBAction)submitBtn:(id)sender {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Congratulation" message:@"You have made an appointment, you don't have to die" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.warningLbl.text = @"You have made an appointment, you don't have to die";
        [self.submitButton setHidden:YES];
        PFObject *ticket = [PFObject objectWithClassName:@"Billboard"];
        [ticket setObject:self.docNo forKey:@"docNo"];
        [ticket setObject:self.patientNo forKey:@"patientNo"];
        [ticket setObject:self.period forKey:@"period"];
        [ticket setObject:self.dataString forKey:@"AppointmentDate"];
        [ticket setObject:[NSNumber numberWithBool:NO] forKey:@"confirmedByDoc"];
        [ticket saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
        }];
    }];
    [vc addAction:act];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
