//
//  FeedVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "FeedVC.h"
#import "FeedCell.h"
#import "Post.h"
#import "CLLocation+Bearing.h"
#import "NSString+TimeSince.h"
#import "LocationService.h"
#import "ServerCommunicator.h"

@interface FeedVC ()

@end

@implementation FeedVC{
//    ServerCommunicator *sc;
    UIRefreshControl *refreshControl;
}

- (void)awakeFromNib{
//    sc = [[ServerCommunicator alloc]init];
    
    self.posts = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<20; i++) {
        [self.posts addObject: [[Post alloc] init]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.posts = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i<20; i++) {
//        [self.posts addObject: [[Post alloc] init]];
//    }
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl setBackgroundColor:[UIColor whiteColor]];
    [refreshControl setTintColor:[UIColor colorWithRed:93.0/255 green:36.0/255 blue:249.0/255 alpha:1]];
    
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"Feed Appear");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayingView" object:nil userInfo:@{@"VC" : self}];
                                                                                                       
//    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Server

- (void)loadData{
    struct CoordBounds cb;
    cb.minLat = -100;
    cb.maxLat = 100;
    cb.minLon = -100;
    cb.maxLon = 100;
    [[ServerCommunicator sharedInstance] retrievePostsInBounds:cb];
}

- (void)updatePosts:(NSArray *)posts{
    [self setPosts:[NSMutableArray arrayWithArray:posts]];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}


#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell setSeparatorInset:UIEdgeInsetsMake(100, 1000, 100, 1000)];//should get rid of seperator.
    
    [cell updateWithPost:self.posts[indexPath.row]];

    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 176;
}

#pragma mark - Camera

- (IBAction)cameraPressed:(id)sender {
    [self.delegate cameraShouldOpen];
}

@end