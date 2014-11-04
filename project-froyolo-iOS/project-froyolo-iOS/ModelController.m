//
//  ModelController.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "ModelController.h"
#import "FeedVC.h"
#import "MapVC.h"

@implementation ModelController{
    UIStoryboard *mainStoryboard;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController *feedNC = [mainStoryboard instantiateViewControllerWithIdentifier:@"feedNC"];
        MapVC *mapVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"map"];
        
        self.viewControllers = @[feedNC, mapVC];
    }
    return self;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
//    self.displayingVC = viewController;
//    if ([self.displayingVC isKindOfClass:UINavigationController.class]) {
//        FeedVC *feedVC = (FeedVC *)((UINavigationController *)self.displayingVC).topViewController;
//        [feedVC loadData];
//    }else if ([self.displayingVC isKindOfClass:MapVC.class]){
//        MapVC *mapVC = (MapVC *)self.displayingVC;
//        double radius = mapVC.mapView.region.span.latitudeDelta + 0.05;
//        [mapVC loadPostsInRadius:radius aroundCoord:mapVC.mapView.centerCoordinate];
//    }
    
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
//    self.displayingVC = viewController;
    
    index--;
    
    return (UIViewController *)self.viewControllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index >= self.viewControllers.count) {
        return nil;
    }
    
    return (UIViewController *)self.viewControllers[index];
}

@end
