//
//  cDocDetailsViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cDocDetailsViewController.h"

@interface cDocDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *specializationLbl;
@property (weak, nonatomic) IBOutlet UILabel *worktimeLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptField;
- (IBAction)appointmentBtn:(id)sender;
@end

@implementation cDocDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)appointmentBtn:(id)sender {
    //push to appointment vc
}
@end
