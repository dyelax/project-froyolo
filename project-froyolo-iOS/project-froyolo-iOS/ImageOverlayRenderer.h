//
//  ImageOverlayRenderer.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ImageOverlayRenderer : MKOverlayRenderer

@property (nonatomic) UIImage *overlayImage;

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage;

@end
