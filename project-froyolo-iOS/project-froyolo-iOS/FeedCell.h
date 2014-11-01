//
//  FeedTVC.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface FeedCell : UITableViewCell

@property Post *post;

#pragma mark - UI

- (void)updateWithPost:(Post *)newPost;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@property (weak, nonatomic) IBOutlet UIButton *downvoteButton;

#pragma mark - Controls

- (IBAction)upvote:(id)sender;
- (IBAction)downvote:(id)sender;
- (void)viewPhoto:(UITapGestureRecognizer *)sender;

@end
