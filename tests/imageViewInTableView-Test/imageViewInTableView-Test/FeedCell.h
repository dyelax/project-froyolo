//
//  FeedTVC.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)upvote:(id)sender;
- (IBAction)downvote:(id)sender;

- (void)viewPhoto:(UITapGestureRecognizer *)sender;

@end
