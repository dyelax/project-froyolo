//
//  ImageOverlay.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ImageOverlay : NSObject <MKOverlay>

- (instancetype)initWithImage:(UIImage *)image coord:(CLLocationCoordinate2D)coord bounds:(MKMapRect)bounds;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKMapRect boundingMapRect;

@property UIImage *image;

@end
