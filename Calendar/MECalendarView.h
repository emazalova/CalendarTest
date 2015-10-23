//
//  CalendarView.h
//  Calendar
//
//  Created by Mazalova Ekaterina on 2/5/15.
//  Copyright (c) 2015 Mazalova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MECalendarView : UIView

- (void)setViewsOfMonths:(NSMutableArray *)viewsOfMonths;
- (void)selectDate:(NSDate *)date;
- (void)setYear:(int)year;


@end
