//
//  FeedVC.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol FeedDelegate <NSObject>

@required
- (void)cameraShouldOpen;

@end

@interface FeedVC : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) id<FeedDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *posts;


- (IBAction)cameraPressed:(id)sender;

@end
