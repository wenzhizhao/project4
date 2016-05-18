//
//  cAppointmentViewController.m
//  project4
//
//  Created by Wenzhi Zhao on 5/16/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "cAppointmentViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"
#import "cTimeTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface cAppointmentViewController ()
@property (strong, nonatomic) NSArray *ticketArray;
@property (strong, nonatomic) NSString *period;
@end


NSUInteger numDays;//1-31
int thisYear;//2015
int weekday;//1-7
int thisMonth;//1-12
int thisDay;
int todayYear;
int todayMonth;
int todayDay;
NSArray * createdAt;
NSArray * parseSpot3;
NSArray * hadSession;


//NSDate * parseSpot;

@implementation cAppointmentViewController
@synthesize monthly,yearly;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"array:%@",self.numArray);
//    [self grabData];
    [self myCalView];//don't need if you're using parse. You will call from grabData method
}

//Next and previous buttons
//they each call the removeTags method which removes the buttons from the view
//the buttons are added again in the updateCallNow method

- (IBAction)nextAct:(id)sender {
    thisMonth++;
    [self removeTags];
    [self updateCalNow];
}

- (IBAction)prevAct:(id)sender {
    thisMonth--;
    [self removeTags];
    [self updateCalNow];
    
}


-(void) removeTags{
    int x=1;
    while (x<=31){
        [[self.view viewWithTag:x] removeFromSuperview];
        x++;
    }
    
}

/*
 this method returns the number of days in the month in the date it is sent
 */

-(NSUInteger)getCurrDateInfo:(NSDate *)myDate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = rng.length;
    
    return numberOfDaysInMonth;
}


/*
 This is the method called to create the calendar
 */

-(void)myCalView{
    
    ///numDays=[self getCurrDateInfo:[NSDate date]];
    
    thisYear = (int)[[[NSCalendar currentCalendar]
                 components:NSCalendarUnitYear fromDate:[NSDate date]]
                year];
    NSLog(@"%d",thisYear);
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps2 = [cal components:NSCalendarUnitMonth fromDate:[NSDate date]];
    thisMonth=(int)[comps2 month];
    todayYear = thisYear;
    todayMonth = thisMonth;
    NSDateComponents *comps3 = [cal components:NSCalendarUnitDay fromDate:[NSDate date]];
    thisDay = (int)[comps3 day];
    todayDay = thisDay;
    NSLog(@"today is %d",thisDay);
    [self moreDateInfo];
    
}



-(void)updateCalNow{// try to condense this so only one method is used instead of two
    if(thisMonth>12){
        thisMonth=1;
        thisYear++;
    }
    
    if(thisMonth<1){
        thisMonth=12;
        thisYear--;
    }
    [self moreDateInfo];
    
}
-(void)moreDateInfo{
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //get first day of month's weekday
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
    weekday=(int)[comps weekday];
    
    
    //Get number of days in the month
    numDays=[self getCurrDateInfo:newDate];
    
    
    int newWeekDay=weekday-1;//make weekday zero based
    
    NSLog(@"Day week %d",newWeekDay);
    
    //coordinates for displaying the buttons
    int yVal=175;
    int yCount=1;
    
    //Display name of month++++++++++++++++++++++++++++++++++++++++++++
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)]);
    monthly.text=[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)];
    yearly.text = [NSString stringWithFormat:@"%d",thisYear];
    
    //use for loop to display each day
    
    for(int startD=1; startD<=numDays;startD++){
        UIButton *addProject = [UIButton buttonWithType: UIButtonTypeCustom];
        
        int xCoord=(newWeekDay*40)+15;
        int yCoord=(yCount*30)+yVal;
        
        newWeekDay++;
        if(newWeekDay>6){//drops buttons on y axis every 7 days
            newWeekDay=0;

            yCount++;
        }
        BOOL enable = NO;

        
        for (int i=0; i<_numArray.count; i++) {
            if (newWeekDay == [_numArray[i] intValue]+1) {
                enable = YES;
            }
        }
        if (todayYear>thisYear) {
            enable = NO;
        }
        if (todayYear == thisYear && todayMonth>thisMonth){
            enable = NO;
        }
        if (todayYear == thisYear && todayMonth == thisMonth && todayDay>startD) {
            enable = NO;
        }
        //Creates the buttons and gives them each a tag (id)
        
//        int popInt=startD;
        addProject.frame = CGRectMake(xCoord, yCoord, 35, 25);
        [addProject setTitle:[NSString stringWithFormat:@"%d", startD] forState:UIControlStateNormal];
        [addProject addTarget:self action:@selector(popupInfo:) forControlEvents:UIControlEventTouchUpInside];
        if (enable) {
            [addProject setEnabled:YES];
            addProject.backgroundColor = [UIColor blueColor];
            [addProject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else{
            [addProject setEnabled:NO];
            addProject.backgroundColor = [UIColor grayColor];
            [addProject setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }
        addProject.tag = startD;
        [self.view addSubview:addProject];
    }
}



/*
 Method that is called from the day button
 the ID of the button is recorded and it's current value can
 be used with thisMonth and thisYear to get the date cooresponding to the button clicked
 This date is saved to the parseSpot3 variable which can be accessed from the popup View
 This way we can use the date to grab further information if we need to
 */


-(void) popupInfo: (id) sender {
    UIButton *btn = (UIButton *) sender;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[btn.currentTitle integerValue]];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
    //Formats date to YYYY-MM-DD
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    //    parseSpot3=@[@"p",[dateFormat stringFromDate:newDate]];
    //compare above date to parse database. See if current user has an entry
    
    //   ----- Launch a  POPUP SCREEN -----------
    
    PFQuery *docQuery = [PFQuery queryWithClassName:@"Billboard"];
    [docQuery whereKey:@"docNo" equalTo:self.docNumber];
    NSString *datastr = [dateFormat stringFromDate:newDate];
    [docQuery whereKey:@"AppointmentDate" equalTo:datastr];
    [docQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.ticketArray = [objects mutableCopy];
            cTimeTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cTimeTableViewController"];
            vc.ticketArray = [self.ticketArray mutableCopy];
            vc.docNumber = [self.docNumber mutableCopy];
            vc.period = [self.availableTime mutableCopy];
            vc.dateStr = [dateFormat stringFromDate:newDate];
            vc.patientNo = [self.patientNo mutableCopy];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:YES];
            });
            
            
        }
    }];
    
    
    //
    //    MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
    //    detailViewController.dataString = [dateFormat stringFromDate:newDate];
    //    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
    
}






@end
