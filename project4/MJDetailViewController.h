//
//  MJDetailViewController.h
//  CalendarSystem
//
//  Created by Matt Memmo on 8/19/15.
//  Copyright (c) 2015 RWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJDetailViewController : UIViewController




@property (weak, nonatomic) IBOutlet UILabel *popDate;
@property (strong, nonatomic) NSString *dataString;



//@property (weak, nonatomic) IBOutlet UILabel *popDate;
//@property (strong, nonatomic) NSString *dataString;
@property (strong, nonatomic) NSString *patientNo;
@property (strong, nonatomic) NSString *docNo;
@property (strong, nonatomic) NSString *period;

@end
