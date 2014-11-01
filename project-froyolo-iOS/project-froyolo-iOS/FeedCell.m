//
//  FeedTVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "FeedCell.h"
#import "LocationService.h"
#import "CLLocation+Bearing.h"
#import "NSString+TimeSince.h"

@implementation FeedCell{
    UITapGestureRecognizer *tapGR;
}

- (void)awakeFromNib {
    // Initialization code
    tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewPhoto:)];
    [self.contentView addGestureRecognizer:tapGR];
    
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.photoImageView setClipsToBounds:YES];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


#pragma mark - UI

- (void)updateWithPost:(Post *)newPost{
    self.post = newPost;
    
    CLLocation *currentLocation = [LocationService sharedInstance].currentLocation;
    
    double distance = [self.post.location distanceFromLocation:currentLocation] / 1609.34;
    NSString *heading = [currentLocation compassOrdinalToLocation:self.post.location];
    
    [self.locationLabel setText:[NSString stringWithFormat:@"%.01f %@", distance, heading]];
    [self.timeLabel setText:[NSString dynamicTimeIntervalStringToNowFromDate: self.post.timeStamp]];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", self.post.score]];
    [self.photoImageView setImage:self.post.image];
    
}
- (void)updateVoteUI{
    switch (self.post.currentUserVote) {
        case PostVoteDown:
            [self.downvoteButton setImage:[UIImage imageNamed:@"commentVote-Downvote-Selected-Red"] forState:UIControlStateNormal];
            [self.upvoteButton setImage:[UIImage imageNamed:@"commentVote-Upvote-Unselected"] forState:UIControlStateNormal];
            break;
        case PostVoteNone:
            [self.downvoteButton setImage:[UIImage imageNamed:@"commentVote-Downvote-Unselected"] forState:UIControlStateNormal];
            [self.upvoteButton setImage:[UIImage imageNamed:@"commentVote-Upvote-Unselected"] forState:UIControlStateNormal];
            break;
        case PostVoteUp:
            [self.downvoteButton setImage:[UIImage imageNamed:@"commentVote-Downvote-Unselected"] forState:UIControlStateNormal];
            [self.upvoteButton setImage:[UIImage imageNamed:@"commentVote-Upvote-Selected-Green"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", self.post.score]];
}

#pragma mark - Controls

- (IBAction)upvote:(UIButton *)sender {
    if (self.post.currentUserVote == PostVoteUp) {
        self.post.score--;
        [self.post setCurrentUserVote:PostVoteNone];
    }else{
        self.post.score++;
        if (self.post.currentUserVote == PostVoteDown) {
            self.post.score++;//extra point added because we're getting rid of the downvote too.
        }
        
        [self.post setCurrentUserVote:PostVoteUp];
    }
    [self updateVoteUI];
    
    //??? update server with vote
}
- (IBAction)downvote:(UIButton *)sender {
    if (self.post.currentUserVote == PostVoteDown) {
        [self.post setCurrentUserVote:PostVoteNone];
        self.post.score++;
    }else{
        self.post.score--;
        if (self.post.currentUserVote == PostVoteUp) {
            self.post.score--;//extra point subtracted because we're getting rid of the downvote too.
        }
        
        [self.post setCurrentUserVote:PostVoteDown];
    }
    [self updateVoteUI];
    
    //??? update server with vote
}

- (void)viewPhoto:(UITapGestureRecognizer *)sender{
    NSLog(@"VIEW!");
}

@end
