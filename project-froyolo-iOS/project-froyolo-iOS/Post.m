//
//  Post.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "Post.h"

@implementation Post

- (id)init
{
    self = [super init];
    if (self) {
        self.timeStamp = [NSDate date];
        self.location = [[CLLocation alloc]initWithLatitude:40.7127 longitude:-74.0059];
        self.score = 333;
        //self.image = [UIImage imageNamed:@"test-photo"];
        self.image = [UIImage imageNamed:@"vertical-test-photo"];
        
    }
    return self;
}

@end
