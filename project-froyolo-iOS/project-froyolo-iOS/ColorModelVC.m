//
//  ColorModelVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "ColorModelVC.h"
#import "RedViewController.h"
#import "BlueViewController.h"
#import "GreenViewController.h"

@implementation ColorModelVC{
    UIStoryboard *storyboard;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NSLog(@"storyboard: %@", storyboard);
        
        RedViewController *redVC = [storyboard instantiateViewControllerWithIdentifier:@"red"];
        BlueViewController *blueVC = [storyboard instantiateViewControllerWithIdentifier:@"blue"];
        GreenViewController *greenVC = [storyboard instantiateViewControllerWithIdentifier:@"green"];
        
        self.vcs = @[redVC, blueVC, greenVC];
    }
    return self;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.vcs indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return (UIViewController *)self.vcs[index];
//    switch (index) {
//        case 0:
//            return ;
//            break;
//        case 1:
//            return [storyboard instantiateViewControllerWithIdentifier:@"blue"];
//            break;
//        case 2:
//            return [storyboard instantiateViewControllerWithIdentifier:@"green"];
//            break;
//        default:
//            NSLog(@"ERROR: index = %lu", (unsigned long)index);
//            return nil;
//            break;
//    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.vcs indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index >= self.vcs.count) {
        return nil;
    }
    
    return (UIViewController *)self.vcs[index];
    
//    switch (index) {
//        case 0:
//            return [storyboard instantiateViewControllerWithIdentifier:@"red"];
//            break;
//        case 1:
//            return [storyboard instantiateViewControllerWithIdentifier:@"blue"];
//            break;
//        case 2:
//            return [storyboard instantiateViewControllerWithIdentifier:@"green"];
//            break;
//        default:
//            NSLog(@"ERROR: index = %lu", (unsigned long)index);
//            return nil;
//            break;
//    }
}

@end
