//
//  ServerCommunicator.h
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@class ServerCommunicator;

@protocol ServerCommunicatorDelegate <NSObject>

@required
//- (void)postDidCompleteSuccessfully;
- (void)receivalDidCompleteSuccussfully:(NSArray *)posts;
- (void)shouldLoadPosts;

@end

struct CoordBounds {
    double minLon;
    double maxLon;
    double minLat;
    double maxLat;
};

@interface ServerCommunicator : NSObject <NSURLConnectionDataDelegate>

+(ServerCommunicator *) sharedInstance;

@property (weak, nonatomic) id<ServerCommunicatorDelegate> delegate;

- (void)addPost:(Post *)post;
- (void)incrementPost:(Post *)post;
- (void)decrementPost:(Post *)post;
- (void)retrievePostsInBounds:(struct CoordBounds)bounds;

@end
