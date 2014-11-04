//
//  ImageOverlay.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "ImageOverlay.h"

@implementation ImageOverlay

- (instancetype)initWithImage:(UIImage *)image coord:(CLLocationCoordinate2D)coord bounds:(MKMapRect)bounds{
    if (self = [super init]) {
        self.image = image;
        self.coordinate = coord;
        self.boundingMapRect = bounds;
    }
    return self;
}

@end
