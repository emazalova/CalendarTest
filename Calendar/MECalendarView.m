//
//  CalendarView.m
//  Calendar
//
//  Created by Mazalova Ekaterina on 2/5/15.
//  Copyright (c) 2015 Mazalova Ekaterina. All rights reserved.
//

#import "MECalendarView.h"
#import "MEMonthView.h"

#define MONTH_COUNT 12

@interface MECalendarView ()
{
   __strong NSMutableArray *_viewsOfMonths;
    
}
@property (strong) UILabel *yearTitle;

@end

@implementation MECalendarView

- (void)dealloc
{
    _viewsOfMonths = nil;
}


- (void)setViewsOfMonths:(NSMutableArray *)viewsOfMonths
{
    _viewsOfMonths = viewsOfMonths;
    
    for (UIView *nextView in self.subviews) {
        if ([nextView isKindOfClass:[MEMonthView class]]) {
            [nextView removeFromSuperview];
        }
    }
    
    for (MEMonthView *nextMonthView in _viewsOfMonths) {
        [self addSubview:nextMonthView];
    }
    
    if (!self.yearTitle) {
        self.yearTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_yearTitle setFont:[UIFont fontWithName:YEAR_FONT_NAME size:YEAR_FONT_SIZE]];
        _yearTitle.textColor = [UIColor redColor];
        _yearTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_yearTitle];
    }
    
    [self setNeedsLayout];
}

- (void)selectDate:(NSDate *)date
{
    for (MEMonthView *nextMonthView in _viewsOfMonths)
    {
        [nextMonthView unselect];
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    MEMonthView *monthToSelectDay = [_viewsOfMonths objectAtIndex:(components.month - 1)];
    [monthToSelectDay selectDate:date];
    
}

- (void)setYear:(int)year
{
    _yearTitle.text = [NSString stringWithFormat:@"%i", year];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGPoint stepShift = CGPointZero;
    int horizontalCount = 1;
    
    CGSize screenSize = self.frame.size;
    float width, height;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = MIN(screenSize.width, screenSize.height);
        height = MAX(screenSize.width, screenSize.height);
        stepShift.x = width /(MONTH_COUNT_PORTRAIT_ORIENTATION + 1);
        stepShift.y = height /((MONTH_COUNT/MONTH_COUNT_PORTRAIT_ORIENTATION + 1));
        horizontalCount = MONTH_COUNT_PORTRAIT_ORIENTATION;
        
        
        _yearTitle.center = CGPointMake(width - 50, 40);
        
        NSLog(@"Portrait");

        
    } else
    {
        width = MAX(screenSize.width, screenSize.height);
        height = MIN(screenSize.width, screenSize.height);
        stepShift.x = width /(MONTH_COUNT_LANDSCAPE_ORIENTATION + 1);
        stepShift.y = height /((MONTH_COUNT/MONTH_COUNT_LANDSCAPE_ORIENTATION + 1));
        horizontalCount = MONTH_COUNT_LANDSCAPE_ORIENTATION;
        
        _yearTitle.center = CGPointMake(width - 100, 20);
        
        NSLog(@"Lanscape");
    }
    
    UIView *prevView = nil;
    
    for (int monthViewIndex = 0; monthViewIndex < _viewsOfMonths.count; monthViewIndex ++)
    {
        MEMonthView *nextMonthView = [_viewsOfMonths objectAtIndex:monthViewIndex];
        if (monthViewIndex == 0) {
            
            nextMonthView.center = CGPointMake(stepShift.x,
                                               stepShift.y);
        }
        else if ((monthViewIndex%horizontalCount) == 0) {
            nextMonthView.center = CGPointMake(stepShift.x,
                                               (prevView.center.y + stepShift.y));
            
            nextMonthView.center = CGPointMake(nextMonthView.center.x,
                                               (prevView.center.y + stepShift.y));
        } else
        {
            nextMonthView.center = CGPointMake((prevView.center.x + stepShift.x),
                                               prevView.center.y);
        }
        
        prevView = nextMonthView;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
