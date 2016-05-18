//
//  cTimeTableViewController.h
//  project4
//
//  Created by Wenzhi Zhao on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cTimeTableViewController : UITableViewController
@property (strong, nonatomic) NSString *docNumber;
@property (strong,nonatomic) NSArray *ticketArray;
@property (strong,nonatomic) NSString *period;
@property (strong, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSString *patientNo;
@end

