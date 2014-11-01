//
//  Post.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef enum PostVote : NSInteger{
    PostVoteDown = -1,
    PostVoteNone,
    PostVoteUp
}CommentVote;

@interface Post : NSObject

@property NSDate *timeStamp;
@property CLLocation *location;
@property int score;
@property UIImage *image;

@property CommentVote currentUserVote;

@end
