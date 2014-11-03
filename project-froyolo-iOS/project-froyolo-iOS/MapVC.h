//
//  MapVC.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapDelegate <NSObject>

@required
- (void)cameraShouldOpen;

@end

@interface MapVC : UIViewController <MKMapViewDelegate>

@property NSMutableArray *posts;


@property (weak, nonatomic) id<MapDelegate> delegate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)cameraPressed:(id)sender;

#pragma mark - Overlay

- (void)updatePosts:(NSMutableArray *)posts;
- (void)loadPostsInRadius:(double)r aroundCoord:(CLLocationCoordinate2D)coord;

- (void)addOverlayWithImage:(UIImage *)image atCoord:(CLLocationCoordinate2D)coord bounds:(MKMapRect)bounds;

@end
