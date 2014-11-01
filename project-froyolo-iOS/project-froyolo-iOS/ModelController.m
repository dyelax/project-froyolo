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
//        FeedVC *feedVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"feed"];
        MapVC *mapVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"map"];
        
        self.viewControllers = @[feedNC, mapVC];
    }
    return self;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
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
