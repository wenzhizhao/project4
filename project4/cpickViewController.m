//
//  cpickViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cpickViewController.h"
#import "clistViewController.h"

@interface cpickViewController ()


- (IBAction)button_tapped:(UIButton *)sender;

@end

@implementation cpickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
}


- (IBAction)button_tapped:(UIButton *)sender {
    clistViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"clistViewController"];
    
    switch (sender.tag) {
        case 101:
            [vc setGotString:@"CARDIOLOGISTS"];
            break;
        case 102:
            [vc setGotString:@"DENTISTS"];
            break;
        
        case 103:
            [vc setGotString:@"DERMATOLOGISTS"];
            break;
        case 104:
            [vc setGotString:@"GYNAECOLOGISTS"];
            break;
        case 105:
            [vc setGotString:@"OPHTHALMOLOGISTS"];
            break;
            
        case 106:
            [vc setGotString:@"PSYCHOLOGISTS"];
            break;
            
        default:
            break;
    }
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];

}
@end
