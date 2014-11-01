//
//  RootViewController.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "FeedVC.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FeedDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

