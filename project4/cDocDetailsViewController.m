//
//  cDocDetailsViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cDocDetailsViewController.h"
#import "cAppointmentViewController.h"
#import <Parse.h>
@interface cDocDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *specializationLbl;
@property (weak, nonatomic) IBOutlet UILabel *worktimeLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptField;
- (IBAction)appointmentBtn:(id)sender;

@property (strong, nonatomic) NSArray *workArray;
@property (strong, nonatomic) NSMutableArray *numArray;
@property (strong, nonatomic) NSString *docNumber;
@property (strong, nonatomic) NSString *availableTime;
@end

@implementation cDocDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numArray = [[NSMutableArray alloc]init];
    self.docNumber = [[NSString alloc]init];
    self.availableTime = [[NSString alloc]init];
    NSLog(@"%@",self.passedString);
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getdocDetails];
}
-(void)getdocDetails{
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Docotors"];
    [pwdQuery whereKey:@"Mobile" equalTo:self.passedString];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *obj = [objects lastObject];
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.nameLbl.text = [obj valueForKey:@"LastName"];
                self.specializationLbl.text = [obj valueForKey:@"Specialization"];
                self.descriptField.text = [obj valueForKey:@"Description"];
                self.workArray =[obj valueForKey:@"WeekDay"];
                self.worktimeLbl.text = [self workdayencoder:self.workArray];
                self.docNumber = [obj valueForKey:@"Mobile"];
                self.availableTime = [obj valueForKey:@"AvailableTime"];
            });
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^{
                UIImage *img = [UIImage imageWithData:[[obj valueForKey:@"Image"] getData]];
                if (img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.image.image = img;
                    });
                }
            });
        }
    }];

}
-(NSString*)workdayencoder:(NSArray*) array{
    NSMutableString *result = [[NSMutableString alloc]initWithFormat:@""];
    for (int i=0; i<_workArray.count; i++) {
        if ([_workArray[i] isEqualToString:@"1"]) {
            result= [NSMutableString stringWithString:@"Mon "];
            [_numArray addObject:[NSNumber numberWithInt:1]];
//            [result stringByAppendingString:@"Mon "];
        }
        else if ([_workArray[i] isEqualToString:@"2"]){
            [result appendString:@"Tue "];
            [_numArray addObject:[NSNumber numberWithInt:2]];


        }
        else if ([_workArray[i] isEqualToString:@"3"]){
            [result appendString:@"Wed "];
            [_numArray addObject:[NSNumber numberWithInt:3]];

            
        }
        else if ([_workArray[i] isEqualToString:@"4"]){
            [result appendString:@"Thu "];
            [_numArray addObject:[NSNumber numberWithInt:4]];

            
        }
        else if ([_workArray[i] isEqualToString:@"5"]){
            [result appendString:@"Fri "];
            [_numArray addObject:[NSNumber numberWithInt:5]];

            
        }
        else if ([_workArray[i] isEqualToString:@"6"]){
            [result appendString:@"Sat "];
            [_numArray addObject:[NSNumber numberWithInt:6]];

            
        }
        else if ([_workArray[i] isEqualToString:@"7"]){
            [result appendString:@"Sun "];
            [_numArray addObject:[NSNumber numberWithInt:7]];

            
        }
    }
    return result;
}

- (IBAction)appointmentBtn:(id)sender {
    //push to appointment vc
    cAppointmentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cAppointmentViewController"];
//    vc.numArray = [_numArray mutableCopy];
    vc.numArray = [NSMutableArray arrayWithArray:_numArray];
    vc.docNumber = [self.docNumber mutableCopy];
    vc.availableTime = [self.availableTime mutableCopy];
    vc.patientNo = [self.patientNo mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
