//
//  RootViewController.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "RootViewController.h"
#import "ExampleModelController.h"
#import "ModelController.h"
#import "LocationService.h"

@implementation RootViewController{
    ModelController *modelController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    modelController = [[ModelController alloc]init];
    
    UIViewController *startingViewController = modelController.viewControllers[1];
    [self.pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = modelController;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    self.pageViewController.view.frame = self.view.bounds;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the root view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
//    for (UIGestureRecognizer *gr in self.view.gestureRecognizers){
//        [gr setDelegate:self];
//    }
    
    [(FeedVC *)((UINavigationController *)modelController.viewControllers[0]).viewControllers[0] setDelegate:self];
    
    [[LocationService sharedInstance] startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    NSLog(@"gr");
//    return YES;
//}

#pragma mark - Camera

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
//    cameraUI.mediaTypes = @[kUTTypeImage];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController: cameraUI animated: YES completion:nil];
    
    return YES;
}


// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
//        // Save the new image (original or edited) to the Camera Roll
//        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        
        //send to server
        //post to feed
        //YAY MESSAGE!!!!
    }
    
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - FeedDelegate

- (void)cameraShouldOpen{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

@end
