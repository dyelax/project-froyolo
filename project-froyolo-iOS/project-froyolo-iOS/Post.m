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
        self.image = [UIImage imageNamed:@"test-photo"];
        
    }
    return self;
}

- (NSData *)getJSONData{
    NSDictionary *dict = @{@"post" : @{@"xcoord" : @(self.location.coordinate.longitude),
                                       @"ycoord" : @(self.location.coordinate.latitude),
                                       @"imagedata" : [self encodeToBase64String:self.image]}};
    
                                       
    
    NSError *error = nil;
    NSData *json;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonString);
        }
    }
    return json;
}


- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
@end
