//
//  CLLocation+Bearing.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Bearing)
-(double) bearingToLocation:(CLLocation *) destinationLocation;
-(NSString *) compassOrdinalToLocation:(CLLocation *) newEndPoint;

@end
