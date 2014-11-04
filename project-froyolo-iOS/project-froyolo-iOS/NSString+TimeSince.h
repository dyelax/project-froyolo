//
//  NSString+TimeSince.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeSince)

+ (NSString *)dynamicTimeIntervalStringToNowFromDate:(NSDate *)date;

@end
