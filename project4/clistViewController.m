//
//  clistViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "clistViewController.h"
#import "ClistTableViewCell.h"
#import <Parse.h>

#import "cDocDetailsViewController.h"

@interface clistViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) NSArray *docArry;
@end

@implementation clistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.docArry = [[NSArray alloc] init];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getDocList];
}
-(void)getDocList{
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Docotors"];
    [pwdQuery whereKey:@"Specialization" equalTo:self.gotString];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.docArry = [objects mutableCopy];
                [self.tblView reloadData];
            });
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.docArry.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_Clist"];
    PFObject *obj = [self.docArry objectAtIndex:indexPath.row];
    cell.label1.text = [obj valueForKey:@"LastName"];
    cell.label2.text = [obj valueForKey:@"Address"];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        
        UIImage *img = [UIImage imageWithData:[[obj valueForKey:@"Image"] getData]];
        
        if (img) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgView.image = img;
            });
        }
        
    });
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cDocDetailsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cDocDetailsViewController"];
//    vc.passedString = [NSString stringWithFormat:@"%d",indexPath.row];
    PFObject *obj = [self.docArry objectAtIndex:indexPath.row];
    vc.passedString = [obj valueForKey:@"Mobile"];
    NSLog(@"%@",vc.passedString);
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
