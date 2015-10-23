//
//  MonthView.h
//  Calendar
//
//  Created by Mazalova Ekaterina on 2/5/15.
//  Copyright (c) 2015 Mazalova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEMonthView : UIView

- (instancetype)initWithFrame:(CGRect)frame monthName:(NSString *)monthName weekDaysNames:(NSArray *)weekDaysNames firstWeekdayIndex:(int)weekdayIndex daysCount:(int)daysCount;

- (void)unselect;
- (void)selectDate:(NSDate *)date;

@property (strong) NSString *monthName;
@property (strong) NSMutableArray *daysOfWeekLabels;

@end
