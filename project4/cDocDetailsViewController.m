//
//  cDocDetailsViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cDocDetailsViewController.h"
#import <Parse.h>
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


- (IBAction)appointmentBtn:(id)sender {
    //push to appointment vc
}
@end
