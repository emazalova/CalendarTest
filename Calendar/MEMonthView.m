//
//  MonthView.m
//  Calendar
//
//  Created by Mazalova Ekaterina on 2/5/15.
//  Copyright (c) 2015 Mazalova Ekaterina. All rights reserved.
//

#import "MEMonthView.h"

@implementation MEMonthView


- (instancetype)initWithFrame:(CGRect)frame monthName:(NSString *)monthName weekDaysNames:(NSArray *)weekDaysNames firstWeekdayIndex:(int)weekdayIndex daysCount:(int)daysCount
{
    if (self = [super initWithFrame:frame]) {
 
        [self fillingMonthWithFirstWeekdayIndex:weekdayIndex weekdaysNames:weekDaysNames monthName:monthName daysCount:daysCount];
    }
    
    return self;
}

- (void)fillingMonthWithFirstWeekdayIndex:(int)firstWeekDayIndex weekdaysNames:(NSArray *)weekDaysNames monthName:(NSString *)monthName daysCount:(int)daysCount
{
    self.monthName = monthName;

    UILabel *monthTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    monthTitle.text = monthName;
    monthTitle.textAlignment = NSTextAlignmentCenter;
    monthTitle.textColor = [UIColor redColor];
    monthTitle.font = [UIFont fontWithName:MONTH_FONT_NAME size:MONTH_FONT_SIZE];
    monthTitle.center = CGPointMake(self.frame.size.width/2, -5);
    [self addSubview:monthTitle];
    
    self.daysOfWeekLabels = [NSMutableArray array];
    
    UIView *prevView = nil;
    
    for (int weekdayNamesIndex = 0; weekdayNamesIndex < weekDaysNames.count; weekdayNamesIndex ++) {
        UILabel *weekdayName = [[UILabel alloc] initWithFrame:CGRectMake(DAYS_STEP_X * weekdayNamesIndex,
                                                                         0,
                                                                         DAY_FRAME_SIZE_WIDTH,
                                                                         DAY_FRAME_SIZE_HEIGHT)];
        [weekdayName setFont:[UIFont fontWithName:DAYS_FONT_NAME size:DAYS_FONT_SIZE]];
        [weekdayName setTextAlignment:NSTextAlignmentCenter];
        weekdayName.text = [weekDaysNames objectAtIndex:weekdayNamesIndex];
        [self addSubview:weekdayName];
        prevView = weekdayName;
    }
    
    for (int dayIndex = 0; dayIndex < daysCount; dayIndex ++) {
        
        
        int weekdayIndexFromDay = (dayIndex + (firstWeekDayIndex - 1))%7;
        
        float x = 0;
        float y = 0;
        
        if (!dayIndex)
        {
            x = DAYS_STEP_X * weekdayIndexFromDay;
            y = prevView.frame.origin.y + DAYS_STEP_Y;
        } else if (!weekdayIndexFromDay)
        {
            x = DAYS_STEP_X * weekdayIndexFromDay;
            y = prevView.frame.origin.y + DAYS_STEP_Y;
        } else
        {
            x = DAYS_STEP_X * weekdayIndexFromDay;
            y = prevView.frame.origin.y;
        }
        
        UILabel *weekdayNumber = [[UILabel alloc] initWithFrame:CGRectMake(
                                                            x,
                                                            y,
                                                            DAY_FRAME_SIZE_WIDTH,
                                                            DAY_FRAME_SIZE_HEIGHT)];
        [weekdayNumber setFont:[UIFont fontWithName:DAYS_FONT_NAME size:DAYS_FONT_SIZE]];
        [weekdayNumber setTextAlignment:NSTextAlignmentCenter];
        weekdayNumber.text = [NSString stringWithFormat:@"%i", (dayIndex + 1)];
        [self addSubview:weekdayNumber];
        prevView = weekdayNumber;
        [self.daysOfWeekLabels addObject:weekdayNumber];
    }
    
}

- (void)unselect
{
    for (UILabel *nextLabel in self.daysOfWeekLabels) {
        nextLabel.textColor = [UIColor blackColor];
        nextLabel.font = [UIFont fontWithName:DAYS_FONT_NAME size:DAYS_FONT_SIZE];
        nextLabel.backgroundColor = [UIColor clearColor];
        nextLabel.layer.cornerRadius = 0.0f;
    }
}

- (void)selectDate:(NSDate *)date
{
    UIColor *selectedColor = [UIColor whiteColor];

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
    UILabel *dateLabel = [self.daysOfWeekLabels objectAtIndex:([components day] - 1)];
    dateLabel.font = [UIFont fontWithName:DAYS_FONT_NAME_SELECTED size:DAYS_FONT_SIZE];
    dateLabel.textColor = selectedColor;
    dateLabel.backgroundColor = [UIColor redColor];
    dateLabel.layer.masksToBounds = YES;
    dateLabel.layer.cornerRadius = 5.0f;
    
}


@end
