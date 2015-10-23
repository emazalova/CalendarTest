//
//  CalendarViewController.m
//  Calendar
//
//  Created by Mazalova Ekaterina on 2/5/15.
//  Copyright (c) 2015 Mazalova Ekaterina. All rights reserved.
//

#import "MECalendarViewController.h"
#import "MECalendarView.h"
#import "MEMonthView.h"


@interface MECalendarViewController ()

@property (weak) MECalendarView *calendarView;
@property (strong) NSCalendar *calendar;
@property (strong) NSDateFormatter *dateFormatter;

@end

@implementation MECalendarViewController

- (void)dealloc
{
    self.calendar = nil;
}

- (void)loadView
{
    MECalendarView *tCalendarView = [[MECalendarView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tCalendarView.autoresizesSubviews = YES;
    tCalendarView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    
    _calendarView = tCalendarView;
    self.view = _calendarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [self.calendar setLocale:[NSLocale currentLocale]];
    [self.calendar setFirstWeekday:1];//Sunday is first week day
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [self.dateFormatter setLocale:posix];
    self.dateFormatter.dateFormat = @"d.M.y";
    
    
    [self createMonths];
}


- (void)createMonths
{
    
    NSMutableArray *months = [NSMutableArray array];
    NSArray *weekDaysNames = [self.dateFormatter veryShortWeekdaySymbols];
    NSArray *monthsNames = [self.dateFormatter monthSymbols];
    
    NSDateComponents *comp = [_calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSString *dateString = [NSString stringWithFormat:@"1.1.%i", (int)comp.year];
    NSDate *firstDateInYear = [_dateFormatter dateFromString:dateString];
    
    for (int monthIndex = 1; monthIndex <= 12; monthIndex ++)
    {
        
        NSDate *date1 = [_dateFormatter dateFromString:
                         [NSString stringWithFormat:@"1.%i.%i", monthIndex, (int)comp.year]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setMonth:monthIndex];
        
        NSDate *date2 = [_calendar dateByAddingComponents:components
                                                            toDate:firstDateInYear
                                                           options:0];
        
        NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
        
        int numberOfDays = secondsBetween / 86400;
        
        int adjustedWeekdayOrdinal = (int)[_calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfYear forDate:date1];
        
        MEMonthView *month = [[MEMonthView alloc] initWithFrame:CGRectMake(0, 0, MONTHVIEW_WIDTH, MONTHVIEW_HEIGHT)
                                                  monthName:[monthsNames objectAtIndex:(monthIndex - 1)]
                                              weekDaysNames:weekDaysNames
                                          firstWeekdayIndex:adjustedWeekdayOrdinal
                                                  daysCount:numberOfDays];
        month.layer.cornerRadius = 20.0f;
        
        
        [months addObject:month];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnViewWithGesture:)];
        [month addGestureRecognizer:tapGesture];
    }
    
    [self.calendarView setViewsOfMonths:months];
    [self.calendarView selectDate:[NSDate date]];
    [self.calendarView setYear:(int)comp.year];
    
}



- (void)tapOnViewWithGesture:(UIGestureRecognizer *)gerture
{
    MEMonthView *monthView = (MEMonthView *)gerture.view;
    UIAlertView *monthAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You tapped on:", @"You tapped on:")
                                                        message:monthView.monthName
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                              otherButtonTitles:nil];
    [monthAlert show];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
