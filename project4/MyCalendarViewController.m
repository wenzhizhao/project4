//
//  MyCalendarViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//
#import "CustomCollectionViewCell.h"
#import "MyCalendarViewController.h"
@interface MyCalendarViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyCalendarViewController
#pragma Mark - view did load


- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:units fromDate:now];
    
    NSLog(@"Day: %ld", (long)[components day]);
    NSLog(@"Month: %ld", (long)[components month]);
    NSLog(@"Year: %ld", (long)[components year]);
    
    
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSCalendar *buddhist = [[NSCalendar alloc]
//                            initWithCalendarIdentifier:NSCalendarIdentifierChinese];
//    NSCalendar *preferred = [NSCalendar currentCalendar];
//    NSLog(@"%@", gregorian.calendarIdentifier);
//    NSLog(@"%@", buddhist.calendarIdentifier);
//    NSLog(@"%@", preferred.calendarIdentifier);
    
//    NSDate *now = [NSDate date];
//    NSTimeInterval secondsInWeek = 7 * 24 * 60 * 60;
//    NSDate *lastWeek = [NSDate dateWithTimeInterval:-secondsInWeek
//                                          sinceDate:now];
//    NSDate *nextWeek = [NSDate dateWithTimeInterval:secondsInWeek
//                                          sinceDate:now];
//    NSLog(@"Last Week: %@", lastWeek);
//    NSLog(@"Right Now: %@", now);
//    NSLog(@"Next Week: %@", nextWeek);
    
    
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
//    [components setHour:5];
//    NSDate *today10am = [calendar dateFromComponents:components];
//    NSLog(@"%@",today10am);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Collection View Setting
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.BtnOutlet setTitle:[NSString stringWithFormat:@"%d",indexPath.row+1] forState:UIControlStateNormal];
    cell.lable.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}

- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    
}


#pragma mark - Autolayout Setting
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(collectionView.frame.size.width/7, collectionView.frame.size.width/7);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 0, 0, 0);//top, left, bottom, right;
    return edge;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; // This is the minimum inter item spacing, can be more
}


#pragma Mark - Cancel and Save Action
- (IBAction)cancelBarItem_Pressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneBarItem_Pressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
