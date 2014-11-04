//
//  ServerCommonicator.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "ServerCommunicator.h"

@implementation ServerCommunicator{
    NSMutableData *receivedData;
    
//    BOOL isSendingPost;
}

+(ServerCommunicator *) sharedInstance
{
    static ServerCommunicator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
//        isRetrievingPosts = NO;
//
        
    }
    return self;
}

- (void)addPost:(Post *)post{
    NSURL *url = [NSURL URLWithString:@"http://cannonball-131633.use1-2.nitrousbox.com/posts"];
    
//    receivedData = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    NSData *jsonData = [post getJSONData];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
//    if (connection) {
//        NSMutableData *receivedData = [NSMutableData data];
//        NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"receivedData: %@", receivedDataString);
//    }
}

- (void)incrementPost:(Post *)post{
    NSURL *url = [NSURL URLWithString:@"http://cannonball-131633.use1-2.nitrousbox.com/increment.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    NSDictionary *dict = @{@"post_id" : post.ID};
    
    NSError *error = nil;
    NSData *jsonData;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (jsonData != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonString);
        }
    }
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}
- (void)decrementPost:(Post *)post{
    NSURL *url = [NSURL URLWithString:@"http://cannonball-131633.use1-2.nitrousbox.com/decrement.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    NSDictionary *dict = @{@"post_id" : post.ID};
    
    NSError *error = nil;
    NSData *jsonData;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (jsonData != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonString);
        }
    }
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
- (void)retrievePostsInBounds:(struct CoordBounds)bounds{
//    isRetrievingPosts = YES;
    NSURL *url = [NSURL URLWithString:@"http://cannonball-131633.use1-2.nitrousbox.com/find_importance.json"];
    
    receivedData = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    NSDictionary *dict = @{@"minx" : @(bounds.minLon),
                           @"maxx" : @(bounds.maxLon),
                           @"miny" : @(bounds.minLat),
                           @"maxy" : @(bounds.maxLat)};
    
    NSError *error = nil;
    NSData *jsonData;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (jsonData != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonString);
        }
    }
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
    
//    if (data) {
//        [self.delegate postDidCompleteSuccessfully];
//    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"receivedData: %@", receivedDataString);

    if (receivedData && [self.delegate respondsToSelector:@selector(receivalDidCompleteSuccussfully:)]) {
        
        NSError *er;
        
        NSArray *postDicts = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:&er];
        if (er) {
            NSLog(@"error: %@", er.localizedDescription);
        }
        
        NSMutableArray *posts = [[NSMutableArray alloc]init];
        for (NSDictionary *postDict in postDicts){
            Post *post = [[Post alloc]init];
            
            [post setID:[postDict objectForKey:@"id"]];
            [post setTimeStamp:[NSDate dateWithTimeIntervalSince1970:((NSNumber *)[postDict objectForKey:@"timestamp"]).doubleValue]];
            [post setLocation:[[CLLocation alloc]initWithLatitude:((NSNumber *)[postDict objectForKey:@"ycoord"]).doubleValue longitude:((NSNumber *)[postDict objectForKey:@"xcoord"]).doubleValue]];
            [post setScore:((NSNumber *)[postDict objectForKey:@"score"]).intValue];
            [post setImage:[self decodeBase64ToImage:[postDict objectForKey:@"imagedata"]]];
            [post setImportance:((NSNumber *)[postDict objectForKey:@"importance"]).doubleValue];
            
            [posts addObject:post];
        }
        
        [self.delegate receivalDidCompleteSuccussfully:posts];
        
//        isRetrievingPosts = NO;
    }
}


#pragma mark - Image Encoding

///*
//	Base64 Encoding: UIImage (jpeg) -> string (base64)
// */
//- (NSString *)encodeImage:(UIImage *) image{ //from http://stackoverflow.com/questions/6476929/convert-uiimage-to-nsdata
//    NSData *UIImageJPEGRepresentation (
//                                       UIImage *image,
//                                       CGFloat compressionQuality
//                                       );
//    
//    // Create NSData object
//    //NSData *nsdata = [@"iOS Developer Tips encoded in Base64"
//    //  dataUsingEncoding:NSUTF8StringEncoding];
//    
//    // Get NSString from NSData object in Base64
//    
//    NSString *base64Encoded = [UIImageJPEGRepresentation base64EncodedStringWithOptions:0];
//    
//    // Print the Base64 encoded string
//    NSLog(@"Encoded: %@", base64Encoded);
//}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

///*
//	Base64 Decoding: string (base64) -> UIImage (jpeg)
// 
//	Mostly from http://stackoverflow.com/questions/4655174/iphone-how-to-get-image-back-from-nsdata
// */
//
//// NSData from the Base64 encoded str
//- (UIImage *)decodeImage:(NSString *)str{
//    NSData *nsdataFromBase64String = [[NSData alloc]
//                                      initWithBase64EncodedString:str options:0]; //The data that the photo will occupy
//    
//    UIImage *img = [UIImage imageWithData:nsdataFromBase64String];
//    return img;	
//}

@end
