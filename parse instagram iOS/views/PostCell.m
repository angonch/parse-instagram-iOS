//
//  PostCell.m
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/3/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellPost:(Post *)passedInPost {
    if(passedInPost != nil) {
        self.post = passedInPost;
        PFUser *author = self.post.user;
    
        if(author != nil) {
            self.userLabel.text = author[@"username"];
        }
    self.postImageView.file = passedInPost[@"image"];
    [self.postImageView loadInBackground];
    self.descriptionLabel.text = passedInPost[@"description"];
    self.createdAtLabel.text = passedInPost[@"createdAtString"];
    }
}

@end
