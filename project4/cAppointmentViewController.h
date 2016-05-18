//
//  cAppointmentViewController.h
//  project4
//
//  Created by Wenzhi Zhao on 5/16/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cAppointmentViewController : UIViewController

- (IBAction)nextAct:(id)sender;
- (IBAction)prevAct:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *monthly;
@property (weak, nonatomic) IBOutlet UILabel *yearly;
@property (strong, nonatomic) NSMutableArray *numArray;
@property (strong, nonatomic) NSString *docNumber;
@property (strong, nonatomic) NSString *availableTime;
@property (strong, nonatomic) NSString *patientNo;
@end

