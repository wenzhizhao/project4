//
//  MyCalendarViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//
#import "CustomCollectionViewCell.h"
#import "MyCalendarViewController.h"
#import "MonthCollectionHeaderView.h"
@interface MyCalendarViewController (){
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyCalendarViewController
#pragma Mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(int)MonthDaysCaculator:(NSInteger)Section{
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *c = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:(int)Section];
    NSDate *MonthFromNow = [c dateByAddingComponents:components
                                                 toDate:today
                                                options:0];
    
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:MonthFromNow];
    return (int)days.length;
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
//    return [self MonthDaysCaculator:section];
    return 42;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
        NSDate *now = [NSDate date];
        NSCalendar * calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setMonth:(int)indexPath.section];
        NSDate *MonthFromNow = [calendar dateByAddingComponents:components
                                                  toDate:now
                                                 options:0];
    
        NSDateComponents * currentDateComponents = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth fromDate: MonthFromNow];
        
        NSDate * startOfMonth = [calendar dateFromComponents: currentDateComponents];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE"];
        NSString *prettyDate = [formatter stringFromDate:startOfMonth];
        
        int offset = 0;
        if ([prettyDate isEqualToString:@"Monday"]) {
            offset = 1;
        }else if([prettyDate isEqualToString:@"Tuesday"]){
            offset = 2;
            
        }else if([prettyDate isEqualToString:@"Wednesday"]){
            offset = 3;
            
        }else if([prettyDate isEqualToString:@"Thursday"]){
            offset = 4;
            
        }else if([prettyDate isEqualToString:@"Friday"]){
            offset = 5;
            
        }else if([prettyDate isEqualToString:@"Saturday"]){
            offset = 6;
            
        }else if([prettyDate isEqualToString:@"Sunday"]){
            offset = 0;
            
        }
        
        if ([self MonthDaysCaculator:indexPath.section]+offset>indexPath.row) {
            
            if (indexPath.row >= offset) {
                [cell.BtnOutlet setTitle:[NSString stringWithFormat:@"%d",indexPath.row+1-offset] forState:UIControlStateNormal];
            }else{
                [cell.BtnOutlet setTitle:@"" forState:UIControlStateNormal];
            }
        }else{
            [cell.BtnOutlet setTitle:@"" forState:UIControlStateNormal];
        }
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSDate *now = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:(int)indexPath.section];
    NSDate *MonthFromNow = [calendar dateByAddingComponents:components
                                                     toDate:now
                                                    options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *pretty = [formatter stringFromDate:MonthFromNow];
    NSString *prettyDate = [pretty substringToIndex:3];

    
    
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        MonthCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = prettyDate;
        headerView.monthLabel.text = title;
        reusableview = headerView;
    }
    return reusableview;
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
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);//top, left, bottom, right;
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
