//
//  cpickViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cPickingViewController.h"
#import "cListingViewController.h"

@interface cPickingViewController ()


- (IBAction)button_tapped:(UIButton *)sender;

@end

@implementation cPickingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
}


- (IBAction)button_tapped:(UIButton *)sender {
    cListingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cListingViewController"];
    
    switch (sender.tag) {
        case 101:
            [vc setGotString:@"Cardiologist"];
            break;
        case 102:
            [vc setGotString:@"Dentist"];
            break;
            
        case 103:
            [vc setGotString:@"Dermatologist"];
            break;
        case 104:
            [vc setGotString:@"Gynecologist"];
            break;
        case 105:
            [vc setGotString:@"Ophthalmologist"];
            break;
            
        case 106:
            [vc setGotString:@"Psychologist"];
            break;
            
        default:
            break;
    }
        [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
