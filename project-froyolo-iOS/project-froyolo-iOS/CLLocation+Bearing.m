//
//  CLLocation+Bearing.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "CLLocation+Bearing.h"

double DegreesToRadians(double degrees) {return degrees * M_PI / 180;};
double RadiansToDegrees(double radians) {return radians * 180/M_PI;};


@implementation CLLocation (Bearing)

-(double) bearingToLocation:(CLLocation *) destinationLocation {
    
    double lat1 = DegreesToRadians(self.coordinate.latitude);
    double lon1 = DegreesToRadians(self.coordinate.longitude);
    
    double lat2 = DegreesToRadians(destinationLocation.coordinate.latitude);
    double lon2 = DegreesToRadians(destinationLocation.coordinate.longitude);
    
    double dLon = lon2 - lon1;
    
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double radiansBearing = atan2(y, x);
    
    if (radiansBearing < 0) {
        radiansBearing += 2*M_PI;
    }
    
    return RadiansToDegrees(radiansBearing);
}

-(NSString *)compassOrdinalToLocation:(CLLocation *)newEndPoint {
    double bearing = [self bearingToLocation:newEndPoint];
    if (bearing >= 337.5 || bearing < 22.5)
        return @"N";
    else if (bearing < 67.5)
        return @"NE";
    else if (bearing < 102.5)
        return @"E";
    else if (bearing < 147.5)
        return @"SE";
    else if (bearing < 192.5)
        return @"S";
    else if (bearing < 237.5)
        return @"SW";
    else if (bearing < 282.5)
        return @"W";
    else
        return @"NW";
}

@end
