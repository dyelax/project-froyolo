//
//  ViewController.m
//  imageViewInTableView-Test
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "ViewController.h"
#import "FeedCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.imageView set
    
    return cell;
}

@end
