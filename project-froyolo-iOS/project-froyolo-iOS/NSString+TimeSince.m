//
//  NSString+TimeSince.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "NSString+TimeSince.h"

@implementation NSString (TimeSince)

+ (NSString *)getDateStringInMDY:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateStyle:NSDateFormatterShortStyle];
    NSString *dateString = [df stringFromDate:date];
    
    return dateString;
}
+ (NSString *)dynamicTimeIntervalStringToNowFromDate:(NSDate *)date{
    //use variable for current date so there's no time discrepency between [NSDate date] being used here and later.
    NSDate *nowDate = [NSDate date];
    // Get time interval from date to now.
    NSTimeInterval interval = [nowDate timeIntervalSinceDate:date];
    
    //values in seconds
    int min, hour, day, day2;
    min = 60;
    hour = min*60;
    day = hour*24;
    day2 = day*2;
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Get conversion to hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date  toDate:nowDate  options:0];
    
    if (interval < min) {
        return @"Just now";
    }else if (interval < hour){
        return [NSString stringWithFormat:@"%lim", (long)breakdownInfo.minute];
    }else if (interval < day){
        return [NSString stringWithFormat:@"%lih", (long)breakdownInfo.hour];
    }else if (interval < day2){
        return @"Yesterday";
    }else{
        return [NSString getDateStringInMDY:date];
    }
}

@end
