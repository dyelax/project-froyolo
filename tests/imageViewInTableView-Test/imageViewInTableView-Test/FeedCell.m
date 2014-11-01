//
//  FeedTVC.m
//  project-froyolo-iOS
//
//  Created by Matt Cooper on 11/1/14.
//  Copyright (c) 2014 Matthew Cooper. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell{
    UITapGestureRecognizer *tapGR;
}

- (void)awakeFromNib {
    // Initialization code
    
    tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewPhoto:)];
    [self.contentView addGestureRecognizer:tapGR];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (IBAction)upvote:(id)sender {
    
}
- (IBAction)downvote:(id)sender {
    
}

- (void)viewPhoto:(UITapGestureRecognizer *)sender{
    NSLog(@"VIEW!");
}

@end
