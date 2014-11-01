//
//  MapVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 10/31/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "MapVC.h"
#import "LocationService.h"

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIView *leftBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, self.view.bounds.size.height)];
    [self.view addSubview:leftBar];
    
    [self.mapView setCenterCoordinate:[LocationService sharedInstance].currentLocation.coordinate];
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


@end
