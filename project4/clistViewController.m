//
//  clistViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/15/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "clistViewController.h"
#import "ClistTableViewCell.h"

#import "cDocDetailsViewController.h"

@interface clistViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@end

@implementation clistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_Clist"];
    
    cell.label1.text = @"NO1";
    cell.label2.text = @"NO2";
//    cell.imgView.image = [UIImage imageNamed:@""];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cDocDetailsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@""];
//    vc.passedString = [NSString stringWithFormat:@"%d",indexPath.row];
    vc.passedString = self.gotString;
    NSLog(@"%@",vc.passedString);
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
