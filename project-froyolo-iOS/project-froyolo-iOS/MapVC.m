//
//  MapVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "MapVC.h"
#import "LocationService.h"
#import "ImageOverlay.h"
#import "ImageOverlayRenderer.h"
#import "Post.h"
#import "ServerCommunicator.h"

@interface MapVC ()

@end

@implementation MapVC{
//    ServerCommunicator *sc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    sc = [[ServerCommunicator alloc]init];
    
//    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIView *leftBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, self.view.bounds.size.height)];
    [self.view addSubview:leftBar];
    
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowsPointsOfInterest:YES];
    [self.mapView setDelegate:self];
    
    //TEST
//    MKMapPoint topLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(41.258507, -72.98538));
//    MKMapPoint topRight = MKMapPointForCoordinate(CLLocationCoordinate2DMake(41.258507, -72.98518));
//    MKMapPoint bottomLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(41.258707, -72.98538));
    
    [self addOverlayWithImage:[UIImage imageNamed:@"test-photo"] atCoord:CLLocationCoordinate2DMake(41.258507, -72.986) bounds:[self getBoundsRectForCoord:CLLocationCoordinate2DMake(41.258507, -72.986) importance:1]];
    [self addOverlayWithImage:[UIImage imageNamed:@"bad-test-photo"] atCoord:CLLocationCoordinate2DMake(41.258507, -72.98538) bounds:[self getBoundsRectForCoord:CLLocationCoordinate2DMake(41.258507, -72.98538) importance:0.5]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    double radius = self.mapView.region.span.latitudeDelta + 0.05;
//    [self loadPostsInRadius:radius aroundCoord:self.mapView.centerCoordinate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayingView" object:nil userInfo:@{@"VC" : self}];
    
    [self addOverlayWithImage:[UIImage imageNamed:@"test-photo"] atCoord:CLLocationCoordinate2DMake(41.258507, -72.986) bounds:[self getBoundsRectForCoord:CLLocationCoordinate2DMake(41.258507, -72.986) importance:1]];
    [self addOverlayWithImage:[UIImage imageNamed:@"bad-test-photo"] atCoord:CLLocationCoordinate2DMake(41.258507, -72.98538) bounds:[self getBoundsRectForCoord:CLLocationCoordinate2DMake(41.258507, -72.98538) importance:0.5]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cameraPressed:(id)sender {
    [self.delegate cameraShouldOpen];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    [mapView setRegion:
     MKCoordinateRegionMake([LocationService sharedInstance].currentLocation.coordinate, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
}

#pragma mark - Overlay

- (void)updatePosts:(NSMutableArray *)posts{
    self.posts = posts;
    
    [self.mapView removeOverlays:self.mapView.overlays];
    for (Post *post in self.posts){
        [self addOverlayWithImage:post.image atCoord:post.location.coordinate bounds:[self getBoundsRectForCoord:post.location.coordinate importance:post.importance]];
    }
}

//from server
- (void)loadPostsInRadius:(double)r aroundCoord:(CLLocationCoordinate2D)coord{
//    double xMin = coord.longitude - r;
//    double xMax = coord.longitude + r;
//    double yMin = coord.latitude - r;
//    double yMax = coord.latitude + r;
    
    struct CoordBounds cb;
    cb.minLat = coord.latitude - r;
    cb.maxLat = coord.latitude + r;;
    cb.minLon = coord.longitude - r;
    cb.maxLon = coord.longitude + r;
    [[ServerCommunicator sharedInstance] retrievePostsInBounds:cb];
}

- (MKMapRect)getBoundsRectForCoord:(CLLocationCoordinate2D)coord importance:(double)importance{
    double dLat = 0.001 + importance * 0.01;
    double dLon = 0.001 + importance * 0.01;
    
    MKMapPoint topLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(coord.latitude - (dLat/2), coord.longitude - (dLon/2)));
    MKMapPoint topRight = MKMapPointForCoordinate(CLLocationCoordinate2DMake(coord.latitude - (dLat/2), coord.longitude + (dLon/2)));
    MKMapPoint bottomLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(coord.latitude + (dLat/2), coord.longitude - (dLon/2)));
    
    return MKMapRectMake(topLeft.x, topLeft.y, fabs(topLeft.x - topRight.x), fabs(topLeft.y - bottomLeft.y));
}

- (void)addOverlayWithImage:(UIImage *)image atCoord:(CLLocationCoordinate2D)coord bounds:(MKMapRect)bounds {
    
    ImageOverlay *overlay = [[ImageOverlay alloc] initWithImage:image coord:coord bounds:bounds];
    [self.mapView addOverlay:overlay];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:ImageOverlay.class]) {
        UIImage *image = ((ImageOverlay *)overlay).image;
        ImageOverlayRenderer *renderer = [[ImageOverlayRenderer alloc] initWithOverlay:overlay overlayImage:image];
        
        NSLog(@"renderer");
        return renderer;
    }
    return nil;
}

//- (void)loadSelectedOptions {
//    [self.mapView removeAnnotations:self.mapView.annotations];
//    [self.mapView removeOverlays:self.mapView.overlays];
////    for (NSNumber *option in self.selectedOptions) {
////        switch ([option integerValue]) {
////            case PVMapOverlay:
////                [self addOverlay];
////                break;
////            default:
////                break;
////        }
////    }
//}

@end
